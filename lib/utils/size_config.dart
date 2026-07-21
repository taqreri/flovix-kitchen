import 'package:flutter/cupertino.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static double? _screenWidth;
  static double? _screenHeight;

  // Define a breakpoint for tablets
  static const double tabletBreakpoint = 600;

  static bool isTablet(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    return _mediaQueryData.size.shortestSide >= tabletBreakpoint;
  }

  static double width(BuildContext context, double m) {
    _mediaQueryData = MediaQuery.of(context);
    if (!isTablet(context)) {
      // Mobile-specific adjustments
      _screenWidth = _mediaQueryData.size.width * (m * 0.95); // slightly smaller on mobile
    } else {
      _screenWidth = _mediaQueryData.size.width * m; // keep tablet default
    }
    return _screenWidth!;
  }
  static double height(BuildContext context, double m) {
    _mediaQueryData = MediaQuery.of(context);
    
    if (!isTablet(context)) {
      // Mobile-specific adjustments
      _screenHeight = _mediaQueryData.size.height * (m * 0.95); // slightly smaller on mobile
    } else {
      _screenHeight = _mediaQueryData.size.height * m; // keep tablet default
    }
    return _screenHeight!;
  }

  static double horizontalPadding({required BuildContext context, double widthPad = 0.05}) {
    _mediaQueryData = MediaQuery.of(context);
    return _mediaQueryData.size.width * (isTablet(context) ? widthPad : widthPad * 0.9);
  }

  static double verticalPadding({required BuildContext context, double heightPad = 0.04}) {
    _mediaQueryData = MediaQuery.of(context);
    return _mediaQueryData.size.height * (isTablet(context) ? heightPad : heightPad * 0.95);
  }
}