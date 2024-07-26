import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/tasks/presentation/screens/edit_task/cubit/edit_task_cubit.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditTaskCubit, EditTaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Placeholder();
      },
    );
  }
}
