import 'package:flutter/material.dart';

class ScreenUtil {
  static double getScreenWidth(context) => MediaQuery.sizeOf(context).width;
  static double getScreenHeight(context) => MediaQuery.sizeOf(context).height;
}
