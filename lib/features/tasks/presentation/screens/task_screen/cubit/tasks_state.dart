part of 'tasks_cubit.dart';

@immutable
sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class TaskTypeChanged extends TasksState {}

final class TasksListUpdatedState extends TasksState {}

final class TasksLoadSuccessState extends TasksState {}
