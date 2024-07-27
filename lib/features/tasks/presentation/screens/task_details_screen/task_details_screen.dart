import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/tasks/presentation/screens/task_details_screen/task_details_body.dart';

import 'cubit/task_details_cubit.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskDetailsCubit, TaskDetailsState>(
      listener: (context, state) {
        if (state is TaskUpdateSuccessState) {
          print(
              'cubit.task.status: ${TaskDetailsCubit.get(context).task.status}');
          Navigator.pop(context, TaskDetailsCubit.get(context).task);
        }
      },
      builder: (context, state) {
        var cubit = TaskDetailsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async => await cubit.updateTask(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(state is TaskDetailLoadingState
                ? ''
                : cubit.getTaskField().title),
          ),
          body: state is TaskDetailLoadingState
              ? const Center(child: CircularProgressIndicator())
              : TaskDetailsBody(
                  cubit.task,
                  status: cubit.status,
                  selectedStatus: cubit.selectedStatus ?? cubit.status[0],
                  onStatusChanged: cubit.onStatusChanged,
                  priorities: cubit.priorities,
                  selectedPriority:
                      cubit.selectedPriority ?? cubit.priorities[0],
                  onPriorityChanged: cubit.onPriorityChanged,
                ),
        );
      },
    );
  }
}
