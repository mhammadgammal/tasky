import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_color.dart';

import '../theme/app_text_style.dart';

class AuthErrorDialogue extends StatelessWidget {
  const AuthErrorDialogue({super.key, required this.errorMessage});

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
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Ok',
              style: TextStyle(color: AppColor.mainColor, fontSize: 15),
            )),
      ],
    );
  }
}
