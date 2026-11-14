import 'package:board_gamer_app/themes/elevated_button_theme.dart';
import 'package:board_gamer_app/themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      elevatedButtonTheme: BoardGameElevatedButtonTheme.elevatedButtonTheme(),
      textTheme: BoardGameTextTheme.customTestTheme()
    );
  }
}