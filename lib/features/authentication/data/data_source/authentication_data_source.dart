import 'package:dio/dio.dart';
import 'package:tasky/core/cache/cache_keys.dart';
import 'package:tasky/core/network/api_end_points.dart';
import 'package:tasky/core/network/dio_helper.dart';
import 'package:tasky/features/authentication/data/model/response/register_response.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/di/di.dart';

abstract interface class AuthenticationDataSourceI {
  Future<Response> register(RegisterResponse registerDto);

  Future<Response> login(String phone, String password);

  Future<Response> logout();
}

class AuthenticationDataSourceImpl implements AuthenticationDataSourceI {
  final DioHelper _dio;

  AuthenticationDataSourceImpl(this._dio);
  @override
  Future<Response> login(String phone, String password) =>
      _dio.post(ApiEndPoints.login, data: {
        'phone': phone,
        'password': password,
      });

  @override
  Future<Response> logout() => _dio.post(ApiEndPoints.logout, data: {
        "token": sl<CacheHelper>().getString(key: CacheKeys.refreshToken)
      });

  @override
  Future<Response> register(RegisterResponse registerDto) =>
      _dio.post(ApiEndPoints.register, data: registerDto.toJson());
}
