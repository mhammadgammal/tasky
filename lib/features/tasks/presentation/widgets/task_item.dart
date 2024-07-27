import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_text_style.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';

import 'priority_widget.dart';
import 'progress_status_widget.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key,
      required this.task,
      required this.statusColors,
      required this.onItemPressed,
      required this.priorityColor});

  final TaskModel task;
  final (Color, Color) statusColors;
  final Color priorityColor;
  final void Function() onItemPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            onTap: onItemPressed,
            leading: const Icon(Icons.task),
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
          // width: 50.0,
          heightFactor: 1.8,
          widthFactor: 0.5,
          alignment: AlignmentDirectional.topCenter,
          child: PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              size: 30.0,
              color: Colors.black,
            ),
            onSelected: (String item) {
              // Handle the selected item here
              switch (item) {
                case 'Edit':
                  // Handle edit action
                  print('edit task');
                  break;
                case 'Delete':
                  // Handle delete action
                  print('delete task');
                  break;
                // Add more cases for other menu items
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Edit', 'Delete'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ),
      ],
    );
  }
}
