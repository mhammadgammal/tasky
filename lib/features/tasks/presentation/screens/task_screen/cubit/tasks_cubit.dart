import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
      : super(TasksInitial()) {
    pageController = PagingController(firstPageKey: 0);
    pageController.addPageRequestListener((pageKey) => fetchAllTasks(pageKey));
  }

  static TasksCubit get(context) => BlocProvider.of(context);

  List<String> taskTypeItems = ['All', 'In progress', 'Waiting', 'Finished'];
  int selectedTaskTypeIndex = 0;
  bool isSelectedType = false;
  List<TaskModel> tasks = [];
  bool isImageExist = false;
  late final PagingController<int, TaskModel> pageController;

  Future<void> fetchAllTasks(int pageNumber,
      {bool isRefreshing = false}) async {
    emit(TasksLoadingState());
    var pageResult =
        await _getAllTasksUseCase.perform(PageNumberParameter(pageNumber));
    pageResult.fold((tasks) {
      if (tasks.isEmpty) {
        pageController.appendLastPage(tasks);
      } else if (isRefreshing) {
        pageController.itemList = tasks;
      } else {
        pageController.appendPage(tasks, pageNumber + 1);
      }
      this.tasks = pageController.itemList ?? [];
      pageController.itemList = getSelectedItems();
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
    pageController.itemList = getSelectedItems();
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
      pageController.itemList!.removeWhere((task) => task.taskId == taskId);
      emit(TaskDeletedSuccessfullyState());
    }, (error) {
      emit(TaskDeletedFailedState());
    });
  }
}
