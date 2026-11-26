import 'package:board_gamer_app/themes/colors.dart';
import 'package:flutter/material.dart';

class BoardGameSnackbarTheme {
  static SnackBarThemeData snackBarThemeData() {
    return SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: BoardGameColors.accent500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      insetPadding: EdgeInsets.all(20.0)
    );
  }

}