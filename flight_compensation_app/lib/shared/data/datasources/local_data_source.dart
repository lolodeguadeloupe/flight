import '../models/user_model.dart';
import '../models/flight_model.dart';
import '../models/claim_model.dart';
import '../models/document_model.dart';

abstract class LocalDataSource {
  // User cache
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser(String userId);
  Future<void> clearUserCache();
  
  // Flight cache
  Future<void> cacheFlights(List<FlightModel> flights, String searchKey);
  Future<List<FlightModel>?> getCachedFlights(String searchKey);
  Future<void> cacheFlight(FlightModel flight);
  Future<FlightModel?> getCachedFlight(String flightId);
  
  // Claim cache
  Future<void> cacheClaims(List<ClaimModel> claims, String userId);
  Future<List<ClaimModel>?> getCachedClaims(String userId);
  Future<void> cacheClaim(ClaimModel claim);
  Future<ClaimModel?> getCachedClaim(String claimId);
  
  // Document cache
  Future<void> cacheDocument(DocumentModel document);
  Future<DocumentModel?> getCachedDocument(String documentId);
  Future<void> cacheDocumentFile(String documentId, String localPath);
  Future<String?> getDocumentLocalPath(String documentId);
  
  // Draft management
  Future<void> saveDraftClaim(ClaimModel draftClaim);
  Future<ClaimModel?> getDraftClaim(String userId);
  Future<void> clearDraftClaim(String userId);
  
  // Offline queue
  Future<void> addToOfflineQueue(Map<String, dynamic> action);
  Future<List<Map<String, dynamic>>> getOfflineQueue();
  Future<void> removeFromOfflineQueue(String actionId);
  Future<void> clearOfflineQueue();
  
  // Cache management
  Future<void> clearExpiredCache();
  Future<void> clearAllCache();
  Future<int> getCacheSize();
}