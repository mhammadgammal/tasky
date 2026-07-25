import 'dart:developer' show log;

import 'package:dio/dio.dart';
import 'package:tasky/core/cache/cache_helper.dart';
import 'package:tasky/core/cache/cache_keys.dart';
import 'package:tasky/core/utils/api_utils/api_response.dart';
import 'package:tasky/features/authentication/data/data_source/register_dto.dart';
import 'package:tasky/features/authentication/data/network/authentication_api_sevice.dart';

import '../../../../core/di/di.dart';
import '../../domain/repo_interface/authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final AuthenticationApiSeviceImpl _apiSevice;

  AuthenticationRepoImpl(this._apiSevice);

  @override
  Future<ApiResponse> login(String phone, String password) async {
    try {
      var response = await _apiSevice.login(phone, password);

      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      log(
          'Error logging in with code ${e.response?.statusCode!.toString()}: ${e
              .message}');
      return ApiResponse.withError(e);
    }
  }

  @override
  Future<ApiResponse> register(RegisterDto registerDto) async {
    try {
      var response = await _apiSevice.register(registerDto);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      return ApiResponse.withError(e.response?.statusCode!);
    }
  }

  @override
  Future<bool> logout() async {
    {
      var response = await _apiSevice.logout();
      sl<CacheHelper>().removeCached(key: CacheKeys.token);
      sl<CacheHelper>().removeCached(key: CacheKeys.refreshToken);
      return response.data['success'];
    }
  }
}
