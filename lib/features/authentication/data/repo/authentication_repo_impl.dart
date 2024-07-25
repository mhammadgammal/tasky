import 'package:dio/dio.dart';
import 'package:tasky/core/cache/cache_helper.dart';
import 'package:tasky/core/cache/cache_keys.dart';
import 'package:tasky/core/utils/api_utils/api_response.dart';
import 'package:tasky/core/utils/api_utils/token_util.dart';
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
      print('AuthenticationRepoImpl: login Response ==> ${response.data}');
      var isAccessToken =
      await TokenUtil.setToken(response.data['access_token']);
      print('AuthenticationRepoImpl: isAccessToken ==> $isAccessToken');
      print('AuthenticationRepoImpl: access token from sh: ${sl<CacheHelper>()
          .getString(key: CacheKeys.token)}');

      var isRefreshToken =
      await TokenUtil.setRefreshToken(response.data['refresh_token']);
      print('AuthenticationRepoImpl: isRefreshToken ==> $isRefreshToken');

      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      print(
          'Error logging in with code ${e.response?.statusCode!.toString()}: ${e
              .message}');
      return ApiResponse.withError(e);
    }
  }

  @override
  Future<ApiResponse> register(RegisterDto registerDto) async {
    try {
      var response = await _apiSevice.register(registerDto);
      print(response.data);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      print(
          'Error registering with code ${e.response?.statusCode!
              .toString()}: ${e.message}');
      return ApiResponse.withError(e);
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
