import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tasky/core/theme/app_color.dart';
import 'package:tasky/core/utils/screen_utils/screen_util.dart';
import 'package:tasky/features/tasks/presentation/widgets/no_data_screen.dart';
import 'package:tasky/features/tasks/presentation/widgets/task_item.dart';
import 'package:tasky/features/tasks/presentation/widgets/tasks_loading.dart';

import '../../../../core/router/app_navigator.dart';
import '../../domain/entity/task_model.dart';

class TasksScreenBody extends StatelessWidget {
  const TasksScreenBody({
    super.key,
    required this.taskTypeItems,
    required this.selectedTaskTypeIndex,
    required this.onTaskTypeSelected,
    required this.deleteTask,
    required this.updateToTasksList,
    required this.addToTasksList,
    required this.pagingController,
    required this.selectedItemIndex,
  });

  final List<String> taskTypeItems;

  final int selectedItemIndex;
  final int selectedTaskTypeIndex;
  final PagingController<int, TaskModel> pagingController;
  final Function(bool, int) onTaskTypeSelected;
  final Function(String) deleteTask;
  final Function(TaskModel) updateToTasksList;
  final Function(TaskModel) addToTasksList;

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, TaskModel>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<TaskModel>(
          firstPageProgressIndicatorBuilder: (context) => const TasksLoading(),
          newPageProgressIndicatorBuilder: (context) => const TasksLoading(),
          noMoreItemsIndicatorBuilder: (context) => Divider(
            height: 10.0,
            color: Colors.grey,
            indent: ScreenUtil.getScreenWidth(context) * 0.5,
            endIndent: ScreenUtil.getScreenWidth(context) * 0.5,
          ),
          noItemsFoundIndicatorBuilder: (context) =>
              NoTasksScreen(selectedItemIndex),
          itemBuilder: (context, item, index) => TaskItem(
            task: item,
            statusColors: AppColor.getStatusColors(item.status),
            priorityColor: AppColor.getPrioritiesColors(item.priority),
            deleteTaskCallBack: (taskId) {
              deleteTask(item.taskId);
            },
            onItemPressed: () =>
                AppNavigator.navigateToTaskDetails(context, item.taskId)
                    .then((value) {
              if (value is TaskModel) {
                print('value.status: ${value.status}');
                updateToTasksList(value);
              } else if (value is String) {
                deleteTask(value);
              }
            }),
            ifImageExist: item.imagePath.isEmpty,
          ),
        ));
  }
}
