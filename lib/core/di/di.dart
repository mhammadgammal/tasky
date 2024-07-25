import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/cache/cache_helper.dart';
import 'package:tasky/core/utils/api_utils/dio_helper.dart';
import 'package:tasky/features/authentication/domain/use_case/login_use_case.dart';
import 'package:tasky/features/authentication/domain/use_case/register_use_case.dart';

import '../../features/authentication/data/network/authentication_api_sevice.dart';
import '../../features/authentication/data/repo/authentication_repo_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  print('Service Locator is Running');

  // #region SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<CacheHelper>(() => CacheHelper(
        sl.get(),
      ));
  // #endregion

  // #region Dio
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DioHelper>(() => DioHelper(
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
}
