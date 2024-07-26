import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/router/app_navigator.dart';
import 'package:tasky/core/theme/app_color.dart';
import 'package:tasky/features/authentication/data/repo/authentication_repo_impl.dart';
import 'package:tasky/features/tasks/presentation/screens/task_screen/cubit/tasks_cubit.dart';
import 'package:tasky/features/tasks/presentation/widgets/tasks_selection_chips.dart';

import '../../../../../core/di/di.dart';
import '../../widgets/task_item.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TasksCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsetsDirectional.only(start: 5.0),
              child: Text('Tasky'),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person_2_outlined,
                    color: Colors.black,
                  )),
              IconButton(
                onPressed: () =>
                    sl<AuthenticationRepoImpl>().logout().then((value) {
                  if (value) {
                    AppNavigator.navigateAndFinishToLogin(context);
                  }
                }),
                icon: const Icon(
                  Icons.logout,
                  color: AppColor.mainColor,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Tasks',
                  style: TextStyle(
                      color: AppColor.solidGrey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                TasksSelectionChips(
                    chipsItems: cubit.taskTypeItems,
                    selectedTaskTypeIndex: cubit.selectedTaskTypeIndex,
                    onChipPressed: cubit.onTaskTypeSelected),
                Expanded(
                  child: ListView.builder(
                    itemCount: cubit.tasks.length,
                    itemBuilder: (context, index) => TaskItem(
                        task: cubit.tasks[index],
                        statusColors:
                            AppColor.getStatusColors(cubit.tasks[index].status),
                        priorityColor: AppColor.getPrioritiesColors(
                            cubit.tasks[index].priority)),
                  ),
                ),
              ],
            ),
          ),
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
