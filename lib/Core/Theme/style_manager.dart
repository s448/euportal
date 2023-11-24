import 'package:flutter/material.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'font_sizes.dart';

class StyleManager {
  static const font = "font";

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

  static const TextStyle bodyStyle = TextStyle(
    color: ColorManager.textC,
    fontFamily: font,
    fontSize: 14,
  );

  static const TextStyle hintStyle = TextStyle(
    color: ColorManager.greyC,
    fontFamily: font,
    fontSize: 12,
  );

  static BoxDecoration dropDownButtonDecoration = BoxDecoration(
    color: ColorManager.containerBackgroundC,
    borderRadius: BorderRadius.circular(10),
  );
}
