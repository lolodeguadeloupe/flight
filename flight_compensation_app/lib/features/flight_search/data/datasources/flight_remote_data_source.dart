import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../shared/data/datasources/remote_data_source.dart';
import '../../../../shared/data/models/flight_model.dart';
import '../../../../shared/data/models/user_model.dart';
import '../../../../shared/data/models/claim_model.dart';
import '../../../../shared/data/models/document_model.dart';

class FlightRemoteDataSource implements RemoteDataSource {
  final Dio _dio;

  FlightRemoteDataSource({Dio? dio}) : _dio = dio ?? DioClient.instance.dio;

  @override
  Future<List<FlightModel>> searchFlights(Map<String, dynamic> searchParams) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.searchFlight,
        queryParameters: searchParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['flights'] ?? [];
        return data.map((json) => FlightModel.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to search flights',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndpoints.searchFlight),
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<FlightModel> getFlightDetails(String flightId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getFlightDetails(flightId),
      );

      if (response.statusCode == 200) {
        return FlightModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Flight not found',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndpoints.getFlightDetails(flightId)),
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> calculateCompensation(Map<String, dynamic> flightData) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.calculateCompensation,
        data: flightData,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to calculate compensation',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndpoints.calculateCompensation),
        message: 'Unexpected error: $e',
      );
    }
  }

  // Méthodes non implémentées pour cette classe spécialisée
  @override
  Future<UserModel> login(String email, String password) {
    throw UnimplementedError('Use AuthRemoteDataSource for auth operations');
  }

  @override
  Future<UserModel> register(Map<String, dynamic> userData) {
    throw UnimplementedError('Use AuthRemoteDataSource for auth operations');
  }

  @override
  Future<void> logout() {
    throw UnimplementedError('Use AuthRemoteDataSource for auth operations');
  }

  @override
  Future<String> refreshToken(String refreshToken) {
    throw UnimplementedError('Use AuthRemoteDataSource for auth operations');
  }

  @override
  Future<UserModel> getUserProfile(String userId) {
    throw UnimplementedError('Use UserRemoteDataSource for user operations');
  }

  @override
  Future<UserModel> updateUserProfile(String userId, Map<String, dynamic> data) {
    throw UnimplementedError('Use UserRemoteDataSource for user operations');
  }

  @override
  Future<List<ClaimModel>> getUserClaims(String userId) {
    throw UnimplementedError('Use ClaimRemoteDataSource for claim operations');
  }

  @override
  Future<ClaimModel> getClaimDetails(String claimId) {
    throw UnimplementedError('Use ClaimRemoteDataSource for claim operations');
  }

  @override
  Future<ClaimModel> submitClaim(Map<String, dynamic> claimData) {
    throw UnimplementedError('Use ClaimRemoteDataSource for claim operations');
  }

  @override
  Future<ClaimModel> updateClaim(String claimId, Map<String, dynamic> updates) {
    throw UnimplementedError('Use ClaimRemoteDataSource for claim operations');
  }

  @override
  Future<DocumentModel> uploadDocument(String filePath, Map<String, dynamic> metadata) {
    throw UnimplementedError('Use DocumentRemoteDataSource for document operations');
  }

  @override
  Future<DocumentModel> getDocumentDetails(String documentId) {
    throw UnimplementedError('Use DocumentRemoteDataSource for document operations');
  }

  @override
  Future<void> deleteDocument(String documentId) {
    throw UnimplementedError('Use DocumentRemoteDataSource for document operations');
  }
}