part of 'register_cubit.dart';

@immutable
sealed class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class LoginPasswordVisibilityState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterFailureState extends RegisterStates {
  final String errorMessage;

  RegisterFailureState({required this.errorMessage});
}
