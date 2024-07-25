import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/bloc_observer.dart';
import 'package:tasky/core/di/di.dart';

import 'package:tasky/tasky_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Bloc.observer = TaskyBlocObserver();
  runApp(const TaskyApp());
}
