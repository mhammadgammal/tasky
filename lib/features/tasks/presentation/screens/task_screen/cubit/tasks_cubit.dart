import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/utils/api_utils/token_util.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';
import 'package:tasky/features/tasks/domain/use_case/get_all_tasks_use_case.dart';

import '../../../../domain/use_case/delete_task_use_case.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final GetAllTasksUseCase _getAllTasksUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  TasksCubit(this._getAllTasksUseCase, this._deleteTaskUseCase)
      : super(TasksInitial());

  static TasksCubit get(context) => BlocProvider.of(context);

  List<String> taskTypeItems = ['All', 'In progress', 'Waiting', 'Finished'];
  int selectedTaskTypeIndex = 0;
  bool isSelectedType = false;
  List<TaskModel> tasks = [];

  Future<void> fetchAllTasks() async {
    emit(TasksLoadingSuccessState());
    var result = await _getAllTasksUseCase.perform();
    result.fold((tasks) {
      this.tasks = tasks;
      emit(TasksLoadSuccessState());
    }, (errorCode) {
      if (errorCode == 401) {
        TokenUtil.logout().then((isLoggedOut) {
          isLoggedOut ? emit(SessionTerminated()) : null;
        });
      }
    });
  }

  void onTaskTypeSelected(bool isSelected, int selectedIndex) {
    isSelectedType = isSelected;
    selectedTaskTypeIndex = selectedIndex;
    emit(TaskTypeChanged());
  }

  void addToTasksList(TaskModel value) {
    tasks.add(value);
    emit(TasksListUpdatedState());
  }

  void updateToTasksList(TaskModel value) {
    int index = tasks.indexWhere((task) => task.taskId == value.taskId);
    tasks[index] = value;

    emit(TasksListUpdatedState());
  }

  List<TaskModel> getSelectedItems() {
    switch (selectedTaskTypeIndex) {
      case 0:
        return tasks;
      case 1:
        return [];
      case 2:
        return tasks.where((task) => task.status == 'waiting').toList();
      case 3:
        return tasks.where((task) => task.status == 'finished').toList();
      default:
        return [];
    }
  }

  Future<void> deleteTask(String taskId) async {
    var result = await _deleteTaskUseCase.perform(TaskIdParameter(taskId));
    result.fold((_) {
      tasks.removeWhere((task) => task.taskId == taskId);
      emit(TaskDeletedSuccessfullyState());
    }, (error) {
      emit(TaskDeletedFailedState());
    });
  }
}
