import 'package:firebase_authentication_flutter/theme_and_color/app_color.dart';
import 'package:flutter/material.dart';
@immutable
class AppTheme {
  static const colors=AppColors();
  const AppTheme._();

  static ThemeData define() {
    return ThemeData(
      fontFamily: "SFRegular",
      backgroundColor: Color(0xff064059),
      primaryColor: Color(0xff3B858D),
    );
  }

}
