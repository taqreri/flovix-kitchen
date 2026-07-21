import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Simple JSON key-value persistence for the web POS (online mode).
class WebLocalStore {
  WebLocalStore._();
  static final WebLocalStore instance = WebLocalStore._();

  Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  Future<String?> readString(String key) async {
    return (await _prefs).getString(key);
  }

  Future<void> writeString(String key, String value) async {
    await (await _prefs).setString(key, value);
  }

  Future<void> remove(String key) async {
    await (await _prefs).remove(key);
  }

  Future<void> clearPrefix(String prefix) async {
    final prefs = await _prefs;
    for (final key in prefs.getKeys()) {
      if (key.startsWith(prefix)) {
        await prefs.remove(key);
      }
    }
  }

  Future<Set<String>> allKeys() async => (await _prefs).getKeys();

  Future<String?> getString(String key) async => (await _prefs).getString(key);

  Future<List<String>> readAllWithPrefix(String prefix) async {
    final prefs = await _prefs;
    return prefs
        .getKeys()
        .where((k) => k.startsWith(prefix))
        .map((k) => prefs.getString(k) ?? '')
        .where((v) => v.isNotEmpty)
        .toList();
  }
}
