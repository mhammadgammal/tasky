import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/app_context.dart';
import 'package:tasky/core/cache/cache_helper.dart';
import 'package:tasky/core/utils/api_utils/dio_helper.dart';
import 'package:tasky/features/authentication/domain/use_case/login_use_case.dart';
import 'package:tasky/features/authentication/domain/use_case/register_use_case.dart';
import 'package:tasky/features/tasks/data/data_source/network/task_api_service.dart';
import 'package:tasky/features/tasks/data/repository/tasks_repository_impl.dart';
import 'package:tasky/features/tasks/domain/use_case/delete_task_use_case.dart';
import 'package:tasky/features/tasks/domain/use_case/get_all_tasks_use_case.dart';
import 'package:tasky/features/tasks/domain/use_case/get_task.dart';
import 'package:tasky/features/tasks/domain/use_case/update_task_use_case.dart';

import '../../features/authentication/data/network/authentication_api_sevice.dart';
import '../../features/authentication/data/repo/authentication_repo_impl.dart';
import '../../features/tasks/domain/use_case/add_task_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  print('Service Locator is Running');

  sl.registerLazySingleton<AppContext>(() => AppContext());
  // #region SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<CacheHelper>(() => CacheHelper(
        sl.get(),
      ));
  // #endregion

  // #region Dio
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerSingleton<DioHelper>(DioHelper(
    sl<Dio>(),
  ));

  // #endregion

  // #authentication

  sl.registerLazySingleton<AuthenticationApiSeviceImpl>(
      () => AuthenticationApiSeviceImpl());
  sl.registerLazySingleton<AuthenticationRepoImpl>(
      () => AuthenticationRepoImpl(sl<AuthenticationApiSeviceImpl>()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl.get()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl.get()));
  // #endregion

  // #tasks region
  sl.registerLazySingleton<TaskApiService>(() => TaskApiService());
  sl.registerLazySingleton<TasksRepositoryImpl>(
      () => TasksRepositoryImpl(sl.get()));
  sl.registerLazySingleton<GetAllTasksUseCase>(
      () => GetAllTasksUseCase(sl.get()));
  sl.registerLazySingleton<GetTaskUseCase>(() => GetTaskUseCase(sl.get()));
  sl.registerLazySingleton<AddTaskUseCase>(() => AddTaskUseCase(sl.get()));
  sl.registerLazySingleton<UpdateTaskUseCase>(
      () => UpdateTaskUseCase(sl.get()));
  sl.registerLazySingleton<DeleteTaskUseCase>(
      () => DeleteTaskUseCase(sl.get()));
  // #endregion
}
