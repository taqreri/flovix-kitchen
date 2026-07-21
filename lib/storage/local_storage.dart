import 'package:flovix_kitchen/utils/platform/platform_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Local storage for session data.
/// Mobile uses [FlutterSecureStorage]; desktop and web use [SharedPreferences].
class LocalStorage {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    wOptions: WindowsOptions(useBackwardCompatibility: true),
  );

  static bool get _useSharedPreferences =>
      PlatformInfo.isDesktop || PlatformInfo.isWeb;

  Future<bool> setValue(String key, String value) async {
    if (_useSharedPreferences) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.setString(_prefixedKey(key), value);
    }

    await _secureStorage.write(key: key, value: value);
    return true;
  }

  Future<dynamic> readValue(String key) async {
    if (_useSharedPreferences) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_prefixedKey(key));
    }

    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      debugPrint('Secure storage read failed for $key: $e');
      await _clearCorruptSecureStorage();
      return null;
    }
  }

  Future<bool> clearValue(String key) async {
    if (_useSharedPreferences) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.remove(_prefixedKey(key));
    }

    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      debugPrint('Secure storage delete failed for $key: $e');
    }
    return true;
  }

  static String _prefixedKey(String key) => 'zama_pos_$key';

  Future<void> _clearCorruptSecureStorage() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      debugPrint('Could not clear secure storage: $e');
    }
  }
}
