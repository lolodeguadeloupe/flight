class AppConstants {
  static const String appName = 'FlightCompensation';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.flightcompensation.com';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Supabase Configuration
  static String get supabaseUrl => const String.fromEnvironment('SUPABASE_URL', defaultValue: 'https://flight-supabase.laurent-luce.com');
  static String get supabaseAnonKey => const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzdXBhYmFzZSIsImlhdCI6MTc1MzgwMjIyMCwiZXhwIjo0OTA5NDc1ODIwLCJyb2xlIjoiYW5vbiJ9.SnrtmOKddGyC-5jFGajEqZTLb8Qyz9L1IhbxsQ0AfeU');
  // Compensation Rules (EC261)
  static const Map<String, double> ec261Compensation = {
    'short_haul': 250.0,      // < 1500km
    'medium_haul': 400.0,     // 1500-3500km  
    'long_haul': 600.0,       // > 3500km
  };
  
  // Distance thresholds (km)
  static const int shortHaulMaxDistance = 1500;
  static const int mediumHaulMaxDistance = 3500;
  
  // Delay thresholds
  static const Duration minimumDelayForCompensation = Duration(hours: 3);
  static const Duration longHaulDelayThreshold = Duration(hours: 4);
  
  // File upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedFileTypes = [
    'pdf', 'jpg', 'jpeg', 'png'
  ];
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const Duration animationDuration = Duration(milliseconds: 300);
}