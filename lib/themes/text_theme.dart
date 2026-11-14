import 'package:flutter/material.dart';
import 'package:board_gamer_app/themes/colors.dart';

/*class BoardGameTextTheme {
  static const _fontStyle = 'Archivo';
  static const heroTitle = TextStyle(fontFamily: _fontStyle, fontSize: 34, fontWeight: FontWeight.w800, height: 1.08, letterSpacing: -0.68, color: BoardGameColors.defaultText);
  static const screenTitle = TextStyle(fontFamily: _fontStyle, fontSize: 30, fontWeight: FontWeight.w800, height: 1.10, letterSpacing: -0.60, color: BoardGameColors.defaultText);
  static const subTitle        = TextStyle(fontFamily: _fontStyle, fontSize: 28, fontWeight: FontWeight.w800, height: 1.10, letterSpacing: -0.56, color: BoardGameColors.defaultText);
  static const sectionTitle    = TextStyle(fontFamily: _fontStyle, fontSize: 28, fontWeight: FontWeight.w800, height: 1.15, letterSpacing: -0.42, color: BoardGameColors.defaultText);
  static const ratingValue     = TextStyle(fontFamily: _fontStyle, fontSize: 28, fontWeight: FontWeight.w800, height: 1.0, color: BoardGameColors.defaultText);
  static const heroCardGame    = TextStyle(fontFamily: _fontStyle, fontSize: 24, fontWeight: FontWeight.w800, height: 1.15, letterSpacing: -0.24, color: BoardGameColors.buttonLabel);
  static const dateNumber      = TextStyle(fontFamily: _fontStyle, fontSize: 21, fontWeight: FontWeight.w800, color: BoardGameColors.defaultText);
  static const appBarTitle     = TextStyle(fontFamily: _fontStyle, fontSize: 18, fontWeight: FontWeight.w600, color: BoardGameColors.defaultText);
  static const cardTitle       = TextStyle(fontFamily: _fontStyle, fontSize: 17, fontWeight: FontWeight.w800, height: 1.2, color: BoardGameColors.defaultText);
  static const bodyStrong      = TextStyle(fontFamily: _fontStyle, fontSize: 16, fontWeight: FontWeight.w600, color: BoardGameColors.defaultText);
  static const bodyGameItem    = TextStyle(fontFamily: _fontStyle, fontSize: 16, fontWeight: FontWeight.w700, color: BoardGameColors.defaultText);
  static const body            = TextStyle(fontFamily: _fontStyle, fontSize: 16, fontWeight: FontWeight.w400, color: BoardGameColors.defaultText);
  static const menuItem        = TextStyle(fontFamily: _fontStyle, fontSize: 15, fontWeight: FontWeight.w600, color: BoardGameColors.defaultText);
  static const noGameHint      = TextStyle(fontFamily: _fontStyle, fontSize: 15, fontWeight: FontWeight.w600, height: 1.2, color: BoardGameColors.accent700);
  static const bodySmall       = TextStyle(fontFamily: _fontStyle, fontSize: 14, fontWeight: FontWeight.w400, color: BoardGameColors.defaultText);
  static const bodySmallStrong = TextStyle(fontFamily: _fontStyle, fontSize: 14, fontWeight: FontWeight.w600, color: BoardGameColors.defaultText);
  static const button          = TextStyle(fontFamily: _fontStyle, fontSize: 14, fontWeight: FontWeight.w800, height: 1.2);
  static const meta            = TextStyle(fontFamily: _fontStyle, fontSize: 13, fontWeight: FontWeight.w400, color: BoardGameColors.muted);
  static const metaStrong      = TextStyle(fontFamily: _fontStyle, fontSize: 13, fontWeight: FontWeight.w600, color: BoardGameColors.defaultText);
  static const caption         = TextStyle(fontFamily: _fontStyle, fontSize: 12, fontWeight: FontWeight.w400, color: BoardGameColors.muted);
  static const badge           = TextStyle(fontFamily: _fontStyle, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.24, color: BoardGameColors.buttonLabel);
  static const overline        = TextStyle(fontFamily: _fontStyle, fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 0.88, color: BoardGameColors.muted); // .toUpperCase()
  static const kicker          = TextStyle(fontFamily: _fontStyle, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.10, color: BoardGameColors.defaultText);
  static const tag             = TextStyle(fontFamily: _fontStyle, fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 0.22, color: BoardGameColors.accent800);
  static const label           = TextStyle(fontFamily: _fontStyle, fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 0.66, color: BoardGameColors.defaultText);
  static const starGlyph       = TextStyle(fontSize: 22, height: 1.0);
}*/

class BoardGameTextTheme {
  static TextTheme customTestTheme() {
    const font = 'Archivo';
    return const TextTheme(
      displayMedium: TextStyle(fontFamily: font, fontSize: 34, fontWeight: FontWeight.w800, height: 1.08, letterSpacing: -0.68, color: BoardGameColors.defaultText),
      headlineMedium: TextStyle(fontFamily: font, fontSize: 30, fontWeight: FontWeight.w800, height: 1.10, letterSpacing: -0.60, color: BoardGameColors.defaultText),
      titleMedium: TextStyle(fontFamily: font, fontSize: 17, fontWeight: FontWeight.w800, height: 1.2, color: BoardGameColors.defaultText),
      labelMedium: TextStyle(fontFamily: font, fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 0.66, color: BoardGameColors.defaultText),
      bodyMedium: TextStyle(fontFamily: font, fontSize: 16, fontWeight: FontWeight.w400, color: BoardGameColors.defaultText)
    );
  }
}