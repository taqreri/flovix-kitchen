import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter/foundation.dart';

/// Relative license path on the POS host (same origin).
/// Prefer `/jspm.php` — `/jspm` is 404 on pos.flovix.net without rewrite.
const String kJspmLicensePath = String.fromEnvironment(
  'JSPM_LICENSE_PATH',
  defaultValue: '/jspm.php',
);

@JS('FlovixJspm')
external JSObject? get _flovixJspm;

@JS('JSPM')
external JSObject? get _jspmGlobal;

bool get isJspmScriptLoaded =>
    _jspmGlobal != null && _flovixJspm != null;

JSObject get _bridge {
  final b = _flovixJspm;
  if (b == null) {
    throw Exception(
      'jspm_bridge.js not loaded. Ensure web/index.html includes jspm_bridge.js',
    );
  }
  return b;
}

Future<T> _awaitJsPromise<T extends JSAny?>(JSAny? maybePromise) async {
  if (maybePromise == null) {
    return null as T;
  }
  return await (maybePromise as JSPromise).toDart as T;
}

bool _jsTruthy(JSAny? value) {
  if (value == null) return false;
  if (value is JSBoolean) return value.toDart;
  final d = value.dartify();
  return d == true;
}

String? _jsString(JSAny? value) {
  if (value == null) return null;
  if (value is JSString) return value.toDart;
  final d = value.dartify();
  return d?.toString();
}

Future<void> _ensureJspmStarted() async {
  try {
    await _awaitJsPromise(_bridge.callMethod('ensureStarted'.toJS));
  } catch (e) {
    debugPrint('JSPM ensureStarted: $e');
    rethrow;
  }
}

Future<bool> isJspmClientOnline() async {
  if (!isJspmScriptLoaded) return false;
  try {
    return _jsTruthy(_bridge.callMethod('isOnline'.toJS));
  } catch (_) {
    return false;
  }
}

/// Human-readable reason when JSPM is not printable (for toasts / logs).
String jspmUnavailableReason() {
  if (!isJspmScriptLoaded) {
    return 'JSPrintManager scripts not loaded — redeploy web build '
        '(JSPrintManager.js + jspm_bridge.js) and hard-refresh.';
  }
  try {
    final err = _jsString(_bridge.callMethod('getLastError'.toJS));
    if (err != null && err.trim().isNotEmpty) return err.trim();
    final status = _jsString(_bridge.callMethod('getStatus'.toJS)) ?? 'unknown';
    return 'JSPrintManager Client App not connected (status=$status). '
        'Open https://pos.flovix.net/jspm-test.html on this PC — '
        'status must be READY before POS print works. '
        'Install Client App v9: https://neodynamic.com/downloads/jspm';
  } catch (e) {
    return 'JSPrintManager check failed: $e';
  }
}

Future<bool> isJspmReadyForPrint() async {
  if (!isJspmScriptLoaded) {
    debugPrint('JSPM: script not loaded (JSPM / FlovixJspm missing)');
    return false;
  }
  try {
    // ensureStarted only resolves once websocket_status === Open.
    await _ensureJspmStarted();
    debugPrint(
      'JSPM ready=true license via same-origin '
      '(tries /jspm.php then /jspm)',
    );
    return true;
  } catch (e) {
    debugPrint('isJspmReadyForPrint: $e');
    return false;
  }
}

/// Silent ESC/POS via Neodynamic JSPM Client App → network printer IP:port.
Future<void> silentPrintEscPosViaJspm({
  required String printerIp,
  required List<int> bytes,
  int port = 9100,
}) async {
  if (!isJspmScriptLoaded) {
    throw Exception(
      'JSPrintManager not loaded. Redeploy web build with JSPrintManager.js + jspm_bridge.js',
    );
  }

  try {
    await _awaitJsPromise(
      _bridge.callMethod(
        'printEscPos'.toJS,
        printerIp.toJS,
        port.toJS,
        base64Encode(bytes).toJS,
      ),
    );
  } catch (e) {
    throw Exception(
      'JSPrintManager print failed: $e. '
      'Confirm Client App is running and https://HOST/jspm.php returns Owner|hash.',
    );
  }
  debugPrint(
    'JSPM silent print OK → $printerIp:$port (${bytes.length} bytes)',
  );
}
