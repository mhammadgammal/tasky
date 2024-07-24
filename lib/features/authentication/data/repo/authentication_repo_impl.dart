import 'package:tasky/features/authentication/data/data_source/register_dto.dart';
import 'package:tasky/features/authentication/data/network/authentication_api_sevice.dart';

import '../../domain/repo_interface/authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {

  final AuthenticationApiSeviceImpl _apiSevice;

  AuthenticationRepoImpl(this._apiSevice);

  @override
  Future login(String phone, String password) async{
    var response = await _apiSevice.login(phone, password);
    print(response.data);
  }

  @override
  Future register(RegisterDto registerDto) async{
    var response = await _apiSevice.register(registerDto);
    print(response.data);
  }
}
