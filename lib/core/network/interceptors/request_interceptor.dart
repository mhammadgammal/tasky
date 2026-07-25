part of '../dio_helper.dart';

class RequestInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = sl<CacheHelper>().getString(key: CacheKeys.token);

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers.putIfAbsent('Content-Type', () => 'application/json');
    // Set the Accept-Language header
    options.headers['accept-language'] = 'en';

    // Set timeout and error handling behavior
    options.receiveDataWhenStatusError = true;
    options.connectTimeout = const Duration(seconds: 30);
    options.sendTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);

    // Call the next interceptor
    return super.onRequest(options, handler);
  }
}
