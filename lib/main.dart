import 'package:flutter/material.dart';
import 'package:tasky/core/di/di.dart';
import 'package:tasky/tasky_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const TaskyApp());
}
