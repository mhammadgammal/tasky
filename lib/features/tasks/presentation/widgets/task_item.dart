import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_text_style.dart';
import 'package:tasky/core/widgets/over_flow_menu.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';
import 'package:tasky/features/tasks/presentation/widgets/task_thumbnail.dart';

import 'priority_widget.dart';
import 'progress_status_widget.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key,
      required this.task,
      required this.statusColors,
      required this.onItemPressed,
      required this.priorityColor,
      required this.deleteTaskCallBack,
      required this.ifImageExist});

  final TaskModel task;
  final (Color, Color) statusColors;
  final Color priorityColor;
  final void Function() onItemPressed;
  final dynamic Function(String) deleteTaskCallBack;
  final bool ifImageExist;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            onTap: onItemPressed,
            leading: TaskThumbnail(
                ifImageExist: ifImageExist, imagePath: task.imagePath),
            title: Row(
              children: [
                Expanded(
                    child: Text(
                  task.title,
                  maxLines: 1,
                  softWrap: true,
                  style: AppTextStyle.font18BlackBold,
                )),
                ProgressStatusWidget(task.status, statusColors),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriorityWidget(task.priority, priorityColor),
                    Text(task.timeStampCreatedAt.substring(0, 10)),
                  ],
                )
              ],
            ),
          ),
        ),
        Align(
          heightFactor: 1.8,
          widthFactor: 0.5,
          alignment: AlignmentDirectional.topCenter,
          child: OverFlowMenu(
              taskId: task.taskId, deleteTaskCallBack: deleteTaskCallBack),
        ),
      ],
    );
  }
}
