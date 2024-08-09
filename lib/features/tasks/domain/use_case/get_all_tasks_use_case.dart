import 'package:dartz/dartz.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/features/tasks/data/repository/tasks_repository_impl.dart';

import '../../../../core/base_use_case/parameter_use_case.dart';
import '../entity/task_model.dart';

class GetAllTasksUseCase
    implements
        ParameterUseCase<Either<List<TaskModel>, int>, PageNumberParameter> {
  final TasksRepositoryImpl _repo;

  GetAllTasksUseCase(this._repo);

  @override
  Future<Either<List<TaskModel>, int>> perform(
      PageNumberParameter parameter) async {
    var apiResponse = await _repo.getAllTasks(parameter.pageNumber);
    List<TaskModel> tasks = [];
    if (apiResponse.response != null) {
      for (var task in apiResponse.response!.data) {
        var taskModel = TaskModel.fromJson(task);
        tasks.add(taskModel);
      }
      return Left(tasks);
    } else {
      return Right(apiResponse.error);
    }
  }
}
