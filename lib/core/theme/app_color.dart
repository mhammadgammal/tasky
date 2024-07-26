import 'package:flutter/material.dart';

class AppColor {
  static const lightGrey = Color(0xFFD3D3D3);
  static const solidGrey = Color(0xFF7c7c80);
  static const mainColor = Color(0xFF5F33E1);
  static const unselectedChipColor = Color(0xFFe3dff1);
  static const redOrange = Color(0xFFff835d);
  static const veryLightPink = Color(0xFFffe4f2);
  static const paleLavender = Color(0xFFf0ecff);
  static const babyBlue = Color(0xFFe3f2ff);
  static const lightBlue = Color(0xFF0087ff);
  static const secondaryColor = Color(0xFFebe5ff);

  static (Color, Color) getStatusColors(String status) {
    switch (status) {
      case 'waiting':
        return (AppColor.redOrange, AppColor.veryLightPink);
      case 'In Progress':
        return (AppColor.mainColor, AppColor.paleLavender);
      case 'finished':
        return (AppColor.babyBlue, AppColor.lightBlue);
      default:
        return (Colors.white, Colors.white);
    }
  }

  static Color getPrioritiesColors(String priority) {
    switch (priority) {
      case 'high':
        return AppColor.redOrange;
      case 'medium':
        return AppColor.mainColor;
      case 'low':
        return AppColor.lightBlue;
      default:
        return Colors.white;
    }
  }
}
