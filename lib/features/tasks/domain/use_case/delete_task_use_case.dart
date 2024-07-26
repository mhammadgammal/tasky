import 'package:dartz/dartz.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/core/base_use_case/parameter_use_case.dart';
import 'package:tasky/features/tasks/data/repository/tasks_repository_impl.dart';

class DeleteTaskUseCase implements ParameterUseCase<Either<bool, int>, TaskIdParameter>{
  late final TasksRepositoryImpl _repo;

  DeleteTaskUseCase(this._repo);
  @override
  Future<Either<bool, int>> perform(TaskIdParameter parameter) async{
    var apiResponse = await _repo.deleteTask(parameter.taskId);
    if (apiResponse.response != null){
      return Left(apiResponse.response?.data['success']);
    }else{
      return Right(apiResponse.error);
    }
  }

}