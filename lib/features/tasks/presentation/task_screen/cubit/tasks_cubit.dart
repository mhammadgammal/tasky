import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';
import 'package:tasky/features/tasks/domain/use_case/get_all_tasks_use_case.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  late final GetAllTasksUseCase _getAllTasksUseCase;

  TasksCubit(
      this._getAllTasksUseCase
      ) : super(TasksInitial());

  static TasksCubit get(context) => BlocProvider.of(context);

  List<TaskModel> tasks = [];
  Future<void> fetchAllTasks() async{
    var result = await _getAllTasksUseCase.perform();
    result.fold((tasks) {
      this.tasks = tasks;
      emit(TasksLoadSuccessState());
    }, (errorCode) {
      if(errorCode == 401) {}
      else if (errorCode == 403) {}
    });
  }
}
