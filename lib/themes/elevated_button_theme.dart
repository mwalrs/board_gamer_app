import 'package:flutter/material.dart';
import 'package:board_gamer_app/themes/colors.dart';
import 'package:board_gamer_app/themes/text_theme.dart';

class BoardGameElevatedButtonTheme {
  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: BoardGameColors.accent500,
        foregroundColor: BoardGameColors.buttonLabel,
        textStyle: BoardGameTextTheme.customTextTheme().labelMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
        ),
      )
    );
  }
}