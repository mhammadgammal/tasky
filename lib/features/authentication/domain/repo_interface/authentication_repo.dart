import 'package:tasky/features/authentication/data/data_source/register_dto.dart';

abstract interface class AuthenticationRepo{

  Future login(String email, String password);
  Future register(RegisterDto registerDto);
}