import 'package:flutter/material.dart';

import 'package:board_gamer_app/themes/colors.dart';

class BoardGameInputDecorationTheme {
  static InputDecorationThemeData inputDecorationThemeData() {
    return InputDecorationThemeData(
      filled: true,
      fillColor: Color(0xFFEAE9E9),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      constraints: const BoxConstraints(minHeight: 48),
      border: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: BoardGameColors.divider, width:  1)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: BoardGameColors.divider, width:  1)),
      hoverColor: Colors.transparent,
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: BoardGameColors.accent500, width:  2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: BoardGameColors.accent700, width:  1)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: BoardGameColors.accent700, width:  2)),
      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: BoardGameColors.divider, width:  1)),
      hintStyle: TextStyle(fontFamily: "Archivo", fontSize: 16, fontWeight: FontWeight.w400, color: BoardGameColors.muted),
      helperStyle: TextStyle(fontFamily: 'Archivo', fontSize: 12, fontWeight: FontWeight.w400, color: BoardGameColors.muted),
      errorStyle: TextStyle(fontFamily: 'Archivo', fontSize: 13, fontWeight: FontWeight.w600, color: BoardGameColors.muted),
      errorMaxLines: 2,
      floatingLabelBehavior: FloatingLabelBehavior.never
    );
  }
}