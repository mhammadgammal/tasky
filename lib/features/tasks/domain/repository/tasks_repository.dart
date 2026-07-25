import 'package:dartz/dartz.dart';
import 'package:tasky/core/network/failures/failure.dart';

import '../entity/task_model.dart';

abstract interface class TasksRepository {
  Future<Either<Failure, List<TaskModel>>> getAllTasks(int pageNumber);

  Future<Either<Failure, TaskModel>> getTask(String taskId);

  Future<Either<Failure, TaskModel>> addTask(TaskModel task);

  Future<Either<Failure, TaskModel>> editTask(TaskModel task);

  Future<Either<Failure, Unit>> deleteTask(String taskId);
}
