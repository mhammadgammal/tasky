part of '../dio_helper.dart';

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor(this._dio);

  /// The main, interceptor-attached Dio used to replay failed requests.
  final Dio _dio;

  /// A bare Dio (no interceptors) used only for the refresh call itself,
  /// so a failing refresh can't recursively re-enter this interceptor.
  final Dio _refreshDio = Dio()..options.baseUrl = ApiEndPoints.baseUrl;

  Future<String>? _refreshing;

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final isRetry = err.requestOptions.extra['isRetry'] == true;
    if (err.requestOptions.path == ApiEndPoints.login || err.requestOptions.path == ApiEndPoints.register) {
      return handler.next(err);
    }
    if (err.response?.statusCode != 401 || isRetry) {
      return handler.next(err);
    }

    try {
      await _refreshToken();
      final retryOptions = err.requestOptions..extra['isRetry'] = true;
      final response = await _dio.fetch(retryOptions);
      return handler.resolve(response);
    } catch (_) {
      await _handleUnrecoverableSession();
      return handler.reject(err);
    }
  }

  Future<String> _refreshToken() {
    return _refreshing ??= _performRefresh().whenComplete(() {
      _refreshing = null;
    });
  }

  Future<String> _performRefresh() async {
    final refreshToken =
        sl<CacheHelper>().getString(key: CacheKeys.refreshToken) ?? '';
    if (refreshToken.isEmpty) {
      throw DioException(
          requestOptions: RequestOptions(path: ApiEndPoints.refreshToken));
    }

    final response = await _refreshDio
        .get(ApiEndPoints.refreshToken, queryParameters: {'token': refreshToken});
    final newAccessToken = response.data['access_token'] as String;
    await sl<CacheHelper>().putString(key: CacheKeys.token, value: newAccessToken);
    return newAccessToken;
  }

  Future<void> _handleUnrecoverableSession() async {
    await sl<CacheHelper>().removeCached(key: CacheKeys.token);
    await sl<CacheHelper>().removeCached(key: CacheKeys.refreshToken);

    showToast('Session Ended, Please Sign in again');
    await AppNavigator.navigateAndFinishToLogin();
  }
}
