import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/core/network/failures/failure.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';

import '../../data/repository/tasks_repository_impl.dart';

class GetTaskUseCase
    implements ParameterUseCase<Either<Failure, TaskModel>, TaskIdParameter> {
  late final TasksRepositoryImpl _repo;

  GetTaskUseCase(this._repo);

  @override
  Future<Either<Failure, TaskModel>> perform(
      TaskIdParameter parameter) async {
    final result = await _repo.getTask(parameter.taskId);
    if (result.isRight()) {
      final task = (result as Right<Failure, TaskModel>).value;
      task.isImageExist = await File(task.imagePath).exists();
    }
    return result;
  }
}
