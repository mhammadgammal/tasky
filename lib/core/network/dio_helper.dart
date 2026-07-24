import 'package:dio/dio.dart';
import 'package:tasky/core/network/token_util.dart';

import 'api_end_points.dart';

class DioHelper {
  final Dio _dio;

  DioHelper(this._dio) {
    _init();
  }

  void _init() async {
    _dio.options.baseUrl = ApiEndPoints.baseUrl;
  }

  Future<Response> get(String url,{
    Map<String, dynamic>? query,
  }) async {
    bool isRefresh = (url == ApiEndPoints.refreshToken);
    if (!isRefresh) {
      _dio.options.headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${await TokenUtil.getToken()}"
      };
    }
    return await _dio.get(url, queryParameters: query);
  }

  Future<Response> post(String url,{
    Map<String, dynamic>? query,
    required dynamic data,
  }) async {
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await TokenUtil.getToken()}"
    };
    return await _dio.post(url, queryParameters: query, data: data);
  }

  Future<Response> postWithFormData(String url,{
    Map<String, dynamic>? query,
    required dynamic data,
  }) async {
    _dio.options.headers = {
      "Authorization": "Bearer ${await TokenUtil.getToken()}",
      // "Content-Type": "multipart/form-data",
    };
    return await _dio.post(url,
        queryParameters: query,
        data: data,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}));
  }

  Future<Response> put(String url,{
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await TokenUtil.getToken()}"
    };
    return await _dio.put(url, queryParameters: query, data: data);
  }

  Future<Response> delete(String url,{
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
