import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/core/utils/api_utils/api_response.dart';
import 'package:tasky/features/authentication/data/data_source/register_dto.dart';

import '../../data/repo/authentication_repo_impl.dart';

class RegisterUseCase
    implements ParameterUseCase<ApiResponse, RegisterParameter> {
  final AuthenticationRepoImpl _authenticationRepo;

  RegisterUseCase(this._authenticationRepo);
  @override
  Future<ApiResponse> perform(RegisterParameter parameter) async =>
      await _authenticationRepo.register(RegisterDto(
          name: parameter.name,
          yearsOfExperience: parameter.yearsOfExperience,
          level: parameter.level,
          address: parameter.address,
          phoneNumber: parameter.phoneNumber,
      password: parameter.password));
}
