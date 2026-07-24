// ignore_for_file: unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flovix_kitchen/utils/platform/platform_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Helpers {
  Helpers._();

  static String getLocale(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    return currentLocale.languageCode;
  }

  Future<bool> checkConnectivity() async {
    return Helpers.isOnline();
  }

  static bool _hasUsableConnection(dynamic result) {
    bool isUsable(ConnectivityResult value) {
      return value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi ||
          value == ConnectivityResult.ethernet ||
          value == ConnectivityResult.vpn ||
          value == ConnectivityResult.other ||
          value == ConnectivityResult.bluetooth;
    }

    if (result is List<ConnectivityResult>) {
      if (result.isEmpty) return _assumeOnlineWhenUnknown();
      if (result.every((e) => e == ConnectivityResult.none)) {
        return _assumeOnlineWhenUnknown();
      }
      return result.any(isUsable);
    }

    if (result is ConnectivityResult) {
      if (result == ConnectivityResult.none) {
        return _assumeOnlineWhenUnknown();
      }
      return isUsable(result);
    }

    return _assumeOnlineWhenUnknown();
  }

  /// Browsers and desktop often report inconclusive connectivity; prefer API
  /// attempts over blocking the POS when the plugin cannot detect a network type.
  static bool _assumeOnlineWhenUnknown() {
    return PlatformInfo.isWeb || PlatformInfo.isDesktop;
  }

  /// Returns true if device has network connectivity (wifi, mobile, or ethernet).
  /// Use this to decide whether to fetch from API (true) or load from local storage (false).
  static Future<bool> isOnline() async {
    if (PlatformInfo.isWeb) {
      try {
        final result = await Connectivity().checkConnectivity();
        return _hasUsableConnection(result);
      } catch (_) {
        return true;
      }
    }

    try {
      final result = await Connectivity().checkConnectivity();
      return _hasUsableConnection(result);
    } catch (_) {
      // On desktop, prefer attempting API calls over blocking on plugin errors.
      return PlatformInfo.isDesktop;
    }
  }
  static bool isTablet() {
    final width = ScreenUtil().screenWidth;
    final height = ScreenUtil().screenHeight;

    final shortestSide = width < height ? width : height;

    // Industry standard tablet breakpoint
    return shortestSide >= 600;
  }
static bool isPosDevice(){
    if(ScreenUtil().screenHeight<450){
      return true;
    }else{
      return false;
    }

}
  static double isScreenResolution() {

    debugPrint("isScreenResolution ${ScreenUtil().screenWidth}  ${ScreenUtil().screenHeight}");
    if(ScreenUtil().screenWidth>1110&&ScreenUtil().screenWidth<1260){
      return 0.9;
    }
    if(ScreenUtil().screenWidth>1280){
      return 0.85;
    }else{
      return 0.95;
    }

  }
}
