import 'package:dartz/dartz.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';

import '../../data/repository/tasks_repository_impl.dart';

class GetTask
    implements ParameterUseCase<Either<TaskModel, int>, TaskIdParameter> {
  late final TasksRepositoryImpl _repo;

  GetTask(this._repo);

  @override
  Future<Either<TaskModel, int>> perform(TaskIdParameter parameter) async {
    var apiResponse = await _repo.getTask(parameter.taskId);
    if (apiResponse.response != null) {
      return Left(TaskModel.fromJson(apiResponse.response?.data));
    } else {
      return Right(apiResponse.error);
    }
  }
}
