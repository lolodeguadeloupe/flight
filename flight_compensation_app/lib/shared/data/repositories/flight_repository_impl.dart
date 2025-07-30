import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/flight_repository.dart';
import '../../domain/entities/flight.dart';
import '../../../core/error/failures.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/flight_model.dart';

class FlightRepositoryImpl implements FlightRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  FlightRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Flight>>> searchFlights({
    required String flightNumber,
    required DateTime departureDate,
    String? departureAirport,
    String? arrivalAirport,
  }) async {
    final searchKey = _generateSearchKey(
      flightNumber,
      departureDate,
      departureAirport,
      arrivalAirport,
    );

    try {
      // Vérifier le cache local d'abord
      final cachedFlights = await localDataSource.getCachedFlights(searchKey);
      if (cachedFlights != null && cachedFlights.isNotEmpty) {
        return Right(cachedFlights.map((model) => model.toEntity()).toList());
      }

      // Recherche via l'API distante
      final searchParams = {
        'flight_number': flightNumber,
        'departure_date': departureDate.toIso8601String(),
        if (departureAirport != null) 'departure_airport': departureAirport,
        if (arrivalAirport != null) 'arrival_airport': arrivalAirport,
      };

      final flightModels = await remoteDataSource.searchFlights(searchParams);
      final flights = flightModels.map((model) => model.toEntity()).toList();

      // Mettre en cache les résultats
      await localDataSource.cacheFlights(flightModels, searchKey);

      return Right(flights);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(Failure.unknown(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Flight>> getFlightDetails(String flightId) async {
    try {
      // Vérifier le cache local d'abord
      final cachedFlight = await localDataSource.getCachedFlight(flightId);
      if (cachedFlight != null) {
        return Right(cachedFlight.toEntity());
      }

      // Récupérer depuis l'API distante
      final flightModel = await remoteDataSource.getFlightDetails(flightId);
      final flight = flightModel.toEntity();

      // Mettre en cache
      await localDataSource.cacheFlight(flightModel);

      return Right(flight);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(Failure.unknown(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, double>> calculateCompensation(Flight flight) async {
    try {
      // Calcul local d'abord (logique métier dans l'entité)
      final localCalculation = flight.calculatedCompensationAmount;
      
      // Vérification via l'API pour validation
      final flightData = {
        'flight_number': flight.flightNumber,
        'distance_km': flight.distanceKm,
        'jurisdiction': flight.jurisdiction.name,
        'delay_duration': flight.arrivalDelayDuration?.inMinutes,
        'delay_reason': flight.delayReason?.name,
      };

      final result = await remoteDataSource.calculateCompensation(flightData);
      final serverCalculation = result['compensation_amount']?.toDouble() ?? 0.0;

      // Prendre la valeur la plus conservative (sécurité juridique)
      final finalAmount = localCalculation < serverCalculation 
          ? localCalculation 
          : serverCalculation;

      return Right(finalAmount);
    } on DioException catch (e) {
      // En cas d'erreur réseau, utiliser le calcul local
      return Right(flight.calculatedCompensationAmount);
    } catch (e) {
      return Left(Failure.compensation(
        message: 'Failed to calculate compensation: $e',
        flightNumber: flight.flightNumber,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> validateFlightEligibility(Flight flight) async {
    try {
      // Validation locale basée sur les règles métier
      final isLocallyEligible = flight.isEligibleForCompensation;
      
      // TODO: Ajouter validation serveur si nécessaire
      // Pour l'instant, nous nous fions à la logique locale
      
      return Right(isLocallyEligible);
    } catch (e) {
      return Left(Failure.validation(
        message: 'Failed to validate flight eligibility: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, List<Flight>?>> getCachedFlights(String searchKey) async {
    try {
      final cachedFlights = await localDataSource.getCachedFlights(searchKey);
      if (cachedFlights == null) {
        return const Right(null);
      }
      return Right(cachedFlights.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(Failure.cache(
        message: 'Failed to get cached flights: $e',
        key: searchKey,
      ));
    }
  }

  @override
  Future<Either<Failure, Flight?>> getCachedFlight(String flightId) async {
    try {
      final cachedFlight = await localDataSource.getCachedFlight(flightId);
      if (cachedFlight == null) {
        return const Right(null);
      }
      return Right(cachedFlight.toEntity());
    } catch (e) {
      return Left(Failure.cache(
        message: 'Failed to get cached flight: $e',
        key: flightId,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> clearFlightCache() async {
    try {
      // TODO: Implémenter clearFlightCache dans LocalDataSource
      return const Right(null);
    } catch (e) {
      return Left(Failure.cache(message: 'Failed to clear flight cache: $e'));
    }
  }

  String _generateSearchKey(
    String flightNumber,
    DateTime departureDate,
    String? departureAirport,
    String? arrivalAirport,
  ) {
    return '${flightNumber}_${departureDate.toIso8601String().split('T')[0]}_${departureAirport ?? ''}_${arrivalAirport ?? ''}';
  }

  Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Failure.timeout(
          message: 'Request timeout',
          duration: Duration(milliseconds: e.requestOptions.connectTimeout ?? 0),
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return Failure.notFound(
            message: 'Flight not found',
            resource: 'flight',
          );
        } else if (statusCode == 401) {
          return const Failure.unauthorized(message: 'Authentication required');
        } else {
          return Failure.server(
            message: e.response?.data?['message'] ?? 'Server error',
            statusCode: statusCode,
            endpoint: e.requestOptions.path,
          );
        }
      case DioExceptionType.connectionError:
        return Failure.network(
          message: 'Network connection error',
          endpoint: e.requestOptions.path,
        );
      case DioExceptionType.cancel:
        return const Failure.unknown(message: 'Request was cancelled');
      case DioExceptionType.badCertificate:
        return const Failure.network(message: 'Certificate verification failed');
      case DioExceptionType.unknown:
      default:
        return Failure.unknown(
          message: e.message ?? 'Unknown error occurred',
          originalError: e,
        );
    }
  }
}