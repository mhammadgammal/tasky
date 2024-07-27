part of 'add_task_cubit.dart';

@immutable
sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

final class PriorityChangedState extends AddTaskState {}

final class ImagePickedState extends AddTaskState {}

final class TaskAddedSuccessState extends AddTaskState {}

final class TaskAddFailedState extends AddTaskState {
  final String e;

  TaskAddFailedState(this.e);
}
