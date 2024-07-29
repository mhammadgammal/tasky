import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_color.dart';
import 'package:tasky/features/tasks/presentation/widgets/task_item.dart';

import '../../../../core/router/app_navigator.dart';
import '../../domain/entity/task_model.dart';

class TasksScreenBody extends StatelessWidget {
  const TasksScreenBody(
      {super.key,
      required this.taskTypeItems,
      required this.selectedItems,
      required this.selectedTaskTypeIndex,
      required this.onTaskTypeSelected,
      required this.deleteTask,
      required this.updateToTasksList,
      required this.addToTasksList});

  final List<String> taskTypeItems;
  final List<TaskModel> selectedItems;
  final int selectedTaskTypeIndex;
  final Function(bool, int) onTaskTypeSelected;
  final Function(String) deleteTask;
  final Function(TaskModel) updateToTasksList;
  final Function(TaskModel) addToTasksList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: selectedItems.length,
      itemBuilder: (context, index) => TaskItem(
        task: selectedItems[index],
        statusColors:
            AppColor.getStatusColors(selectedItems[index].status),
        priorityColor:
            AppColor.getPrioritiesColors(selectedItems[index].priority),
        deleteTaskCallBack: () {
          deleteTask(selectedItems[index].taskId);
        },
        onItemPressed: () => AppNavigator.navigateToTaskDetails(
                context, selectedItems[index].taskId)
            .then((value) {
          if (value is TaskModel) {
            print('value.status: ${value.status}');
            updateToTasksList(value);
          }
        }),
      ),
    );
  }
}
