import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_images.dart';
import 'package:tasky/core/theme/app_text_style.dart';
import 'package:tasky/core/utils/screen_utils/screen_util.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 10.0),
          child: Image.asset(
            AppImages.boarding,
            height: 550.0,
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
        Container(
          height: 50.0,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 10.0,
          ),
          child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    const WidgetStatePropertyAll(Color(0xFF5F33E1)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Let\'s Start',
                    style: AppTextStyle.font20whiteBold,
                  ),
                  Icon(Icons.arrow_forward, color: Colors.white)
                ],
              )),
        )
      ],
    ));
  }
}
