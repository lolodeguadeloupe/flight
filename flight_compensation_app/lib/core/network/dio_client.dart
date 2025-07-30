import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';
import '../error/failures.dart';

class DioClient {
  static DioClient? _instance;
  static DioClient get instance => _instance ??= DioClient._internal();
  
  late final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  DioClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': '${AppConstants.appName}/${AppConstants.appVersion}',
      },
    ));
    
    _setupInterceptors();
  }
  
  Dio get dio => _dio;
  
  void _setupInterceptors() {
    // Request/Response logging interceptor (debug only)
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
      logPrint: (object) {
        // Only log in debug mode
        assert(() {
          print('[DIO] $object');
          return true;
        }());
      },
    ));

    // Auth interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available
        final token = await _storage.read(key: 'auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        // Add request ID for tracking
        options.headers['X-Request-ID'] = _generateRequestId();
        
        handler.next(options);
      },
      onResponse: (response, handler) async {
        // Log successful responses
        assert(() {
          print('[DIO] ✅ ${response.requestOptions.method} ${response.requestOptions.path} - ${response.statusCode}');
          return true;
        }());
        handler.next(response);
      },
      onError: (error, handler) async {
        // Handle auth errors
        if (error.response?.statusCode == 401) {
          await _handleUnauthorized();
        }

        // Log errors
        assert(() {
          print('[DIO] ❌ ${error.requestOptions.method} ${error.requestOptions.path} - ${error.response?.statusCode ?? 'NO_RESPONSE'}');
          return true;
        }());

        handler.next(error);
      },
    ));
    
    // Retry interceptor with exponential backoff
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        if (_shouldRetry(error) && !_hasRetryAttempted(error.requestOptions)) {
          final delayMs = _calculateRetryDelay(_getRetryCount(error.requestOptions));
          await Future.delayed(Duration(milliseconds: delayMs));

          try {
            // Mark as retry attempted
            error.requestOptions.extra['retry_attempted'] = true;
            error.requestOptions.extra['retry_count'] = _getRetryCount(error.requestOptions) + 1;
            
            final response = await _dio.fetch(error.requestOptions);
            handler.resolve(response);
          } catch (e) {
            handler.next(error);
          }
        } else {
          handler.next(error);
        }
      },
    ));

    // Response caching interceptor (for GET requests)
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) async {
        if (response.requestOptions.method == 'GET' && 
            response.statusCode == 200 &&
            _shouldCacheResponse(response.requestOptions.path)) {
          // TODO: Implement response caching logic
        }
        handler.next(response);
      },
    ));
  }
  
  bool _shouldRetry(DioException error) {
    // Retry on network timeouts
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return true;
    }

    // Retry on server errors (5xx)
    final statusCode = error.response?.statusCode;
    if (statusCode != null && statusCode >= 500 && statusCode < 600) {
      return true;
    }

    // Retry on connection errors
    if (error.type == DioExceptionType.connectionError) {
      return true;
    }

    return false;
  }

  bool _hasRetryAttempted(RequestOptions options) {
    return options.extra['retry_attempted'] == true;
  }

  int _getRetryCount(RequestOptions options) {
    return options.extra['retry_count'] ?? 0;
  }

  int _calculateRetryDelay(int retryCount) {
    // Exponential backoff: 1s, 2s, 4s, max 8s
    return (1000 * (1 << retryCount)).clamp(1000, 8000);
  }

  String _generateRequestId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<void> _handleUnauthorized() async {
    // Try to refresh token first
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken != null) {
      try {
        // TODO: Implement token refresh logic
        await _refreshToken(refreshToken);
      } catch (e) {
        // If refresh fails, clear all tokens
        await _clearAuthTokens();
      }
    } else {
      // No refresh token, clear everything
      await _clearAuthTokens();
    }
  }

  Future<void> _refreshToken(String refreshToken) async {
    // TODO: Implement actual token refresh API call
    throw UnimplementedError('Token refresh not implemented yet');
  }

  Future<void> _clearAuthTokens() async {
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'refresh_token');
    await _storage.delete(key: 'user_id');
  }

  bool _shouldCacheResponse(String path) {
    // Cache flight search results and flight details
    return path.contains('flights') ||
           path.contains('airports') ||
           path.contains('airlines');
  }

  // Public method to clear auth state
  Future<void> clearAuth() async {
    await _clearAuthTokens();
  }

  // Public method to set auth token
  Future<void> setAuthToken(String token, {String? refreshToken}) async {
    await _storage.write(key: 'auth_token', value: token);
    if (refreshToken != null) {
      await _storage.write(key: 'refresh_token', value: refreshToken);
    }
  }
}