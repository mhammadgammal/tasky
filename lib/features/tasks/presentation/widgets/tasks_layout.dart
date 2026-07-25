import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/paginatable_list.dart';

import '../../domain/entity/task_model.dart';
import 'tasks_screen_body.dart';

class TasksLayout extends StatelessWidget {
  const TasksLayout(
      {super.key,
      required this.selectedTaskTypeIndex,
      required this.controller,
      required this.pageLoader,
      required this.deleteTask,
      required this.updateToTasksList});

  final int selectedTaskTypeIndex;
  final PaginatableListController controller;
  final Future<List<TaskModel>> Function(int page, int pageSize) pageLoader;
  final Function(String) deleteTask;
  final Function(TaskModel) updateToTasksList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TasksScreenBody(
            selectedItemIndex: selectedTaskTypeIndex,
            controller: controller,
            pageLoader: pageLoader,
            deleteTask: deleteTask,
            updateToTasksList: updateToTasksList,
          ),
        ),
      ],
    );
  }
}
