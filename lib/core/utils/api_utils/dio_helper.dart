import 'package:dio/dio.dart';
import '../../cache/cache_helper.dart';
import 'api_end_points.dart';

class DioHelper {
  final Dio _dio;
  final CacheHelper _sharedPreferences;

  DioHelper(this._dio, this._sharedPreferences) {
    _init();
  }

  void _init() {
    print('creating: ${_dio.hashCode}');
    _dio
      ..options.baseUrl = ApiEndPoints.baseUrl
      ..options.headers = {
        "Content-Type": "application/json",
        "lang": "en",
        'Authorization': ''
      };
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(url, queryParameters: query);
  }

  Future<Response> post({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
  }) async {
    return await _dio.post(url, queryParameters: query, data: data);
  }

  Future<Response> put({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    return await _dio.put(url, queryParameters: query, data: data);
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    return await _dio.delete(url, queryParameters: query, data: data);
  }
}
