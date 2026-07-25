import 'package:dartz/dartz.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/core/network/failures/failure.dart';
import 'package:tasky/features/authentication/data/model/response/register_response.dart';

import '../../data/repo/authentication_repo_impl.dart';

class RegisterUseCase
    implements
        ParameterUseCase<Either<Failure, RegisterResponse>,
            RegisterParameter> {
  final AuthenticationRepoImpl _authenticationRepo;

  RegisterUseCase(this._authenticationRepo);
  @override
  Future<Either<Failure, RegisterResponse>> perform(
          RegisterParameter parameter) async =>
      await _authenticationRepo.register(RegisterResponse(
          name: parameter.name,
          yearsOfExperience: parameter.yearsOfExperience,
          level: parameter.level,
          address: parameter.address,
          phoneNumber: parameter.phoneNumber,
      password: parameter.password));
}
