import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
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
  bool isImageExist = false;

  /// Page loader compatible with [PaginatableList]'s pageLoader signature.
  /// Fetches a raw page from the backend, accumulates it into [tasks], and
  /// returns only the items matching the currently selected task type.
  Future<List<TaskModel>> fetchTasksPage(int page, int pageSize) async {
    var pageResult = await _getAllTasksUseCase.perform(PageNumberParameter(page));
    return pageResult.fold((fetched) {
      tasks.addAll(fetched);
      return fetched.where(_matchesSelectedType).toList();
    }, (errorCode) {
      if (errorCode == 401) {
        // RefreshTokenInterceptor already cleared the session and
        // navigated to login once the refresh attempt failed.
        emit(SessionTerminated());
      }
      throw Exception('Failed to fetch tasks: $errorCode');
    });
  }

  bool _matchesSelectedType(TaskModel task) {
    switch (selectedTaskTypeIndex) {
      case 0:
        return true;
      case 1:
        return false;
      case 2:
        return task.status == 'waiting';
      case 3:
        return task.status == 'finished';
      default:
        return false;
    }
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

  List<TaskModel> getSelectedItems() =>
      tasks.where(_matchesSelectedType).toList();

  bool ifImageExist(String imagePath) {
    isImageExist = false;
    File(imagePath).exists().then((value) {
      isImageExist = value;
      emit(IsImageExistState());
    });
    return isImageExist;
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
