part of '../dio_helper.dart';

class RequestInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = sl<CacheHelper>().getString(key: CacheKeys.token) ?? '';
    options.headers['Authorization'] = 'Bearer $token';
    options.headers.putIfAbsent('Content-Type', () => 'application/json');
    return super.onRequest(options, handler);
  }
}
