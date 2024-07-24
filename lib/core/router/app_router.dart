import 'package:flutter/material.dart';
import 'package:tasky/core/router/router_helper.dart';
import 'package:tasky/features/boarding/boarding_screen.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> generateRoutes = {
    RouterHepler.boarding: (_) => const BoardingScreen(),
  }; 
}