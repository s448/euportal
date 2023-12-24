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

  static const TextStyle greenHeadline = TextStyle(
    fontSize: headlineSize,
    fontFamily: font,
    fontWeight: FontWeight.bold,
    color: ColorManager.primaryC,
    height: 1.4,
  );

  static const TextStyle bodyStyle = TextStyle(
    color: ColorManager.textC,
    fontFamily: font,
    fontWeight: FontWeight.w200,
    fontSize: 14,
  );

  static const TextStyle redTip = TextStyle(
    color: Colors.red,
    fontFamily: font,
    fontSize: 8,
  );

  static const TextStyle details = TextStyle(
    color: ColorManager.secondaryC,
    fontFamily: font,
    fontSize: 8,
  );
  static const TextStyle floatingButtonText = TextStyle(
    color: Colors.white,
    fontFamily: font,
    fontSize: 7,
  );
  static const TextStyle info = TextStyle(
      fontSize: 10, color: ColorManager.textC, fontWeight: FontWeight.w500);

  static const TextStyle hintStyle = TextStyle(
    color: ColorManager.greyC,
    fontFamily: font,
    fontSize: 12,
  );

  static BoxDecoration dropDownButtonDecoration = BoxDecoration(
    color: ColorManager.containerBackgroundC,
    borderRadius: BorderRadius.circular(10),
  );

  static const TextStyle infoTitle = TextStyle(
    fontSize: infoTitleSize,
    fontFamily: font,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    height: 1.4,
  );
  static const TextStyle infoValue = TextStyle(
    fontSize: infoValueSize,
    fontFamily: font,
    fontWeight: FontWeight.w200,
    color: Colors.grey,
    height: 1.4,
  );

  static const rateStyle = TextStyle(
    color: Colors.yellow,
    fontSize: rateSize,
    fontFamily: font,
    fontWeight: FontWeight.w100,
  );

  static const smallSizedHint = TextStyle(
    color: ColorManager.secondaryC,
    fontSize: smallSize,
    fontFamily: font,
    fontWeight: FontWeight.w200,
  );
}
