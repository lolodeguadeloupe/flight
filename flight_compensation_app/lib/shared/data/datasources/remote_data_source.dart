import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/flight_model.dart';
import '../models/claim_model.dart';
import '../models/document_model.dart';

abstract class RemoteDataSource {
  // Auth endpoints
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(Map<String, dynamic> userData);
  Future<void> logout();
  Future<String> refreshToken(String refreshToken);
  
  // User endpoints
  Future<UserModel> getUserProfile(String userId);
  Future<UserModel> updateUserProfile(String userId, Map<String, dynamic> data);
  
  // Flight endpoints
  Future<List<FlightModel>> searchFlights(Map<String, dynamic> searchParams);
  Future<FlightModel> getFlightDetails(String flightId);
  Future<Map<String, dynamic>> calculateCompensation(Map<String, dynamic> flightData);
  
  // Claim endpoints
  Future<List<ClaimModel>> getUserClaims(String userId);
  Future<ClaimModel> getClaimDetails(String claimId);
  Future<ClaimModel> submitClaim(Map<String, dynamic> claimData);
  Future<ClaimModel> updateClaim(String claimId, Map<String, dynamic> updates);
  
  // Document endpoints
  Future<DocumentModel> uploadDocument(String filePath, Map<String, dynamic> metadata);
  Future<DocumentModel> getDocumentDetails(String documentId);
  Future<void> deleteDocument(String documentId);
}