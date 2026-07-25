import 'package:dartz/dartz.dart' show Either;
import 'package:tasky/core/network/failures/failure.dart' show Failure;
import 'package:tasky/features/authentication/data/model/response/login_response.dart';
import 'package:tasky/features/authentication/data/model/response/register_response.dart';

abstract interface class AuthenticationRepo {
  Future<Either<Failure, LoginResponse>> login(String email, String password);
  Future<Either<Failure, RegisterResponse>> register(
      RegisterResponse registerDto);
  Future<bool> logout();
}
