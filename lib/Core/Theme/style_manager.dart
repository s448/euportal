import 'package:flutter/material.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'font_sizes.dart';

class StyleManager {
  static const font = "cairo";

  static final themeManager = ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    fontFamily: font,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorManager.backgroundColor,
    ),
    scaffoldBackgroundColor: ColorManager.backgroundColor,
    primaryColor: ColorManager.backgroundColor,
    hintColor: Colors.black54,
    appBarTheme: const AppBarTheme(
      color: ColorManager.backgroundColor,
      titleTextStyle: headline,
    ),
  );

  static const TextStyle headline = TextStyle(
    fontSize: headlineSize,
    fontFamily: font,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.4,
  );

  static const TextStyle whiteStyle = TextStyle(
    color: ColorManager.forgroundColor,
    fontFamily: font,
    fontSize: 12,
  );
}
