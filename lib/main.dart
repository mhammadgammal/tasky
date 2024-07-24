import 'package:flutter/material.dart';
// import 'package:tasky/core/base_use_case/base_parameter.dart';
// import 'package:tasky/features/authentication/domain/use_case/login_use_case.dart';
import 'package:tasky/core/di/di.dart';

import 'package:tasky/tasky_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  // sl<LoginUseCase>().perform(LoginParameter('+201010558269', '123456'));
  runApp(const TaskyApp());
}
