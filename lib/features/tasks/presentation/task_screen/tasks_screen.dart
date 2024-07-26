import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/tasks/presentation/task_screen/cubit/tasks_cubit.dart';


class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Placeholder(),
        );
      },
    );
  }
}

// TaskyButton(
// onButtonPressed: () {
// sl<AuthenticationRepoImpl>().logout().then((value) =>
// AppNavigator.navigateAndFinishToLogin(context))
//     .catchError((error) =>
// print('error logging out: ${error}'));
// },
// content: Text('Logout')),