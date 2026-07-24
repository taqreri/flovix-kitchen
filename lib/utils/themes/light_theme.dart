import 'package:flovix_kitchen/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'themes.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  appBarTheme: const AppBarTheme(
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  colorScheme: ThemeData.light().colorScheme.copyWith(
        secondary: const Color(0xffa1a1a1),
        primary: const Color(0xff0F0425),
        onPrimary: const Color(0xff9694B8),
        outline: const Color(0xfff0f0f0),
        onSurface: const Color(0xfff6f8f8),
        surface: const Color(0xffDCE8E8),
        primaryContainer: Colors.white,
        onPrimaryContainer: const Color(0xffd8d8da),
      ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.white,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    linearTrackColor: Color(0xffECEAEA),
    color: ThemeConfig.primaryColor,
  ),
  primaryColor: ThemeConfig.primaryColor,
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => Colors.black.withOpacity(.4),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return GlobalColors.primaryColor;
        }
        return Colors.transparent;
      },
    ),
    checkColor: MaterialStateProperty.all(Colors.white),
    side: const BorderSide(
      color: Color(0xffC7C7C7),
      width: 1.5,
    ),
    overlayColor: MaterialStateProperty.all(
      GlobalColors.primaryColor.withOpacity(0.12),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: ThemeConfig.inter,
      ).copyWith(
        titleMedium: const TextStyle(
          fontFamily: ThemeConfig.inter,
          color: Colors.black,
        ),
        titleSmall: TextStyle(
          fontFamily: ThemeConfig.inter,
          color: Colors.black.withOpacity(.5),
        ),
        displayLarge: const TextStyle(
          fontFamily: ThemeConfig.inter,
          color: Colors.black,
        ),
        displayMedium: const TextStyle(
          fontFamily: ThemeConfig.inter,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: const TextStyle(
          fontFamily: ThemeConfig.inter,
          color: ThemeConfig.textColor6B698E,
        ),
        displaySmall: const TextStyle(
          fontFamily: ThemeConfig.inter,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: const TextStyle(
          fontFamily: ThemeConfig.inter,
          color: ThemeConfig.textColorBCBFC2,
        ),
      ),
);
