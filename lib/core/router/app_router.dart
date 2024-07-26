import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/di/di.dart';
import 'package:tasky/core/router/router_helper.dart';
import 'package:tasky/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:tasky/features/authentication/presentation/login/login_screen.dart';
import 'package:tasky/features/authentication/presentation/register/cubit/register_cubit.dart';
import 'package:tasky/features/authentication/presentation/register/register_screen.dart';
import 'package:tasky/features/boarding/boarding_screen.dart';
import 'package:tasky/features/tasks/presentation/task_screen/cubit/tasks_cubit.dart';
import 'package:tasky/features/tasks/presentation/task_screen/tasks_screen.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> generateRoutes = {
    RouterHelper.boarding: (_) => const BoardingScreen(),
    RouterHelper.login: (_) =>
        BlocProvider(
          create: (context) => LoginCubit(sl.get()),
          child: const LoginScreen(),
        ),
    RouterHelper.register: (_) =>
        BlocProvider(
          create: (context) => RegisterCubit(sl.get()),
          child: const RegisterScreen(),
        ),
    RouterHelper.home: (_) =>
        BlocProvider(
          create: (context) => TasksCubit(sl.get())..fetchAllTasks(),
          child: const TasksScreen(),
        ),
  };
}
