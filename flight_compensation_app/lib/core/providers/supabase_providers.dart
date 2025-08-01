import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../network/supabase_client.dart';

// ============================================================================
// Supabase Core Providers
// ============================================================================

/// Provider for the main Supabase client instance
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return SupabaseConfig.client;
});

/// Provider for Supabase Auth client
final supabaseAuthProvider = Provider<GoTrueClient>((ref) {
  return SupabaseConfig.auth;
});

/// Provider for Supabase Storage client
final supabaseStorageProvider = Provider<SupabaseStorageClient>((ref) {
  return SupabaseConfig.storage;
});

/// Provider for Supabase Realtime client
final supabaseRealtimeProvider = Provider<RealtimeClient>((ref) {
  return SupabaseConfig.realtime;
});

// ============================================================================
// Database Table Providers
// ============================================================================

/// Provider for Claims table operations
final claimsTableProvider = Provider<SupabaseQueryBuilder>((ref) {
  return SupabaseConfig.from('claims');
});

/// Provider for Users table operations
final usersTableProvider = Provider<SupabaseQueryBuilder>((ref) {
  return SupabaseConfig.from('profiles'); // Assuming user profiles table
});

/// Provider for Documents table operations
final documentsTableProvider = Provider<SupabaseQueryBuilder>((ref) {
  return SupabaseConfig.from('documents');
});

/// Provider for Flights table operations
final flightsTableProvider = Provider<SupabaseQueryBuilder>((ref) {
  return SupabaseConfig.from('flights');
});

// ============================================================================
// Storage Bucket Providers
// ============================================================================

/// Provider for claim documents storage bucket
final claimDocumentsStorageProvider = Provider((ref) {
  return SupabaseConfig.storage.from('claim-documents');
});

/// Provider for user avatars storage bucket
final userAvatarsStorageProvider = Provider((ref) {
  return SupabaseConfig.storage.from('avatars');
});

// ============================================================================
// Real-time Subscription Providers
// ============================================================================

/// Provider for real-time claim updates for a specific user
final claimUpdatesProvider = StreamProvider.family<Map<String, dynamic>, String>((ref, userId) {
  final channel = SupabaseConfig.realtime
      .channel('claim_updates_$userId')
      .onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'claims',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'user_id',
          value: userId,
        ),
        callback: (payload) {
          // This will be handled by the stream controller
        },
      );

  // Subscribe to the channel
  channel.subscribe();

  // Return a simple stream for now - real-time updates would need more complex setup
  return Stream.empty();
});

/// Provider for real-time authentication state changes
final realtimeAuthStateProvider = StreamProvider<AuthState>((ref) {
  return SupabaseConfig.auth.onAuthStateChange;
});

// ============================================================================
// Edge Functions Providers
// ============================================================================

/// Provider for calling Edge Functions
final edgeFunctionsProvider = Provider<EdgeFunctionsService>((ref) {
  return EdgeFunctionsService();
});

/// Service class for Edge Functions operations
class EdgeFunctionsService {
  /// Calculate compensation using Edge Function
  Future<Map<String, dynamic>> calculateCompensation({
    required String departureAirport,
    required String arrivalAirport,
    required int delayDuration,
    required String flightDate,
  }) async {
    return await SupabaseConfig.rpc<Map<String, dynamic>>(
      'calculate_compensation',
      params: {
        'departure_airport': departureAirport,
        'arrival_airport': arrivalAirport,
        'delay_duration': delayDuration,
        'flight_date': flightDate,
      },
    );
  }

  /// Process document using OCR Edge Function
  Future<Map<String, dynamic>> processDocument({
    required String documentUrl,
    required String documentType,
  }) async {
    return await SupabaseConfig.rpc<Map<String, dynamic>>(
      'process_document',
      params: {
        'document_url': documentUrl,
        'document_type': documentType,
      },
    );
  }

  /// Send email notification using Edge Function
  Future<Map<String, dynamic>> sendEmailNotification({
    required String recipientEmail,
    required String templateId,
    required Map<String, dynamic> templateData,
  }) async {
    return await SupabaseConfig.rpc<Map<String, dynamic>>(
      'send_email_notification',
      params: {
        'recipient_email': recipientEmail,
        'template_id': templateId,
        'template_data': templateData,
      },
    );
  }

  /// Validate flight information using external APIs
  Future<Map<String, dynamic>> validateFlight({
    required String flightNumber,
    required String flightDate,
  }) async {
    return await SupabaseConfig.rpc<Map<String, dynamic>>(
      'validate_flight',
      params: {
        'flight_number': flightNumber,
        'flight_date': flightDate,
      },
    );
  }
}

// ============================================================================
// Database Health and Status Providers
// ============================================================================

/// Provider to check database connection health
final databaseHealthProvider = FutureProvider<bool>((ref) async {
  try {
    // Simple health check query
    await SupabaseConfig.from('claims').select('id').limit(1);
    return true;
  } catch (e) {
    return false;
  }
});

/// Provider for database statistics
final databaseStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  try {
    final stats = await SupabaseConfig.rpc<Map<String, dynamic>>('get_database_stats');
    return stats;
  } catch (e) {
    return <String, dynamic>{};
  }
});