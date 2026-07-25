import 'package:dartz/dartz.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/core/network/failures/failure.dart';
import 'package:tasky/features/tasks/data/repository/tasks_repository_impl.dart';

class DeleteTaskUseCase
    implements ParameterUseCase<Either<Failure, Unit>, TaskIdParameter> {
  late final TasksRepositoryImpl _repo;

  DeleteTaskUseCase(this._repo);

  @override
  Future<Either<Failure, Unit>> perform(TaskIdParameter parameter) async =>
      _repo.deleteTask(parameter.taskId);
}
