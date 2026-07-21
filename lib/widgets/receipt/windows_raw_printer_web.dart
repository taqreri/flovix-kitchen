import 'package:flutter/foundation.dart';

List<String> listWindowsInstalledPrinters() => const [];

void logWindowsUsbPrinterDiagnostics({
  String? configuredName,
  String? vendorId,
  String? productId,
  String? ipAddress,
  String? resolvedQueueName,
}) {
  debugPrint('[Web POS] Windows USB printer diagnostics skipped.');
}

String? matchWindowsPrinterQueueName({
  required String? preferredName,
  List<String>? installed,
}) =>
    preferredName?.trim();

void printEscPosToWindowsQueue(String queueName, List<int> data) {
  throw UnsupportedError('Windows raw print is not supported on web');
}

class WindowsException implements Exception {
  WindowsException(this.message);
  final String message;
  @override
  String toString() => message;
}
