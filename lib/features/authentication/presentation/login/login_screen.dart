import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app_context.dart';
import 'package:tasky/core/router/app_navigator.dart';
import 'package:tasky/core/theme/app_images.dart';
import 'package:tasky/core/theme/app_text_style.dart';
import 'package:tasky/core/utils/screen_utils/screen_util.dart';
import 'package:tasky/core/widgets/auth_error_dialogue.dart';
import 'package:tasky/core/widgets/default_form_field.dart';
import 'package:tasky/core/widgets/phone_number_input_widget.dart';
import 'package:tasky/core/widgets/shimmer_loading.dart';
import 'package:tasky/core/widgets/tasky_button.dart';
import 'package:tasky/features/authentication/presentation/login/cubit/login_cubit.dart';

import '../../../../core/di/di.dart';
import '../../../../core/theme/app_color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          AppNavigator.navigateToTasks(context);
        } else if (state is LoginFailureState) {
          showDialog(
              context: sl<AppContext>().navigatorContext,
              builder: (BuildContext context) => AuthErrorDialogue(
                    errorMessage: state.message,
                  ));
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.boarding,
                    height: ScreenUtil.getScreenHeight(context) * 0.65,
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: AppTextStyle.font30BlackWBody,
                        ),
                        PhoneNumberInputWidget(
                          phoneNode: cubit.phoneNode,
                          focus: true,
                          phoneController: cubit.phoneController,
                          selectorNavigator: cubit.selectorNavigator,
                          onEditComplete: () => FocusScope.of(context)
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
                              onPressed: () => cubit.changePasswordVisibility(),
                              icon: Icon(
                                cubit.isVisibility
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColor.lightGrey,
                              )),
                          validate: cubit.validatePasswordField,
                          onSubmit: (_) => cubit.login(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  state is LoginLoadingState
                      ? const ShimmerLoading(
                          height: 50.0,
                        )
                      : TaskyButton(
                          onButtonPressed: () =>
                              cubit.formKey.currentState!.validate()
                                  ? cubit.login()
                                  : null,
                          horizontalPadding: 12.0,
                          content: const Text(
                            "Sign In",
                            style: AppTextStyle.font20whiteBold,
                          )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have any account?',
                        style: TextStyle(color: Colors.grey, fontSize: 17.0),
                      ),
                      TextButton(
                          onPressed: () =>
                              AppNavigator.navigateToRegister(context),
                          child: const Text('Sign Up here'))
                    ],
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
