import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/core/utils/api_utils/api_response.dart';
import 'package:tasky/features/authentication/data/repo/authentication_repo_impl.dart';

class LoginUseCase implements ParameterUseCase<ApiResponse, LoginParameter> {
  final AuthenticationRepoImpl _authenticationRepo;

  LoginUseCase(this._authenticationRepo);
  @override
  Future<ApiResponse> perform(LoginParameter parameter) async =>
      await _authenticationRepo.login(parameter.phone, parameter.password);
}
