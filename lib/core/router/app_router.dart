import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/di/di.dart';
import 'package:tasky/core/router/router_helper.dart';
import 'package:tasky/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:tasky/features/authentication/presentation/login/login_screen.dart';
import 'package:tasky/features/authentication/presentation/register/cubit/register_cubit.dart';
import 'package:tasky/features/authentication/presentation/register/register_screen.dart';
import 'package:tasky/features/boarding/boarding_screen.dart';
import 'package:tasky/features/tasks/presentation/screens/add_task/add_task.dart';
import 'package:tasky/features/tasks/presentation/screens/add_task/cubit/add_task_cubit.dart';
import 'package:tasky/features/tasks/presentation/screens/task_details_screen/cubit/task_details_cubit.dart';
import 'package:tasky/features/tasks/presentation/screens/task_details_screen/task_details_screen.dart';
import 'package:tasky/features/tasks/presentation/screens/task_screen/cubit/tasks_cubit.dart';
import 'package:tasky/features/tasks/presentation/screens/task_screen/tasks_screen.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> generateRoutes = {
    RouterHelper.boarding: (_) => const BoardingScreen(),
    RouterHelper.login: (_) => BlocProvider(
          create: (context) => LoginCubit(sl.get()),
          child: const LoginScreen(),
        ),
    RouterHelper.register: (_) => BlocProvider(
          create: (context) => RegisterCubit(sl.get()),
          child: const RegisterScreen(),
        ),
    RouterHelper.home: (_) => BlocProvider(
          create: (context) => TasksCubit(sl.get(), sl.get())..fetchAllTasks(),
          child: const TasksScreen(),
        ),
    RouterHelper.addTask: (_) => BlocProvider(
          create: (_) => AddTaskCubit(sl.get()),
          child: const AddNewTaskScreen(),
        ),
    RouterHelper.taskDetails: (context) {
      var taskId = ModalRoute.of(context)!.settings.arguments as String;
      return BlocProvider(
        create: (_) => TaskDetailsCubit(sl.get(), sl.get())..getTask(taskId),
        child: const TaskDetailsScreen(),
      );
    }
  };
}
