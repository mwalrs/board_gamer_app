import 'package:board_gamer_app/themes/elevated_button_theme.dart';
import 'package:board_gamer_app/themes/text_theme.dart';
import 'package:board_gamer_app/themes/colors.dart';
import 'package:board_gamer_app/themes/input_decoration_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: BoardGameColors.applicationColor,
      elevatedButtonTheme: BoardGameElevatedButtonTheme.elevatedButtonTheme(),
      textTheme: BoardGameTextTheme.customTestTheme(),
      inputDecorationTheme: BoardGameInputDecorationTheme.inputDecorationThemeData()
    );
  }
}