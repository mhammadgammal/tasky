import 'package:dio/dio.dart';
import 'package:tasky/core/network/api_end_points.dart';
import 'package:tasky/core/network/dio_helper.dart';

import '../../../../../core/di/di.dart';
import '../../model/response/task_response.dart';

abstract interface class TaskApiServiceI {
  Future<Response> getAllTasks(int pageNumber);

  Future<Response> getTask(String taskId);

  Future<Response> addTask(TaskResponse task);

  Future<Response> editTask(TaskResponse task);

  Future<Response> deleteTask(String taskId);

  Future<Response> uploadImage(FormData formData);
}

class TaskApiService implements TaskApiServiceI {
  @override
  Future<Response> addTask(TaskResponse task) {
    var taskData = task.toJsonAdd();
    return sl<DioHelper>().post(ApiEndPoints.todos, data: taskData);
  }

  @override
  Future<Response> deleteTask(String taskId) =>
      sl<DioHelper>().delete('${ApiEndPoints.todos}/$taskId');

  @override
  Future<Response> editTask(TaskResponse task) => sl<DioHelper>().put(
      '${ApiEndPoints.todos}/${task.taskId}', data: task.toJsonEdit());

  @override
  Future<Response> getAllTasks(int pageNumber) =>
      sl<DioHelper>().get('${ApiEndPoints.todos}?page=1');

  @override
  Future<Response> getTask(String taskId) =>
      sl<DioHelper>().get('${ApiEndPoints.todos}/$taskId');

  @override
  Future<Response> uploadImage(FormData formData) =>
      sl<DioHelper>().postWithFormData(
        ApiEndPoints.uploadImage,
        data: formData,
      );
}
