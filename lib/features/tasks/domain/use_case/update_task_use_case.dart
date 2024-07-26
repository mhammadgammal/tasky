import 'package:dartz/dartz.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/features/tasks/data/repository/tasks_repository_impl.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';

class UpdateTaskUseCase
    implements
        ParameterUseCase<Either<TaskModel, int>, TaskInstanceParameter> {
  late final TasksRepositoryImpl _repo;

  UpdateTaskUseCase(this._repo);

  @override
  Future<Either<TaskModel, int>> perform(
      TaskInstanceParameter parameter) async {
    var apiResponse = await _repo.addTask(parameter.task);
    if (apiResponse.response != null) {
      return Left(TaskModel.fromJson(apiResponse.response?.data));
    } else {
      return Right(apiResponse.error);
    }
  }
}
