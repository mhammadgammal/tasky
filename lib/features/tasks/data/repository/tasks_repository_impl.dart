
import 'package:dio/dio.dart';
import 'package:tasky/core/utils/api_utils/api_response.dart';
import 'package:tasky/features/tasks/data/data_source/dto/task_dto.dart';
import 'package:tasky/features/tasks/data/data_source/network/task_api_service.dart';

import 'package:tasky/features/tasks/domain/entity/task_model.dart';

import '../../domain/repository/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TaskApiService _apiService;

  TasksRepositoryImpl(this._apiService);

  @override
  Future<ApiResponse> addTask(TaskModel task) async {
    TaskDto taskDto = TaskDto(
        taskId: task.taskId,
        title: task.title,
        description: task.description,
        imagePath: task.imagePath,
        priority: task.priority,
        status: task.status,
        userId: task.userId,
        timeStampCreatedAt: task.timeStampCreatedAt,
        timeStampUpdatedAt: task.timeStampUpdatedAt);
    try {
      var response = await _apiService.addTask(taskDto);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      print(
          'Error adding task with code ${e.response?.statusCode}: ${e.message}');
      return ApiResponse.withError(e.response?.statusCode);
    }
  }

  @override
  Future<ApiResponse> deleteTask(String taskId) async {
    try {
      var response = await _apiService.deleteTask(taskId);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      print(
          'Error deleting task with code ${e.response?.statusCode}: ${e.message}');
      return ApiResponse.withError(e.response?.statusCode);
    }
  }

  @override
  Future<ApiResponse> editTask(TaskModel task) async {
    TaskDto taskDto = TaskDto(
        taskId: task.taskId,
        title: task.title,
        description: task.description,
        imagePath: task.imagePath,
        priority: task.priority,
        status: task.status,
        userId: task.userId,
        timeStampCreatedAt: task.timeStampCreatedAt,
        timeStampUpdatedAt: task.timeStampUpdatedAt);
    try {
      var response = await _apiService.editTask(taskDto);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      print(
          'Error updating task with code ${e.response?.statusCode}: ${e.message}');
      return ApiResponse.withError(e.response?.statusCode);
    }
  }

  @override
  Future<ApiResponse> getAllTasks() async {
    try {
      var response = await _apiService.getAllTasks();
      print('all tasks response: ${response.data}');
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      print(
          'Error updating task with code ${e.response?.statusCode}: ${e.message}');
      return ApiResponse.withError(e.response?.statusCode);
    }
  }

  @override
  Future<ApiResponse> getTask(String taskId) async {
    try {
      var response = await _apiService.getTask(taskId);
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      print(
          'Error updating task with code ${e.response?.statusCode}: ${e.message}');
      return ApiResponse.withError(e.response?.statusCode);
    }
  }
}
