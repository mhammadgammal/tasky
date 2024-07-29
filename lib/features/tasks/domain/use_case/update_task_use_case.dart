import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/features/tasks/data/repository/tasks_repository_impl.dart';

class UpdateTaskUseCase
    implements ParameterUseCase<Either<Response, int>, TaskInstanceParameter> {
  late final TasksRepositoryImpl _repo;

  UpdateTaskUseCase(this._repo);

  @override
  Future<Either<Response, int>> perform(TaskInstanceParameter parameter) async {
    var apiResponse = await _repo.editTask(parameter.task);
    if (apiResponse.response != null) {
      return Left(apiResponse.response!);
    } else {
      return Right(apiResponse.error);
    }
  }
}
