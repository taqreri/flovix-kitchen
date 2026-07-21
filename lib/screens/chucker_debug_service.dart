import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flovix_kitchen/config/app_env.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Hidden API inspector toggle for production/staging builds.
class ChuckerDebugService {
  ChuckerDebugService._();

  static const _prefKey = 'chucker_api_inspector_enabled';
  static const int secretTapCount = 5;

  static bool _enabled = false;

  static bool get isEnabled => _enabled;

  static bool get isAllowedFlavor =>
      AppEnv.flavor == 'production' || AppEnv.flavor == 'staging';

  static bool get shouldUseChucker =>
      kDebugMode || (_enabled && isAllowedFlavor);

  static bool get shouldRegisterNavigatorObserver => isAllowedFlavor;

  static Future<void> initialize() async {
    if (!isAllowedFlavor) return;

    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool(_prefKey) ?? false;
  }

  static void applyRuntimeConfig() {
    if (!isAllowedFlavor) return;
    ChuckerFlutter.showOnRelease = _enabled || kDebugMode;
    if (kDebugMode) {
      debugPrint(
        '[API/Chucker] enabled=${shouldUseChucker} '
        'flavor=${AppEnv.flavor} '
        'gestureEnabled=$_enabled '
        '(Windows: tap API button bottom-right, or login logo 5×)',
      );
    }
  }

  static Future<bool> enableFromSecretGesture() async {
    if (!isAllowedFlavor) return false;

    _enabled = true;
    ChuckerFlutter.showOnRelease = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, true);
    return true;
  }
}
