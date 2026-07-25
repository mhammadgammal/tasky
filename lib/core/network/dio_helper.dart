import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tasky/core/cache/cache_helper.dart';
import 'package:tasky/core/cache/cache_keys.dart';
import 'package:tasky/core/router/app_navigator.dart';
import 'package:tasky/core/widgets/show_toast.dart';

import '../di/di.dart';
import 'api_end_points.dart';

part 'interceptors/request_interceptor.dart';
part 'interceptors/refresh_token_interceptor.dart';

class DioHelper {
  final Dio _dio;

  DioHelper(this._dio) {
    _init();
  }

  void _init() async {
    _dio.options.baseUrl = ApiEndPoints.baseUrl;
    _dio.interceptors.addAll([
      RequestInterceptor(),
      RefreshTokenInterceptor(_dio),
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true
      )
    ]);
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(url, queryParameters: query);
  }

  Future<Response> post(
    String url, {
    Map<String, dynamic>? query,
    required dynamic data,
  }) async {
    return await _dio.post(url, queryParameters: query, data: data);
  }

  Future<Response> postWithFormData(
    String url, {
    Map<String, dynamic>? query,
    required dynamic data,
  }) async {
    return await _dio.post(url,
        queryParameters: query,
        data: data,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}));
  }

  Future<Response> put(
    String url, {
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    return await _dio.put(url, queryParameters: query, data: data);
  }

  Future<Response> delete(
    String url, {
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    return await _dio.delete(url, queryParameters: query, data: data);
  }
}
