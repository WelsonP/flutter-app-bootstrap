import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../errors/app_exception.dart';
import '../logging/app_logger.dart';
import 'package:logging/logging.dart';

/// Dio client provider configured with auth, logging, and error interceptors.
final dioClientProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ));

  // Auth token interceptor — attaches Supabase access token
  dio.interceptors.add(AuthInterceptor(ref));

  // Logging interceptor
  dio.interceptors.add(LoggingInterceptor());

  // Error interceptor — maps DioException to AppException
  dio.interceptors.add(ErrorInterceptor());

  return dio;
});

/// Interceptor that attaches the Supabase access token to outgoing requests.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.ref);

  final Ref ref;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) {
        options.headers['Authorization'] = 'Bearer ${session.accessToken}';
      }
    } catch (_) {
      // Supabase not initialized or no session — proceed without token
    }
    handler.next(options);
  }
}

/// Interceptor that logs request/response details.
class LoggingInterceptor extends Interceptor {
  final _logger = Logger('DioClient');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.fine('→ ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.fine('← ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.warning(
      '✗ ${err.response?.statusCode} ${err.requestOptions.uri}: ${err.message}',
    );
    handler.next(err);
  }
}

/// Interceptor that maps DioException to domain-specific AppException subtypes.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            response: err.response,
            error: NetworkException(
              'Connection failed. Please check your internet connection.',
              statusCode: err.response?.statusCode,
            ),
            type: err.type,
          ),
        );
        return;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode == 401) {
          handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              response: err.response,
              error: AuthException('Authentication failed. Please log in again.'),
              type: err.type,
            ),
          );
          return;
        }
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            response: err.response,
            error: NetworkException(
              'Server error (${statusCode ?? 'unknown'}). Please try again later.',
              statusCode: statusCode,
            ),
            type: err.type,
          ),
        );
        return;
      default:
        handler.next(err);
    }
  }
}
