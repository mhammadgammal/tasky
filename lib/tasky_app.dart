import 'package:flutter/material.dart';
import 'package:tasky/core/cache/cache_keys.dart';
import 'package:tasky/core/router/app_router.dart';
import 'package:tasky/core/router/router_helper.dart';
import 'package:tasky/core/theme/app_theme.dart';

import 'app_context.dart';
import 'core/cache/cache_helper.dart';
import 'core/di/di.dart';

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String? refreshToken =
        sl<CacheHelper>().getString(key: CacheKeys.refreshToken);
    bool firstTime =
        sl<CacheHelper>().getBool(key: CacheKeys.firstTime) ?? true;
    print('firstTime: $firstTime');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      initialRoute: firstTime
          ? RouterHelper.boarding
          : refreshToken == null
              ? RouterHelper.login
              : RouterHelper.home,
      navigatorKey: sl<AppContext>().navigatorKey,
      routes: AppRouter.generateRoutes,
      theme: AppTheme.lightTheme,
    );
  }
}
