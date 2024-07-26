import 'package:flutter/material.dart';
import 'package:tasky/core/router/app_navigator.dart';
import 'package:tasky/core/theme/app_color.dart';

import '../theme/app_text_style.dart';

class SessionEndedDialogue extends StatelessWidget {
  const SessionEndedDialogue({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(
        Icons.warning_amber_outlined,
        size: 35.0,
      ),
      content: Text(
        errorMessage,
        style: AppTextStyle.font15BlackNormal,
      ),
      actions: [
        TextButton(
            onPressed: () => AppNavigator.navigateAndFinishToLogin(context),
            child: const Text(
              'Sign In',
              style: TextStyle(color: AppColor.mainColor, fontSize: 15),
            )),
      ],
    );
  }
}