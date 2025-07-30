import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/app_constants.dart';

class SupabaseConfig {
  static SupabaseClient? _client;
  
  static SupabaseClient get client {
    if (_client != null) return _client!;
    throw Exception('Supabase not initialized. Call SupabaseConfig.initialize() first.');
  }
  
  static Future<void> initialize() async {
    try {
      print('🔧 Initializing Supabase...');
      print('URL: ${AppConstants.supabaseUrl}');
      print('Key: ${AppConstants.supabaseAnonKey.substring(0, 20)}...');
      
      await Supabase.initialize(
        url: AppConstants.supabaseUrl,
        anonKey: AppConstants.supabaseAnonKey,
        debug: true, // Activé pour debug
        httpOptions: const HttpClientOptions(),
      );
      _client = Supabase.instance.client;
      print('✅ Supabase initialized successfully');
    } catch (error) {
      print('❌ Supabase initialization failed: $error');
      rethrow;
    }
  }
  
  // Quick access getters
  static SupabaseClient get instance => client;
  static GoTrueClient get auth => client.auth;
  static SupabaseStorageClient get storage => client.storage;
  static RealtimeClient get realtime => client.realtime;
  
  // Database operations shortcuts
  static SupabaseQueryBuilder from(String table) => client.from(table);
  
  // RPC (Edge Functions) calls
  static Future<T> rpc<T>(String functionName, {Map<String, dynamic>? params}) async {
    return await client.rpc<T>(functionName, params: params);
  }
}