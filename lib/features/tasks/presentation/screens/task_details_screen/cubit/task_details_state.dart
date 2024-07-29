part of 'task_details_cubit.dart';

@immutable
sealed class TaskDetailsState {}

final class TaskDetailsInitial extends TaskDetailsState {}

final class TaskDetailLoadingState extends TaskDetailsState {}

final class TaskLoadSuccessState extends TaskDetailsState {}

final class TaskLoadFailureState extends TaskDetailsState {}

final class StatusChangedState extends TaskDetailsState {}

final class PriorityChangedState extends TaskDetailsState {}

final class TaskUpdateSuccessState extends TaskDetailsState {}

final class TaskDeletedSuccessfullyState extends TaskDetailsState {}

final class TaskDeletedFailedState extends TaskDetailsState {}

final class TaskUpdateFailureState extends TaskDetailsState {
  final String e;

  TaskUpdateFailureState(this.e);
}
