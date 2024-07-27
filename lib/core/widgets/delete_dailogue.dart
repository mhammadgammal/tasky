import 'package:flutter/material.dart';

import '../theme/app_color.dart';
import '../theme/app_text_style.dart';

class DeleteDialogue extends StatelessWidget {
  const DeleteDialogue(this.id,
      {super.key, required this.onYesPressed, required this.onNoPressed});

  final Function() onYesPressed;
  final Function() onNoPressed;
  final String id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete Confirmation',
        style: AppTextStyle.font20BlackBold,
      ),
      content: const Text(
        'Are you sure you want to delete this invoice',
        style: AppTextStyle.font15BlackNormal,
      ),
      actions: [
        TextButton(
            onPressed: onNoPressed,
            child: const Text('No',
                style: TextStyle(color: AppColor.mainColor, fontSize: 15))),
        TextButton(
            onPressed: onYesPressed,
            child: const Text('yes',
                style: TextStyle(color: AppColor.mainColor, fontSize: 15))),
      ],
    );
  }
}
