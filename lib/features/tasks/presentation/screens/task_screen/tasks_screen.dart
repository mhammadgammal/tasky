import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/router/app_navigator.dart';
import 'package:tasky/core/theme/app_color.dart';
import 'package:tasky/features/authentication/data/repo/authentication_repo_impl.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';
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
                  onPressed: () => AppNavigator.navigateToProfile(context),
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
                    itemCount: cubit.getSelectedItems().length,
                    itemBuilder: (context, index) => TaskItem(
                      task: cubit.getSelectedItems()[index],
                      statusColors: AppColor.getStatusColors(
                          cubit.getSelectedItems()[index].status),
                      priorityColor: AppColor.getPrioritiesColors(
                          cubit.getSelectedItems()[index].priority),
                      deleteTaskCallBack: () {
                        cubit
                            .deleteTask(cubit.getSelectedItems()[index].taskId);
                      },
                      onItemPressed: () => AppNavigator.navigateToTaskDetails(
                              context, cubit.getSelectedItems()[index].taskId)
                          .then((value) {
                        if (value is TaskModel) {
                          print('value.status: ${value.status}');
                          cubit.updateToTasksList(value);
                        }
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        /* Action 1 */
                        AppNavigator.navigateToQrCode(context).then((value) {
                          if (value is String) {
                            AppNavigator.navigateToTaskDetails(context, value);
                          }
                        });
                      },
                      backgroundColor: AppColor.secondaryColor,
                      shape: const CircleBorder(eccentricity: 0.0),
                      child: const Icon(
                        Icons.qr_code_scanner_outlined,
                        color: AppColor.mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0), // Add spacing between FABs
                  SizedBox(
                    width: 64.0,
                    height: 64.0,
                    child: FloatingActionButton(
                      shape: const CircleBorder(eccentricity: 1.0),
                      onPressed: () =>
                          AppNavigator.navigateToAddTask(context).then((value) {
                        if (value is TaskModel) {
                          cubit.addToTasksList(value);
                        }
                      }),
                      elevation: 20.0,
                      child: const Icon(
                        Icons.add,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
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
