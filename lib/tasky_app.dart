import 'package:flutter/material.dart';
import 'package:tasky/core/router/app_router.dart';
import 'package:tasky/core/router/router_helper.dart';

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      initialRoute: RouterHepler.boarding,
      routes: AppRouter.generateRoutes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
