import 'package:flutter/material.dart';

class GlobalColors {
  static const Color primaryColor = Color(0xFF086562);
  static const Color primaryColor5BB0B0 = Color(0xFF5BB0B0);
  static const Color accentGreen = Color(0xFF3B8D49);
  static const Color titleColor = Color(0xFF191C1D);
  static const Color usernameColor = Color(0xFF1E293B);
  static const Color whiteColor = Colors.white;
  static const Color bodyColor = Color(0xFF5F5E5E);
  static const Color black60Color = Color(0xFF000000);

  static const Color redColor = Color(0xFFE57373);
  static const Color fieldBorder = Color(0xFFE5E7EB);
  static const Color pageBg = Color(0xFFF5F6F8);
  static const Color labelColor = Color(0xFF0C1421);
  static const Color textColor = Color(0xFF111827);
  static const Color productNameColor = Color(0xFF121C2A);
  static const Color productNotesColor = Color(0xFF979A9A);
  static const Color textTimeColor = Color(0xFF64748B);
  static const Color hintColor = Color(0xFF8897AD);
  static const Color searchIcon = Color(0xFF49454F);
  static const Color rightColor = Color(0xFF959CB6);
  static const Color borderColor = Color(0xFFD4E0D8);
  static const Color kdsColor = Color(0xFF03645D);
  static const Color focusBorderColor = Color(0xFF2F8F3A);

  // KDS status palette (Figma / kitchen display)
  static const Color kdsPageBg = Color(0xFFF1F5F9);
  static const Color kdsNew = Colors.white;
  static const Color kdsNewBg = Color(0xFF2563EB);
  static const Color dividerColor = Color(0xFFE5E5E5);
  static const Color kdsProcessing = Color(0xFFF59E0B);
  static const Color kdsProcessingBg = Color(0xFFF59E0B);
  static const Color kdsCompleted = Color(0xFF16A34A);
  static const Color kdsCompletedBg = Color(0xFF16A34A);
  static const Color kdsCancelled = Color(0xFFDC2626);
  static const Color kdsCancelledBg = Color(0xFFDC2626);
  static const Color kdsCardShadow = Color(0x14000000);
  static const Color kdsNotesBg = Color(0xFF03645D);
  static const Color cancelBg = Color(0xFFE2E8F0);
  static const Color cancelTextColor = Color(0xFF40493E);
  static const Color kdsMuted = Color(0xFF64748B);
  static const Color takeAway = Color(0xFFF9C43C);

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
