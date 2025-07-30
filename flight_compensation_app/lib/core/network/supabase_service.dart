import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_client.dart';

class SupabaseService {
  // Example: Claims management
  static Future<Map<String, dynamic>?> createClaim({
    required String flightNumber,
    required String departureDate,
    required String departureAirport,
    required String arrivalAirport,
    required int delayDuration,
    required String delayReason,
    required String passengerName,
    required String passengerEmail,
    double? estimatedCompensation,
  }) async {
    try {
      final response = await SupabaseConfig.from('claims').insert({
        'flight_number': flightNumber,
        'departure_date': departureDate,
        'departure_airport': departureAirport,
        'arrival_airport': arrivalAirport,
        'delay_duration': delayDuration,
        'delay_reason': delayReason,
        'passenger_name': passengerName,
        'passenger_email': passengerEmail,
        'estimated_compensation': estimatedCompensation,
        'status': 'pending',
        'created_at': DateTime.now().toIso8601String(),
      }).select().single();
      
      return response;
    } on PostgrestException catch (error) {
      throw Exception('Failed to create claim: ${error.message}');
    } catch (error) {
      throw Exception('Unexpected error: $error');
    }
  }

  // Example: Get user claims
  static Future<List<Map<String, dynamic>>> getUserClaims(String userEmail) async {
    try {
      final response = await SupabaseConfig.from('claims')
          .select()
          .eq('passenger_email', userEmail)
          .order('created_at', ascending: false);
      
      return response;
    } on PostgrestException catch (error) {
      throw Exception('Failed to fetch claims: ${error.message}');
    }
  }

  // Example: Update claim status
  static Future<void> updateClaimStatus(int claimId, String status) async {
    try {
      await SupabaseConfig.from('claims')
          .update({'status': status, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', claimId);
    } on PostgrestException catch (error) {
      throw Exception('Failed to update claim: ${error.message}');
    }
  }

  // Example: Calculate compensation using Edge Function
  static Future<double> calculateCompensation({
    required String departureAirport,
    required String arrivalAirport,
    required int delayDuration,
    required String flightDate,
  }) async {
    try {
      final response = await SupabaseConfig.rpc<Map<String, dynamic>>(
        'calculate_compensation',
        params: {
          'departure_airport': departureAirport,
          'arrival_airport': arrivalAirport,
          'delay_duration': delayDuration,
          'flight_date': flightDate,
        },
      );
      
      return (response['compensation'] as num).toDouble();
    } on PostgrestException catch (error) {
      throw Exception('Failed to calculate compensation: ${error.message}');
    }
  }

  // Example: Authentication
  static Future<AuthResponse> signUpWithEmail(String email, String password) async {
    try {
      return await SupabaseConfig.auth.signUp(email: email, password: password);
    } on AuthException catch (error) {
      throw Exception('Sign up failed: ${error.message}');
    }
  }

  static Future<AuthResponse> signInWithEmail(String email, String password) async {
    try {
      return await SupabaseConfig.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (error) {
      throw Exception('Sign in failed: ${error.message}');
    }
  }

  static Future<void> signOut() async {
    try {
      await SupabaseConfig.auth.signOut();
    } on AuthException catch (error) {
      throw Exception('Sign out failed: ${error.message}');
    }
  }

  // Auth state changes stream
  static Stream<AuthState> authStateChanges() {
    return SupabaseConfig.auth.onAuthStateChange;
  }

  // Example: File upload for documents
  static Future<String> uploadDocument(String fileName, List<int> fileBytes) async {
    try {
      final filePath = 'documents/${DateTime.now().millisecondsSinceEpoch}_$fileName';
      
      // Convert List<int> to Uint8List
      final uint8List = Uint8List.fromList(fileBytes);
      
      await SupabaseConfig.storage
          .from('claim-documents')
          .uploadBinary(filePath, uint8List);
      
      return SupabaseConfig.storage
          .from('claim-documents')
          .getPublicUrl(filePath);
    } on StorageException catch (error) {
      throw Exception('Failed to upload document: ${error.message}');
    }
  }

  // Example: Real-time subscription to claim updates
  static RealtimeChannel subscribeToClaimUpdates(String userEmail, Function(Map<String, dynamic>) onUpdate) {
    return SupabaseConfig.realtime
        .channel('claim_updates')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'claims',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'passenger_email',
            value: userEmail,
          ),
          callback: (payload) => onUpdate(payload.newRecord),
        )
        .subscribe();
  }
}