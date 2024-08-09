import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../domain/entity/task_model.dart';
import 'tasks_screen_body.dart';

class TasksLayout extends StatelessWidget {
  const TasksLayout(
      {super.key,
      required this.taskTypeItems,
      required this.selectedTaskTypeIndex,
      required this.pagingController,
      required this.onTaskTypeSelected,
      required this.deleteTask,
      required this.updateToTasksList,
      required this.addToTasksList,
      required this.fetchAllTasks});

  final List<String> taskTypeItems;
  final int selectedTaskTypeIndex;
  final PagingController<int, TaskModel> pagingController;
  final Function(int) fetchAllTasks;
  final Function(bool, int) onTaskTypeSelected;
  final Function(String) deleteTask;
  final Function(TaskModel) updateToTasksList;
  final Function(TaskModel) addToTasksList;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => fetchAllTasks(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TasksScreenBody(
              taskTypeItems: taskTypeItems,
              selectedTaskTypeIndex: selectedTaskTypeIndex,
              onTaskTypeSelected: onTaskTypeSelected,
              deleteTask: deleteTask,
              updateToTasksList: updateToTasksList,
              addToTasksList: addToTasksList,
              pagingController: pagingController,
              selectedItemIndex: selectedTaskTypeIndex,
            ),
          ),
        ],
      ),
    );
  }
}
