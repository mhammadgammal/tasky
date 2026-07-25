import 'package:flutter/material.dart';
import 'package:tasky/core/router/router_helper.dart';

abstract class AppNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navigateAndFinishToLogin() =>
      Navigator.popAndPushNamed(
          navigatorKey.currentContext!, RouterHelper.login);

  static Future<dynamic> navigateToLogin() =>
      Navigator.pushNamed(navigatorKey.currentContext!, RouterHelper.login);

  static Future<dynamic> navigateToRegister() => Navigator.pushNamed(
      navigatorKey.currentContext!, RouterHelper.register);

  static Future<void> navigateToTasks() =>
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!,
          RouterHelper.home, ModalRoute.withName(RouterHelper.boarding));

  static Future<dynamic> navigateToAddTask() => Navigator.pushNamed(
      navigatorKey.currentContext!, RouterHelper.addTask);

  static Future<dynamic> navigateToTaskDetails(String taskId) =>
      Navigator.pushNamed(navigatorKey.currentContext!,
          RouterHelper.taskDetails,
          arguments: taskId);

  static Future<dynamic> navigateToQrCode() => Navigator.pushNamed(
      navigatorKey.currentContext!, RouterHelper.qrCodeScanner);

  static Future<dynamic> navigateToProfile() => Navigator.pushNamed(
      navigatorKey.currentContext!, RouterHelper.profile);
}
