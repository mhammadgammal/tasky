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
      Navigator.pushReplacementNamed(context, RouterHelper.home);

  static Future<dynamic> navigateToAddTask(BuildContext context) =>
      Navigator.pushNamed(context, RouterHelper.addTask);
}
