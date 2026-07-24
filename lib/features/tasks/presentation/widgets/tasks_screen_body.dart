import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_color.dart';
import 'package:tasky/core/utils/screen_utils/screen_util.dart';
import 'package:tasky/core/widgets/paginatable_list.dart';
import 'package:tasky/features/tasks/presentation/widgets/no_data_screen.dart';
import 'package:tasky/features/tasks/presentation/widgets/task_item.dart';
import 'package:tasky/features/tasks/presentation/widgets/tasks_loading.dart';

import '../../../../core/router/app_navigator.dart';
import '../../domain/entity/task_model.dart';

class TasksScreenBody extends StatelessWidget {
  const TasksScreenBody({
    super.key,
    required this.selectedItemIndex,
    required this.controller,
    required this.pageLoader,
    required this.deleteTask,
    required this.updateToTasksList,
  });

  final int selectedItemIndex;
  final PaginatableListController controller;
  final Future<List<TaskModel>> Function(int page, int pageSize) pageLoader;
  final Function(String) deleteTask;
  final Function(TaskModel) updateToTasksList;

  @override
  Widget build(BuildContext context) {
    return PaginatableList<TaskModel>(
      key: ValueKey(selectedItemIndex),
      controller: controller,
      pageLoader: pageLoader,
      initialPage: 0,
      loadingIndicator: const TasksLoading(),
      emptyWidget: NoTasksScreen(selectedItemIndex),
      separator: Divider(
        height: 10.0,
        color: Colors.grey,
        indent: ScreenUtil.getScreenWidth(context) * 0.5,
        endIndent: ScreenUtil.getScreenWidth(context) * 0.5,
      ),
      itemBuilder: (context, item, index) => TaskItem(
        task: item,
        statusColors: AppColor.getStatusColors(item.status),
        priorityColor: AppColor.getPrioritiesColors(item.priority),
        deleteTaskCallBack: (taskId) => deleteTask(item.taskId),
        onItemPressed: () =>
            AppNavigator.navigateToTaskDetails(context, item.taskId)
                .then((value) {
          if (value is TaskModel) {
            updateToTasksList(value);
          } else if (value is String) {
            deleteTask(value);
          }
        }),
        ifImageExist: item.imagePath.isEmpty,
      ),
    );
  }
}
