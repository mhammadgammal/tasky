import 'package:flutter/material.dart';
import 'package:tasky/core/router/router_helper.dart';

class AppNavigator {
  static Future<dynamic> navigateAndFinishToLogin(context) =>
      Navigator.popAndPushNamed(context, RouterHelper.login);

  static Future<dynamic> navigateToLogin(context) =>
      Navigator.pushNamed(context, RouterHelper.login);

  static Future<dynamic> navigateToRegister(BuildContext context) =>
      Navigator.pushNamed(context, RouterHelper.register);

  static Future<void> navigateToTasks(BuildContext context) =>
      Navigator.pushNamedAndRemoveUntil(context, RouterHelper.home,
          ModalRoute.withName(RouterHelper.boarding));

  static Future<dynamic> navigateToAddTask(BuildContext context) =>
      Navigator.pushNamed(context, RouterHelper.addTask);

  static Future<dynamic> navigateToTaskDetails(
          BuildContext context, String taskId) =>
      Navigator.pushNamed(context, RouterHelper.taskDetails, arguments: taskId);

  static Future<dynamic> navigateToQrCode(BuildContext context) =>
      Navigator.pushNamed(context, RouterHelper.qrCodeScanner);

  static Future<dynamic> navigateToProfile(context) =>
      Navigator.pushNamed(context, RouterHelper.profile);
}
