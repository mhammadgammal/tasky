import 'package:flutter/material.dart';
import 'package:tasky/core/cache/cache_helper.dart';
import 'package:tasky/core/cache/cache_keys.dart';
import 'package:tasky/core/di/di.dart';
import 'package:tasky/core/router/app_navigator.dart';
import 'package:tasky/core/theme/app_images.dart';
import 'package:tasky/core/theme/app_text_style.dart';
import 'package:tasky/core/utils/screen_utils/screen_util.dart';
import 'package:tasky/core/widgets/tasky_button.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 10.0, bottom: 10.0),
          child: Image.asset(
            AppImages.boarding,
            height: ScreenUtil.getScreenHeight(context) * 0.65,
            width: ScreenUtil.getScreenWidth(context),
          ),
        ),
        const Text(
          'Task Management &\nTo-Do List',
          style: AppTextStyle.font30BlackBoldBody,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'This productive tool is designed to help\nyou better manage your task\nproject-wise conveniently!',
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 15,
        ),
        TaskyButton(
            onButtonPressed: () {
              sl<CacheHelper>().putBool(CacheKeys.firstTime, false);
              AppNavigator.navigateAndFinishToLogin(context);
            },
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Let\'s Start',
                  style: AppTextStyle.font20whiteBold,
                ),
                Icon(Icons.arrow_forward, color: Colors.white)
              ],
            ))
      ],
    ));
  }
}
