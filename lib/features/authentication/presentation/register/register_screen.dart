import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/theme/app_images.dart';
import 'package:tasky/core/theme/app_text_style.dart';
import 'package:tasky/core/utils/screen_utils/screen_util.dart';
import 'package:tasky/core/widgets/auth_error_dialogue.dart';
import 'package:tasky/core/widgets/default_form_field.dart';
import 'package:tasky/core/widgets/phone_number_input_widget.dart';
import 'package:tasky/core/widgets/shimmer_loading.dart';
import 'package:tasky/core/widgets/tasky_button.dart';
import 'package:tasky/features/authentication/presentation/register/cubit/register_cubit.dart';

import '../../../../core/router/app_navigator.dart';
import '../../../../core/theme/app_color.dart';
import '../../data/data_source/register_dto.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          AppNavigator.navigateAndFinishToLogin(context);
        } else if (state is RegisterFailureState) {
          showDialog(
              context: context,
              builder: (context) =>
                  AuthErrorDialogue(errorMessage: state.errorMessage));
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: cubit.formKey,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Image.asset(
                      AppImages.boarding,
                      height: ScreenUtil.getScreenHeight(context) * 0.4,
                      width: ScreenUtil.getScreenWidth(context),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(top: 250.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Register',
                            style: AppTextStyle.font30BlackWBody,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          DefaultFormFiled(
                            focusNode: cubit.nameNode,
                            controller: cubit.nameController,
                            inputType: TextInputType.name,
                            fieldLabel: 'Name',
                            icon: null,
                            validate: cubit.validateName,
                            onSubmit: (_) => FocusScope.of(context)
                                .requestFocus(cubit.phoneNode),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          PhoneNumberInputWidget(
                            phoneNode: cubit.phoneNode,
                            focus: false,
                            phoneController: cubit.phoneController,
                            selectorNavigator: cubit.selectorNavigator,
                            onEditComplete: () => FocusScope.of(context)
                                .requestFocus(cubit.yearsOfExperienceNode),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          DefaultFormFiled(
                            focusNode: cubit.yearsOfExperienceNode,
                            controller: cubit.yearsOfExperienceController,
                            inputType: TextInputType.name,
                            fieldLabel: 'Years Of Experience',
                            icon: null,
                            validate: null,
                            onSubmit: (_) => FocusScope.of(context)
                                .requestFocus(cubit.addressNode),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          DropdownButtonFormField<ExperienceLevel>(
                            value: cubit.selectedLevel,
                            onChanged: cubit.onExperienceLevelChanged,
                            decoration: InputDecoration(
                              labelText: 'Choose experience level',
                              labelStyle: const TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ), // Add a border
                              filled: false,
                            ),
                            items: ExperienceLevel.values
                                .map((ExperienceLevel level) {
                              return DropdownMenuItem<ExperienceLevel>(
                                value: level,
                                child: Text(level
                                    .name), // Display the name of the enum value
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          DefaultFormFiled(
                            focusNode: cubit.addressNode,
                            controller: cubit.addressController,
                            inputType: TextInputType.name,
                            fieldLabel: 'Address...',
                            icon: null,
                            validate: cubit.validateAddress,
                            onSubmit: (_) => FocusScope.of(context)
                                .requestFocus(cubit.passwordNode),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          DefaultFormFiled(
                            focusNode: cubit.passwordNode,
                            controller: cubit.passwordController,
                            inputType: TextInputType.visiblePassword,
                            fieldLabel: 'Password',
                            icon: null,
                            obSecure: cubit.isVisibility,
                            maxLines: 1,
                            suffixIcon: IconButton(
                                onPressed: () =>
                                    cubit.changePasswordVisibility(),
                                icon: Icon(
                                  cubit.isVisibility
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColor.lightGrey,
                                )),
                            validate: cubit.validatePasswordField,
                            onSubmit: (_) =>
                                cubit.formKey.currentState!.validate()
                                    ? cubit.register()
                                    : null,
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          state is RegisterLoadingState
                              ? const ShimmerLoading(
                                  height: 50.0,
                                )
                              : TaskyButton(
                                  onButtonPressed: () =>
                                  cubit.formKey.currentState!.validate()
                                      ? cubit.register()
                                      : null,
                              horizontalPadding: 0.0,
                              content: const Text(
                                "Sign Up",
                                style: AppTextStyle.font20whiteBold,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have any account?',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 17.0),
                              ),
                              TextButton(
                                  onPressed: () =>
                                      AppNavigator.navigateToLogin(context),
                                  child: const Text('Sign In'))
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
