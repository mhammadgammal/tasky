import 'package:dartz/dartz.dart';
import 'package:tasky/core/cache/cache_helper.dart';
import 'package:tasky/core/cache/cache_keys.dart';
import 'package:tasky/core/network/handle_response.dart';
import 'package:tasky/features/authentication/data/model/response/login_response.dart';
import 'package:tasky/features/authentication/data/model/response/register_response.dart';
import 'package:tasky/features/authentication/data/data_source/authentication_data_source.dart';

import '../../../../core/di/di.dart';
import '../../../../core/network/failures/failure.dart';
import '../../domain/repo_interface/authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final AuthenticationDataSourceImpl _dataSource;

  AuthenticationRepoImpl(this._dataSource);

  @override
  Future<Either<Failure, LoginResponse>> login(
          String phone, String password) async =>
      handleResponse(
        _dataSource.login(phone, password),
        (response) => LoginResponse.fromJson(response.data),
      );

  @override
  Future<Either<Failure, RegisterResponse>> register(
          RegisterResponse registerDto) async =>
      handleResponse(
        _dataSource.register(registerDto),
        (response) => RegisterResponse.fromJson(response.data),
      );

  @override
  Future<bool> logout() async {
    {
      var response = await _dataSource.logout();
      sl<CacheHelper>().removeCached(key: CacheKeys.token);
      sl<CacheHelper>().removeCached(key: CacheKeys.refreshToken);
      return response.data['success'];
    }
  }
}
