import 'package:tasky/core/utils/api_utils/api_response.dart';
import 'package:tasky/features/authentication/data/data_source/register_dto.dart';

abstract interface class AuthenticationRepo{

  Future<ApiResponse> login(String email, String password);
  Future<ApiResponse> register(RegisterDto registerDto);
}