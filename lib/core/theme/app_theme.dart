import 'package:flutter/material.dart';

import 'app_color.dart';

abstract final class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    iconButtonTheme: const IconButtonThemeData(
      style:
          ButtonStyle(iconColor: WidgetStatePropertyAll<Color>(Colors.white)),
    ),
    textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline)),
      foregroundColor: WidgetStatePropertyAll<Color>(AppColor.mainColor),
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(AppColor.mainColor),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    )),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0.0,
      elevation: 0.0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColor.mainColor, foregroundColor: Colors.white),
    cardTheme: CardTheme(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      color: Colors.white,
    ),
    // switchTheme: const SwitchThemeData(
    //   trackColor: WidgetStatePropertyAll<Color>(AppColors.lightShade1),
    // ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: Colors.white,
      cursorColor: Colors.white,
      selectionColor: AppColor.secondaryColor,
    ),
  );
}
