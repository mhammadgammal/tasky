part of 'login_cubit.dart';

@immutable
sealed class LoginStates {}

final class LoginInitState extends LoginStates {}

final class LoginLoadingState extends LoginStates {}

final class LoginPasswordVisibilityState extends LoginStates {}

final class LoginSuccessState extends LoginStates {}

final class LoginFailureState extends LoginStates {
  String message;
  LoginFailureState({required this.message});
}
