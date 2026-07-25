import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/network/failures/failure.dart';
import 'package:tasky/core/network/handle_response.dart';
import 'package:tasky/features/tasks/data/data_source/network/task_api_service.dart';
import 'package:tasky/features/tasks/data/model/response/task_response.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';

import '../../domain/repository/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TaskApiService _apiService;

  TasksRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, TaskModel>> addTask(TaskModel task) =>
      handleResponse(
        _sendWithImage(_toTaskResponse(task), _apiService.addTask),
        (response) => TaskModel.fromJson(response.data),
      );

  @override
  Future<Either<Failure, TaskModel>> editTask(TaskModel task) =>
      handleResponse(
        _sendWithImage(_toTaskResponse(task), _apiService.editTask),
        (response) => TaskModel.fromJson(response.data),
      );

  @override
  Future<Either<Failure, Unit>> deleteTask(String taskId) => handleResponse(
        _apiService.deleteTask(taskId),
        (response) => unit,
      );

  @override
  Future<Either<Failure, List<TaskModel>>> getAllTasks(int pageNumber) =>
      handleResponse(
        _apiService.getAllTasks(pageNumber),
        (response) => List<TaskModel>.from(
          response.data.map((task) => TaskModel.fromJson(task)),
        ),
      );

  @override
  Future<Either<Failure, TaskModel>> getTask(String taskId) => handleResponse(
        _apiService.getTask(taskId),
        (response) => TaskModel.fromJson(response.data),
      );

  TaskResponse _toTaskResponse(TaskModel task) => TaskResponse(
      taskId: task.taskId,
      title: task.title,
      description: task.description,
      imagePath: task.imagePath,
      priority: task.priority,
      status: task.status,
      userId: task.userId,
      timeStampCreatedAt: task.timeStampCreatedAt,
      timeStampUpdatedAt: task.timeStampUpdatedAt);

  Future<Response> _sendWithImage(TaskResponse taskResponse,
      Future<Response> Function(TaskResponse) send) async {
    if (taskResponse.imagePath.isNotEmpty) {
      taskResponse.imagePath = await _uploadImage(taskResponse.imagePath);
    }
    return send(taskResponse);
  }

  Future<String> _uploadImage(String imagePath) async {
    var formData = FormData();
    var fileName = imagePath.split('/').last;
    var multiPart = await MultipartFile.fromFile(
      imagePath,
      filename: fileName,
      contentType: DioMediaType.parse('image/*'),
    );
    formData.files.add(
      MapEntry("image", multiPart),
    );
    var response = await _apiService.uploadImage(formData);

    return response.data['image'];
  }
}
