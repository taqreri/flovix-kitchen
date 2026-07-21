import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:win32/win32.dart';

/// Lists printer queue names installed on Windows (USB/local drivers).
List<String> listWindowsInstalledPrinters() {
  if (!Platform.isWindows) return const [];

  final flags = PRINTER_ENUM_LOCAL;
  final pBuffSize = calloc<DWORD>();
  final bPrinterLen = calloc<DWORD>();

  try {
    EnumPrinters(flags, nullptr, 2, nullptr, 0, pBuffSize, bPrinterLen);
    if (pBuffSize.value == 0) {
      debugPrint('[USB/Windows] EnumPrinters: buffer size is 0');
      return const [];
    }

    final rawBuffer = calloc<Uint8>(pBuffSize.value);
    try {
      final ok = EnumPrinters(
        flags,
        nullptr,
        2,
        rawBuffer,
        pBuffSize.value,
        pBuffSize,
        bPrinterLen,
      );
      if (ok == 0) {
        debugPrint(
          '[USB/Windows] EnumPrinters failed: ${_win32LastErrorMessage()}',
        );
        return const [];
      }

      final names = <String>[];
      final printerInfo = rawBuffer.cast<PRINTER_INFO_2>();
      for (var i = 0; i < bPrinterLen.value; i++) {
        final name = printerInfo.elementAt(i).ref.pPrinterName.toDartString();
        if (name.isNotEmpty) names.add(name);
      }
      return names;
    } finally {
      calloc.free(rawBuffer);
    }
  } finally {
    calloc
      ..free(pBuffSize)
      ..free(bPrinterLen);
  }
}

void logWindowsUsbPrinterDiagnostics({
  String? configuredName,
  String? vendorId,
  String? productId,
  String? ipAddress,
  String? resolvedQueueName,
}) {
  if (!Platform.isWindows) return;

  final installed = listWindowsInstalledPrinters();
  debugPrint('════════ Windows USB printer diagnostics ════════');
  debugPrint('[USB/Windows] Configured name: ${configuredName ?? "(null)"}');
  debugPrint('[USB/Windows] vendor_id field: ${vendorId ?? "(null)"}');
  debugPrint('[USB/Windows] product_id field: ${productId ?? "(null)"}');
  debugPrint('[USB/Windows] ip_address field: ${ipAddress ?? "(null)"}');
  debugPrint('[USB/Windows] Resolved queue: ${resolvedQueueName ?? "(null)"}');
  debugPrint('[USB/Windows] Installed queues (${installed.length}):');
  for (final name in installed) {
    final match = resolvedQueueName != null &&
        name.toLowerCase() == resolvedQueueName.toLowerCase();
    debugPrint('  ${match ? "✓" : " "} $name');
  }
  if (resolvedQueueName != null &&
      installed.isNotEmpty &&
      !installed.any(
        (n) => n.toLowerCase() == resolvedQueueName.toLowerCase(),
      )) {
    debugPrint(
      '[USB/Windows] WARNING: resolved queue "$resolvedQueueName" not found in Windows. '
      'Re-select printer from scan list or fix counter printer name.',
    );
  }
  debugPrint('══════════════════════════════════════════════════');
}

String? matchWindowsPrinterQueueName({
  required String? preferredName,
  List<String>? installed,
}) {
  final candidates = <String>[];
  if (preferredName != null && preferredName.trim().isNotEmpty) {
    candidates.add(preferredName.trim());
  }

  final queues = installed ?? listWindowsInstalledPrinters();
  if (queues.isEmpty) return preferredName?.trim();

  for (final candidate in candidates) {
    for (final queue in queues) {
      if (queue.toLowerCase() == candidate.toLowerCase()) return queue;
    }
  }

  for (final candidate in candidates) {
    for (final queue in queues) {
      if (queue.toLowerCase().contains(candidate.toLowerCase()) ||
          candidate.toLowerCase().contains(queue.toLowerCase())) {
        return queue;
      }
    }
  }

  return preferredName?.trim();
}

/// Sends raw ESC/POS bytes to a Windows printer queue. Throws on failure.
void printEscPosToWindowsQueue(String queueName, List<int> data) {
  if (!Platform.isWindows) {
    throw UnsupportedError('Windows raw print is only supported on Windows');
  }
  if (queueName.trim().isEmpty) {
    throw ArgumentError('Windows printer queue name is empty');
  }
  if (data.isEmpty) {
    throw ArgumentError('Print data is empty');
  }

  final hPrinter = calloc<HANDLE>();
  final docInfo = calloc<DOC_INFO_1>();
  final printerNamePtr = queueName.toNativeUtf16();
  final docNamePtr = 'ESC/POS Print Job'.toNativeUtf16();

  try {
    docInfo.ref
      ..pDocName = docNamePtr
      ..pOutputFile = nullptr
      ..pDatatype = 'RAW'.toNativeUtf16();

    if (OpenPrinter(printerNamePtr, hPrinter, nullptr) == 0) {
      throw WindowsException(
        'OpenPrinter failed for "$queueName": ${_win32LastErrorMessage()}',
      );
    }

    final printerHandle = hPrinter.value;
    try {
      if (StartDocPrinter(printerHandle, 1, docInfo.cast()) == 0) {
        throw WindowsException(
          'StartDocPrinter failed: ${_win32LastErrorMessage()}',
        );
      }
      try {
        if (StartPagePrinter(printerHandle) == 0) {
          throw WindowsException(
            'StartPagePrinter failed: ${_win32LastErrorMessage()}',
          );
        }
        try {
          final buffer = Uint8List.fromList(data);
          final native = calloc<Uint8>(buffer.length);
          try {
            native.asTypedList(buffer.length).setAll(0, buffer);
            final bytesWritten = calloc<DWORD>();
            try {
              if (WritePrinter(
                    printerHandle,
                    native.cast(),
                    buffer.length,
                    bytesWritten,
                  ) ==
                  0) {
                throw WindowsException(
                  'WritePrinter failed: ${_win32LastErrorMessage()}',
                );
              }
              debugPrint(
                '[USB/Windows] Wrote ${bytesWritten.value} of ${buffer.length} bytes to "$queueName"',
              );
            } finally {
              calloc.free(bytesWritten);
            }
          } finally {
            calloc.free(native);
          }
        } finally {
          EndPagePrinter(printerHandle);
        }
      } finally {
        EndDocPrinter(printerHandle);
      }
    } finally {
      ClosePrinter(printerHandle);
    }
  } finally {
    calloc
      ..free(hPrinter)
      ..free(docInfo)
      ..free(printerNamePtr)
      ..free(docNamePtr);
    calloc.free(docInfo.ref.pDatatype);
  }
}

String _win32LastErrorMessage() {
  final code = GetLastError();
  if (code == 0) return 'unknown error';
  final buffer = calloc<Uint16>(256);
  try {
    final length = FormatMessage(
      FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
      nullptr,
      code,
      0,
      buffer.cast(),
      256,
      nullptr,
    );
    if (length == 0) return 'error code $code';
    return buffer.cast<Utf16>().toDartString().trim();
  } finally {
    calloc.free(buffer);
  }
}

class WindowsException implements Exception {
  WindowsException(this.message);
  final String message;
  @override
  String toString() => message;
}
