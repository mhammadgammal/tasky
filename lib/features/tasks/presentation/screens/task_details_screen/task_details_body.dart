import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/core/theme/app_color.dart';
import 'package:tasky/core/theme/app_text_style.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';
import 'package:tasky/features/tasks/presentation/widgets/priority_drop_down_widget.dart';
import 'package:tasky/features/tasks/presentation/widgets/status_drop_down_widget.dart';

class TaskDetailsBody extends StatelessWidget {
  const TaskDetailsBody(this.task,
      {super.key,
      required this.status,
      required this.selectedStatus,
      required this.onStatusChanged,
      required this.priorities,
      required this.selectedPriority,
      required this.onPriorityChanged});

  final List<String> status;
  final String selectedStatus;
  final void Function(String?) onStatusChanged;
  final List<String> priorities;
  final String selectedPriority;
  final void Function(String?) onPriorityChanged;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 15.0, vertical: 15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.file(File(task.imagePath)),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            task.title,
            style: AppTextStyle.font20BlackBold,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            task.description,
            style: const TextStyle(color: AppColor.solidGrey, fontSize: 16.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
          StatusDropDownWidget(
              status: status,
              selectedStatus: selectedStatus,
              onStatusChanged: onStatusChanged),
          const SizedBox(
            height: 20.0,
          ),
          PriorityDropDownWidget(
              priorities: priorities,
              selectedPriority: selectedPriority,
              onPriorityChanged: onPriorityChanged),
          const SizedBox(
            height: 20.0,
          ),
          QrImageView(data: task.taskId),
        ]),
      ),
    );
  }
}
