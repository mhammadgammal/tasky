import 'package:dartz/dartz.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/core/network/failures/failure.dart';
import 'package:tasky/features/authentication/data/model/response/login_response.dart';
import 'package:tasky/features/authentication/data/repo/authentication_repo_impl.dart';

class LoginUseCase
    implements
        ParameterUseCase<Either<Failure, LoginResponse>, LoginParameter> {
  final AuthenticationRepoImpl _authenticationRepo;

  LoginUseCase(this._authenticationRepo);
  @override
  Future<Either<Failure, LoginResponse>> perform(
          LoginParameter parameter) async =>
      await _authenticationRepo.login(parameter.phone, parameter.password);
}
