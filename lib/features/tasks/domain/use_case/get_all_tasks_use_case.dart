import 'package:dartz/dartz.dart';
import 'package:tasky/features/tasks/data/repository/tasks_repository_impl.dart';

import '../../../../core/base_use_case/no_parameter_use_case.dart';
import '../entity/task_model.dart';

class GetAllTasksUseCase
    implements NoParameterUseCase<Either<List<TaskModel>, int>> {
  final TasksRepositoryImpl _repo;

  GetAllTasksUseCase(this._repo);

  @override
  Future<Either<List<TaskModel>, int>> perform() async {
    var apiResponse = await _repo.getAllTasks();
    List<TaskModel> tasks = [];
    if (apiResponse.response != null) {
      for (var task in apiResponse.response!.data) {
        tasks.add(TaskModel.fromJson(task));
      }
      return Left(tasks);
    } else {
      return Right(apiResponse.error);
    }
  }
}
