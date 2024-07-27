import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/utils/api_utils/api_error_handler.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';
import 'package:tasky/features/tasks/domain/use_case/get_task.dart';
import 'package:tasky/features/tasks/domain/use_case/update_task_use_case.dart';

part 'task_details_state.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  TaskDetailsCubit(this._getTaskUseCase, this._updateTaskUseCase)
      : super(TaskDetailsInitial());
  final GetTaskUseCase _getTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  static TaskDetailsCubit get(context) => BlocProvider.of(context);

  late TaskModel task;
  List<String> status = ['waiting', 'in progress', 'finished'];
  List<String> priorities = ['low', 'medium', 'high'];
  String? selectedStatus;
  String? selectedPriority;
  bool isChanged = false;

  TaskModel getTaskField() => task;

  Future<void> getTask(String taskId) async {
    emit(TaskDetailLoadingState());
    var response = await _getTaskUseCase.perform(TaskIdParameter(taskId));
    response.fold((task) {
      this.task = task;
      selectedStatus = task.status;
      selectedPriority = task.priority;

      emit(TaskLoadSuccessState());
    }, (error) {
      emit(TaskLoadFailureState());
    });
  }

  void onStatusChanged(String? value) {
    if (selectedStatus == value) {
      isChanged = true;
    }
    selectedStatus = value;
    emit(StatusChangedState());
  }

  void onPriorityChanged(String? value) {
    if (selectedPriority == value) {
      isChanged = true;
    }
    selectedPriority = value;
    emit(PriorityChangedState());
  }

  Future<void> updateTask() async {
    task.priority = selectedPriority!;
    task.status = selectedStatus!;
    var response =
        await _updateTaskUseCase.perform(TaskInstanceParameter(task));
    response.fold((_) {
      print('task.status: ${task.status}');
      print('task.priority: ${task.priority}');

      emit(TaskUpdateSuccessState());
    }, (e) {
      emit(TaskUpdateFailureState(ApiErrorHandler.handelErrorMessage(e)));
    });
  }
}
