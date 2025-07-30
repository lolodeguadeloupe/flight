import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../shared/data/datasources/remote_data_source.dart';
import '../../../../shared/data/models/claim_model.dart';
import '../../../../shared/data/models/user_model.dart';
import '../../../../shared/data/models/flight_model.dart';
import '../../../../shared/data/models/document_model.dart';

class ClaimRemoteDataSource implements RemoteDataSource {
  final Dio _dio;

  ClaimRemoteDataSource({Dio? dio}) : _dio = dio ?? DioClient.instance.dio;

  @override
  Future<List<ClaimModel>> getUserClaims(String userId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.claims,
        queryParameters: {'user_id': userId},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['claims'] ?? [];
        return data.map((json) => ClaimModel.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to fetch user claims',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndpoints.claims),
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<ClaimModel> getClaimDetails(String claimId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getClaimDetails(claimId),
      );

      if (response.statusCode == 200) {
        return ClaimModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Claim not found',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndpoints.getClaimDetails(claimId)),
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<ClaimModel> submitClaim(Map<String, dynamic> claimData) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.submitClaim,
        data: claimData,
      );

      if (response.statusCode == 201) {
        return ClaimModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to submit claim',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndpoints.submitClaim),
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<ClaimModel> updateClaim(String claimId, Map<String, dynamic> updates) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.getClaimDetails(claimId),
        data: updates,
      );

      if (response.statusCode == 200) {
        return ClaimModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to update claim',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndpoints.getClaimDetails(claimId)),
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
  Future<List<FlightModel>> searchFlights(Map<String, dynamic> searchParams) {
    throw UnimplementedError('Use FlightRemoteDataSource for flight operations');
  }

  @override
  Future<FlightModel> getFlightDetails(String flightId) {
    throw UnimplementedError('Use FlightRemoteDataSource for flight operations');
  }

  @override
  Future<Map<String, dynamic>> calculateCompensation(Map<String, dynamic> flightData) {
    throw UnimplementedError('Use FlightRemoteDataSource for flight operations');
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