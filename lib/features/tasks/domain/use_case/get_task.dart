import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';

import '../../data/repository/tasks_repository_impl.dart';

class GetTaskUseCase
    implements ParameterUseCase<Either<TaskModel, int>, TaskIdParameter> {
  late final TasksRepositoryImpl _repo;

  GetTaskUseCase(this._repo);

  @override
  Future<Either<TaskModel, int>> perform(TaskIdParameter parameter) async {
    var apiResponse = await _repo.getTask(parameter.taskId);
    if (apiResponse.response != null) {
      var task = TaskModel.fromJson(apiResponse.response?.data);
      task.isImageExist = await File(task.imagePath).exists();
      return Left(task);
    } else {
      return Right(apiResponse.error);
    }
  }
}
