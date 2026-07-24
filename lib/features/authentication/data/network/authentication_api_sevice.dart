import 'package:dio/dio.dart';
import 'package:tasky/core/cache/cache_keys.dart';
import 'package:tasky/core/network/api_end_points.dart';
import 'package:tasky/core/network/dio_helper.dart';
import 'package:tasky/features/authentication/data/data_source/register_dto.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/di/di.dart';

abstract interface class AuthenticationApiSeviceI {
  Future<Response> register(RegisterDto registerDto);

  Future<Response> login(String phone, String password);

  Future<Response> logout();
}

class AuthenticationApiSeviceImpl implements AuthenticationApiSeviceI {
  @override
  Future<Response> login(String phone, String password) =>
      sl<DioHelper>().post(ApiEndPoints.login, data: {
        'phone': phone,
        'password': password,
      });

  @override
  Future<Response> logout() =>
      sl<DioHelper>().post(ApiEndPoints.logout, data: {
        "token": sl<CacheHelper>().getString(key: CacheKeys.refreshToken)
      });

  @override
  Future<Response> register(RegisterDto registerDto) => sl<DioHelper>()
      .post(ApiEndPoints.register, data: registerDto.toJson());
}
