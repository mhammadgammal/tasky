import 'package:dio/dio.dart';
import 'package:tasky/core/utils/api_utils/api_end_points.dart';
import 'package:tasky/core/utils/api_utils/dio_helper.dart';

import '../../../../../core/di/di.dart';
import '../dto/task_dto.dart';

abstract interface class TaskApiServiceI {
  Future<Response> getAllTasks(int pageNumber);

  Future<Response> getTask(String taskId);

  Future<Response> addTask(TaskDto task);

  Future<Response> editTask(TaskDto task);

  Future<Response> deleteTask(String taskId);

  Future<Response> uploadImage(FormData formData);
}

class TaskApiService implements TaskApiServiceI {
  @override
  Future<Response> addTask(TaskDto task) {
    var taskData = task.toJsonAdd();
    print('taskData: $taskData');
    return sl<DioHelper>().post(url: ApiEndPoints.todos, data: taskData);
  }

  @override
  Future<Response> deleteTask(String taskId) =>
      sl<DioHelper>().delete(url: '${ApiEndPoints.todos}/$taskId');

  @override
  Future<Response> editTask(TaskDto task) => sl<DioHelper>().put(
      url: '${ApiEndPoints.todos}/${task.taskId}', data: task.toJsonEdit());

  @override
  Future<Response> getAllTasks(int pageNumber) =>
      sl<DioHelper>().get(url: '${ApiEndPoints.todos}?page=$pageNumber');

  @override
  Future<Response> getTask(String taskId) =>
      sl<DioHelper>().get(url: '${ApiEndPoints.todos}/$taskId');

  @override
  Future<Response> uploadImage(FormData formData) =>
      sl<DioHelper>().postWithFormData(
        url: ApiEndPoints.uploadImage,
        data: formData,
      );
}
