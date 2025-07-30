import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../entities/flight.dart';

abstract class FlightRepository {
  Future<Either<Failure, List<Flight>>> searchFlights({
    required String flightNumber,
    required DateTime departureDate,
    String? departureAirport,
    String? arrivalAirport,
  });
  
  Future<Either<Failure, Flight>> getFlightDetails(String flightId);
  
  Future<Either<Failure, double>> calculateCompensation(Flight flight);
  
  Future<Either<Failure, bool>> validateFlightEligibility(Flight flight);
  
  Future<Either<Failure, List<Flight>?>> getCachedFlights(String searchKey);
  
  Future<Either<Failure, Flight?>> getCachedFlight(String flightId);
  
  Future<Either<Failure, void>> clearFlightCache();
}