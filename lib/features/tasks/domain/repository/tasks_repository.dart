import 'package:tasky/core/utils/api_utils/api_response.dart';

import '../entity/task_model.dart';

abstract interface class TasksRepository {
  Future<ApiResponse> getAllTasks(int pageNumber);

  Future<ApiResponse> getTask(String taskId);

  Future<ApiResponse> addTask(TaskModel task);

  Future<ApiResponse> editTask(TaskModel task);

  Future<ApiResponse> deleteTask(String taskId);
}
