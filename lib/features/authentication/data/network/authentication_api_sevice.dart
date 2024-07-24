import 'package:dio/dio.dart';
import 'package:tasky/core/utils/api_utils/api_end_points.dart';
import 'package:tasky/core/utils/api_utils/dio_helper.dart';
import 'package:tasky/features/authentication/data/data_source/register_dto.dart';

import '../../../../core/di/di.dart';

abstract interface class AuthenticationApiSeviceI {
  Future<Response> register(RegisterDto registerDto);
  Future<Response> login(String phone, String password);
  Future<Response> logout();
}

class AuthenticationApiSeviceImpl implements AuthenticationApiSeviceI {
  @override
  Future<Response> login(String phone, String password) =>
      sl<DioHelper>().post(url: ApiEndPoints.login, data: {
        'phone': phone,
        'password': password,
      });

  @override
  Future<Response> logout() => sl<DioHelper>().post(url: ApiEndPoints.logout, data: {"token": ""});

  @override
  Future<Response> register(RegisterDto registerDto) => sl<DioHelper>()
      .post(url: ApiEndPoints.register, data: registerDto.toJson());
}
