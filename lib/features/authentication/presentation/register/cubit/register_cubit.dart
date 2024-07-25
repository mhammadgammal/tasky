import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/features/authentication/data/data_source/register_dto.dart';
import 'package:tasky/features/authentication/domain/use_case/register_use_case.dart';

part 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  final RegisterUseCase _useCase;

  RegisterCubit(this._useCase) : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  ExperienceLevel? selectedLevel;

  var formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearsOfExperienceController =
      TextEditingController();
  final PhoneController phoneController = PhoneController(
      initialValue: const PhoneNumber(isoCode: IsoCode.EG, nsn: ''));
  var addressController = TextEditingController();
  var passwordController = TextEditingController();
  bool isVisibility = true;
  final CountrySelectorNavigator selectorNavigator =
      const CountrySelectorNavigator.page();

  String? validateName(String? value) =>
      value == null || value.isEmpty ? 'Name Field is Required' : null;

  changePasswordVisibility() {
    isVisibility = !isVisibility;
    emit(LoginPasswordVisibilityState());
  }

  String? validateAddress(String? value) => null;

  String? validatePasswordField(String? value) => value == null || value.isEmpty
      ? 'Password is required'
      : value.length < 6
          ? 'Password must be at least 6 characters'
          : null;

  void onExperienceLevelChanged(ExperienceLevel? newValue) =>
      selectedLevel = newValue;

  register() async {
    String phoneNumber =
        '+${phoneController.value.countryCode}${phoneController.value.nsn}';

    var apiResponse = await _useCase.perform(RegisterParameter(
      nameController.text,
      selectedLevel != null ? selectedLevel!.name : '',
      addressController.text,
      passwordController.text,
      phoneNumber,
      yearsOfExperienceController.text,
    ));

    if (apiResponse.response != null) {
      emit(RegisterSuccessState());
    } else if (apiResponse.error != null) {
      apiResponse.response?.data;
      emit(RegisterFailureState());
    }
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    passwordController.dispose();
    addressController.dispose();
    nameController.dispose();
    yearsOfExperienceController.dispose();
    return super.close();
  }
}
