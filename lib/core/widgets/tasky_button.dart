import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_color.dart';
import 'package:tasky/core/utils/screen_utils/screen_util.dart';

class TaskyButton extends StatelessWidget {
  const TaskyButton(
      {super.key, required this.onButtonPressed, required this.content, this.horizontalPadding = 10.0});

  final void Function() onButtonPressed;
  final Widget content;
  final double horizontalPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: ScreenUtil.getScreenWidth(context),
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: horizontalPadding,
      ),
      child: ElevatedButton(
          onPressed: onButtonPressed,
          child: content),
    );
  }
}
