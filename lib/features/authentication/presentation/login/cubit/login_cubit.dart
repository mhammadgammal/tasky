import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../../core/base_use_case/base_parameter.dart';
import '../../../domain/use_case/login_use_case.dart';

part 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;

  final passwordController = TextEditingController();

  bool isVisibility = true;

  var formKey = GlobalKey<FormState>();

  LoginCubit(this._loginUseCase) : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final PhoneController phoneController = PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.EG, nsn: ''));
  final CountrySelectorNavigator selectorNavigator =
      const CountrySelectorNavigator.page();

  Future<void> login() async {
    emit(LoginLoadingState());
    String phoneNumber =
        '+${phoneController.value.countryCode}${phoneController.value.nsn}';
    print(phoneNumber);
    var apiResponse = await _loginUseCase
        .perform(LoginParameter(phoneNumber, passwordController.text));
    print(apiResponse.error);
    if (apiResponse.response != null) {
      emit(LoginSuccessState());
    } else if (apiResponse.error != null) {
      print(apiResponse.error);
      String errorMessage = 'An error occurred, Please try again';
      if (apiResponse.error.response?.statusCode == 401) {
        errorMessage = 'Wrong email or password';
      }
      emit(LoginFailureState(message: errorMessage));
    }
  }

  changePasswordVisibility() {
    isVisibility = !isVisibility;
    emit(LoginPasswordVisibilityState());
  }

  String? validatePasswordField(String? value) => value == null || value.isEmpty
      ? 'Password is required'
      : value.length < 6
          ? 'Password must be at least 6 characters'
          : null;

  @override
  Future<void> close() {
    phoneController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
