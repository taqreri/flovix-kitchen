import 'package:flutter/material.dart';

class GlobalColors {
  static const Color primaryColor = Color(0xFF086562);
  static const Color primaryColor5BB0B0 = Color(0xFF5BB0B0);
  static const Color accentGreen = Color(0xFF3B8D49);
  static const Color titleColor = Color(0xFF191C1D);
  static const Color whiteColor = Colors.white;
  static const Color bodyColor = Color(0xFF5F5E5E); static const Color redColor = Color(0xFFE57373);
  static const Color fieldBorder = Color(0xFFE5E7EB);
  static const Color pageBg = Color(0xFFF5F6F8);
  static const Color labelColor = Color(0xFF0C1421);
  static const Color textColor = Color(0xFF111827);
  static const Color hintColor = Color(0xFF8897AD);
  static const Color rightColor = Color(0xFF959CB6);
  static const Color borderColor = Color(0xFFD4E0D8);
  static const Color focusBorderColor = Color(0xFF2F8F3A);
  static const double pixel10 = 0.01;
  static const double pixel11 = 0.011;
  static const double pixel12 = 0.012;
  static const double pixel13 = 0.013;
  static const double pixel14 = 0.012;
  static const double pixel16 = 0.014;
  static const double pixel18 = 0.016;
  static const double pixel20 = 0.018;
  static const double pixel22 = 0.020;
  static const double pixel24 = 0.022;
  static const double pixel26 = 0.024;
  static const double borderRadius = 0.01;
  static const double fieldHeight = 0.07;

}

Color getHexColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}
