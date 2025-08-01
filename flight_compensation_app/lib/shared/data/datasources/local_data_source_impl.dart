import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_data_source.dart';
import '../models/user_model.dart';
import '../models/flight_model.dart';
import '../models/claim_model.dart';
import '../models/document_model.dart';

class LocalDataSourceImpl implements LocalDataSource {
  static const String _userPrefix = 'user_';
  static const String _flightPrefix = 'flight_';
  static const String _claimPrefix = 'claim_';
  static const String _documentPrefix = 'document_';
  static const String _draftPrefix = 'draft_';
  static const String _offlineQueueKey = 'offline_queue';
  static const String _flightSearchPrefix = 'flight_search_';
  static const String _userClaimsPrefix = 'user_claims_';

  @override
  Future<void> cacheUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_userPrefix${user.id}';
    await prefs.setString(key, jsonEncode(user.toJson()));
  }

  @override
  Future<UserModel?> getCachedUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_userPrefix$userId';
    final jsonString = prefs.getString(key);
    
    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    }
    return null;
  }

  @override
  Future<void> clearUserCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(_userPrefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }

  @override
  Future<void> cacheFlights(List<FlightModel> flights, String searchKey) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_flightSearchPrefix$searchKey';
    final jsonList = flights.map((flight) => flight.toJson()).toList();
    await prefs.setString(key, jsonEncode(jsonList));
  }

  @override
  Future<List<FlightModel>?> getCachedFlights(String searchKey) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_flightSearchPrefix$searchKey';
    final jsonString = prefs.getString(key);
    
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => FlightModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return null;
  }

  @override
  Future<void> cacheFlight(FlightModel flight) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_flightPrefix${flight.flightNumber}';
    await prefs.setString(key, jsonEncode(flight.toJson()));
  }

  @override
  Future<FlightModel?> getCachedFlight(String flightId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_flightPrefix$flightId';
    final jsonString = prefs.getString(key);
    
    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return FlightModel.fromJson(json);
    }
    return null;
  }

  @override
  Future<void> cacheClaims(List<ClaimModel> claims, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_userClaimsPrefix$userId';
    final jsonList = claims.map((claim) => claim.toJson()).toList();
    await prefs.setString(key, jsonEncode(jsonList));
  }

  @override
  Future<List<ClaimModel>?> getCachedClaims(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_userClaimsPrefix$userId';
    final jsonString = prefs.getString(key);
    
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => ClaimModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return null;
  }

  @override
  Future<void> cacheClaim(ClaimModel claim) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_claimPrefix${claim.id}';
    await prefs.setString(key, jsonEncode(claim.toJson()));
  }

  @override
  Future<ClaimModel?> getCachedClaim(String claimId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_claimPrefix$claimId';
    final jsonString = prefs.getString(key);
    
    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return ClaimModel.fromJson(json);
    }
    return null;
  }

  @override
  Future<void> cacheDocument(DocumentModel document) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_documentPrefix${document.id}';
    await prefs.setString(key, jsonEncode(document.toJson()));
  }

  @override
  Future<DocumentModel?> getCachedDocument(String documentId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_documentPrefix$documentId';
    final jsonString = prefs.getString(key);
    
    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return DocumentModel.fromJson(json);
    }
    return null;
  }

  @override
  Future<void> cacheDocumentFile(String documentId, String localPath) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_documentPrefix}path_$documentId';
    await prefs.setString(key, localPath);
  }

  @override
  Future<String?> getDocumentLocalPath(String documentId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_documentPrefix}path_$documentId';
    return prefs.getString(key);
  }

  @override
  Future<void> saveDraftClaim(ClaimModel draftClaim) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_draftPrefix${draftClaim.userId}';
    await prefs.setString(key, jsonEncode(draftClaim.toJson()));
  }

  @override
  Future<ClaimModel?> getDraftClaim(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_draftPrefix$userId';
    final jsonString = prefs.getString(key);
    
    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return ClaimModel.fromJson(json);
    }
    return null;
  }

  @override
  Future<void> clearDraftClaim(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_draftPrefix$userId';
    await prefs.remove(key);
  }

  @override
  Future<void> addToOfflineQueue(Map<String, dynamic> action) async {
    final prefs = await SharedPreferences.getInstance();
    final currentQueue = await getOfflineQueue();
    currentQueue.add(action);
    await prefs.setString(_offlineQueueKey, jsonEncode(currentQueue));
  }

  @override
  Future<List<Map<String, dynamic>>> getOfflineQueue() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_offlineQueueKey);
    
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  @override
  Future<void> removeFromOfflineQueue(String actionId) async {
    final prefs = await SharedPreferences.getInstance();
    final currentQueue = await getOfflineQueue();
    currentQueue.removeWhere((action) => action['id'] == actionId);
    await prefs.setString(_offlineQueueKey, jsonEncode(currentQueue));
  }

  @override
  Future<void> clearOfflineQueue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_offlineQueueKey);
  }

  @override
  Future<void> clearExpiredCache() async {
    // For now, this is a simple implementation
    // In a more sophisticated version, you'd check timestamps
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => 
      key.startsWith(_flightSearchPrefix) ||
      key.startsWith(_userClaimsPrefix)
    );
    
    for (final key in keys) {
      await prefs.remove(key);
    }
  }

  @override
  Future<void> clearAllCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Future<int> getCacheSize() async {
    final prefs = await SharedPreferences.getInstance();
    var totalSize = 0;
    
    for (final key in prefs.getKeys()) {
      final value = prefs.getString(key);
      if (value != null) {
        totalSize += value.length;
      }
    }
    
    return totalSize;
  }
}