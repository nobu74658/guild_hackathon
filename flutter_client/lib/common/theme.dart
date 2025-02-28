import 'package:flutter/material.dart';
import 'package:knitting/common/color.dart';

class AppTheme {
  static ThemeData get = ThemeData(
    useMaterial3: true,
    fontFamily: 'ZenMaruGothic',
    scaffoldBackgroundColor: AppColor.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.white,
      foregroundColor: AppColor.black,
    ),
  );
}
