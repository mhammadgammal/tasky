import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/theme/app_color.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';
import 'package:tasky/features/tasks/domain/use_case/get_all_tasks_use_case.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  late final GetAllTasksUseCase _getAllTasksUseCase;

  TasksCubit(this._getAllTasksUseCase) : super(TasksInitial());

  static TasksCubit get(context) => BlocProvider.of(context);

  List<String> taskTypeItems = ['All', 'Inprogress', 'Waiting', 'Finished'];
  int selectedTaskTypeIndex = 0;
  bool isSelectedType = false;
  List<TaskModel> tasks = [];

  Future<void> fetchAllTasks() async {
    var result = await _getAllTasksUseCase.perform();
    result.fold((tasks) {
      this.tasks = tasks;
      emit(TasksLoadSuccessState());
    }, (errorCode) {
      if (errorCode == 401) {
      } else if (errorCode == 403) {}
    });
  }

  (Color, Color) getStatusColors(int index) {
    switch (tasks[index].status) {
      case 'waiting':
        return (AppColor.redOrange, AppColor.veryLightPink);
      case 'In Progress':
        return (AppColor.mainColor, AppColor.paleLavender);
      case 'finished':
        return (AppColor.babyBlue, AppColor.lightBlue);
      default:
        return (Colors.white, Colors.white);
    }
  }

  Color getPrioritiesColors(int index) {
    switch (tasks[index].priority) {
      case 'high':
        return AppColor.redOrange;
      case 'medium':
        return AppColor.mainColor;
      case 'low':
        return AppColor.lightBlue;
      default:
        return Colors.white;
    }
  }

  void onTaskTypeSelected(bool isSelected, int selectedIndex) {
    isSelectedType = isSelected;
    selectedTaskTypeIndex = selectedIndex;
    emit(TaskTypeChanged());
  }
}
