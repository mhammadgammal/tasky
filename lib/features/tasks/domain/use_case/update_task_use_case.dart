import 'package:dartz/dartz.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/features/tasks/data/repository/tasks_repository_impl.dart';

class UpdateTaskUseCase
    implements ParameterUseCase<Either<void, int>, TaskInstanceParameter> {
  late final TasksRepositoryImpl _repo;

  UpdateTaskUseCase(this._repo);

  @override
  Future<Either<void, int>> perform(TaskInstanceParameter parameter) async {
    var apiResponse = await _repo.addTask(parameter.task);
    if (apiResponse.response != null) {
      return const Left(null);
    } else {
      return Right(apiResponse.error);
    }
  }
}
