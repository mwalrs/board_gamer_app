import 'package:flutter/material.dart';

class BoardGameColors {
  static const Color accent100 = Color(0xFFFFF2EF);
  static const Color accent400 = Color(0xFFFF9783);
  static const Color accent500 = Color(0xFFEC3013);
  static const Color accent600 = Color(0xFFDD2B0F);
  static const Color accent700 = Color(0xFFAE1800);
  static const Color accent800 = Color(0xFF7C1405);

  static const MaterialColor applicationColor = MaterialColor(
    applicationColorValue,
    <int, Color>{
      // accent for hovering
      100: accent100,
      // lighter accent for red
      400: accent400,
      // default lightening for button and primary scopes like upcoming event
      500: accent500,
      // lightening for pressed buttons
      600: accent600,
      // lightening text highlighting for information like no game was elected
      700: accent700,
      // dark accent
      800: accent800,
    },
  );



  // default app color
  static const int applicationColorValue = 0xFFF3F2F2;
  // form color, affects cards, menus and data forms
  static const Color formColor = Color(0xFFEAE9E9);
  // text color default
  static const Color defaultText = Color(0xFF201E1D);
  // text color on red buttons
  static const Color buttonLabel = Color(0xFFFFFFFF);
  // unrated reviews star color
  static const Color unratedStars = Color(0xFFD7D3D3);
  static const Color ratedStars = Colors.amber;
  static const Color muted = Color(0xA3201E1D);
  static const Color divider = Color(0x66201E1D);
}