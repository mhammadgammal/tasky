import 'package:dio/dio.dart';
import 'package:tasky/core/utils/api_utils/token_util.dart';

import 'api_end_points.dart';

class DioHelper {
  final Dio _dio;

  DioHelper(this._dio) {
    print('initializing dio');
    _init();
  }

  void _init() async {
    _dio.options.baseUrl = ApiEndPoints.baseUrl;
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    bool isRefresh = (url == ApiEndPoints.refreshToken);
    print('is refresh token: $url $isRefresh');
    if (!isRefresh) {
      _dio.options.headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${await TokenUtil.getToken()}"
      };
    }
    return await _dio.get(url, queryParameters: query);
  }

  Future<Response> post({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
  }) async {
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await TokenUtil.getToken()}"
    };
    return await _dio.post(url, queryParameters: query, data: data);
  }

  Future<Response> put({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await TokenUtil.getToken()}"
    };
    return await _dio.put(url, queryParameters: query, data: data);
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await TokenUtil.getToken()}"
    };
    return await _dio.delete(url, queryParameters: query, data: data);
  }
}
