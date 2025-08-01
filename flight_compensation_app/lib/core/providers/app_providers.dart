import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/supabase_client.dart';

// ============================================================================
// App Initialization Providers
// ============================================================================

/// Provider that handles app initialization including Supabase setup
final appInitializationProvider = FutureProvider<bool>((ref) async {
  try {
    // Initialize Supabase if not already initialized
    await SupabaseConfig.initialize();
    
    // Add any other initialization logic here
    // For example: local storage, analytics, crash reporting, etc.
    
    return true;
  } catch (e) {
    // Log the error and return false
    print('❌ App initialization failed: $e');
    return false;
  }
});

/// Provider for app configuration status
final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig();
});

/// Configuration class for app-wide settings
class AppConfig {
  // Environment-specific settings
  bool get isProduction => const bool.fromEnvironment('dart.vm.product');
  bool get isDebug => !isProduction;
  bool get isSupabaseEnabled => true; // Can be made configurable
  
  // Feature flags
  bool get isRealtimeEnabled => true;
  bool get isOfflineModeEnabled => true;
  bool get isAnalyticsEnabled => isProduction;
  bool get isCrashReportingEnabled => isProduction;
  
  // UI Configuration
  Duration get defaultAnimationDuration => const Duration(milliseconds: 300);
  int get maxRetryAttempts => 3;
  Duration get cacheTimeout => const Duration(hours: 1);
  
  // Business Logic Configuration
  Duration get sessionTimeout => const Duration(hours: 24);
  int get maxFileUploadSizeMB => 10;
  List<String> get supportedFileTypes => ['pdf', 'jpg', 'jpeg', 'png'];
}

/// Provider for checking if the app is ready to use
final appReadyProvider = FutureProvider<bool>((ref) async {
  // Wait for app initialization
  final initialized = await ref.watch(appInitializationProvider.future);
  
  if (!initialized) {
    return false;
  }
  
  // Check if Supabase is properly connected
  try {
    await SupabaseConfig.from('claims').select('id').limit(1);
    return true;
  } catch (e) {
    print('⚠️ Supabase connection check failed: $e');
    return false;
  }
});