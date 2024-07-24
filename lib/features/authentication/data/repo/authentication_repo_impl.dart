import 'package:dio/dio.dart';
import 'package:tasky/core/utils/api_utils/api_response.dart';
import 'package:tasky/core/utils/api_utils/token_util.dart';
import 'package:tasky/features/authentication/data/data_source/register_dto.dart';
import 'package:tasky/features/authentication/data/network/authentication_api_sevice.dart';

import '../../domain/repo_interface/authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final AuthenticationApiSeviceImpl _apiSevice;

  AuthenticationRepoImpl(this._apiSevice);

  @override
  Future<ApiResponse> login(String phone, String password) async {
    try {
      var response = await _apiSevice.login(phone, password);
      print(response.data);
      print(TokenUtil.setToken(response.data['access_token']));
      print(TokenUtil.setRefreshToken(response.data['refresh_token']));
      
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      print(
          'Error logging in with code ${e.response?.statusCode!.toString()}: ${e.message}');
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
          'Error registering with code ${e.response?.statusCode!.toString()}: ${e.message}');
      return ApiResponse.withError(e);
    }
  }
}
