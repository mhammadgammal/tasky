import 'package:dartz/dartz.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/network/failures/failure.dart';
import 'package:tasky/features/tasks/data/repository/tasks_repository_impl.dart';

import '../../../../core/base_use_case/parameter_use_case.dart';
import '../entity/task_model.dart';

class GetAllTasksUseCase
    implements
        ParameterUseCase<Either<Failure, List<TaskModel>>,
            PageNumberParameter> {
  final TasksRepositoryImpl _repo;

  GetAllTasksUseCase(this._repo);

  @override
  Future<Either<Failure, List<TaskModel>>> perform(
          PageNumberParameter parameter) async =>
      _repo.getAllTasks(parameter.pageNumber);
}
