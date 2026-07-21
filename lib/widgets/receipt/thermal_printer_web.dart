import 'dart:async';
import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flovix_kitchen/widgets/receipt/thermal_raster_encode.dart';
import 'package:flovix_kitchen/widgets/receipt/web_browser_print.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:image/image.dart' as img;
import 'package:printing/printing.dart' hide Printer;
import 'package:screenshot/screenshot.dart';

import 'jspm_print_web.dart';


const double kReceiptLogicalWidth = 384;
const int kThermalRasterWidth = kSharedThermalRasterWidth;
const double kThermalCapturePixelRatio =
    kThermalRasterWidth / kReceiptLogicalWidth;
const int kIminBuiltinRasterWidth = 384;
const double kIminBuiltinLogicalWidth = 384.0;
const double kIminBuiltinCapturePixelRatio = 1.0;

/// Silent network print via **Neodynamic JSPrintManager Client App** only.
Future<void> silentPrintEscPosNetwork({
  required String printerIp,
  required List<int> bytes,
  int port = 9100,
}) async {
  if (!await isJspmReadyForPrint()) {
    throw Exception(silentPrintUnavailableMessage());
  }
  await silentPrintEscPosViaJspm(
    printerIp: printerIp,
    bytes: bytes,
    port: port,
  );
}

/// True when JSPrintManager Client App is connected, or scripts are loaded
/// so a print attempt can still call [ensureStarted].
Future<bool> isSilentPrintAvailable() async {
  if (!isJspmScriptLoaded) {
    debugPrint('isSilentPrintAvailable: scripts missing');
    return false;
  }
  // Fast path — already connected.
  if (await isJspmClientOnline()) {
    debugPrint('isSilentPrintAvailable: already online');
    return true;
  }
  // Try connect (Allow popup / Client App). Do not treat timeout as
  // "use PDF preview" — callers should still attempt printEscPos.
  final jspm = await isJspmReadyForPrint();
  debugPrint('isSilentPrintAvailable: jspm=$jspm');
  return jspm;
}

/// Toast when Client App is missing / blocked / not allowed.
String silentPrintUnavailableMessage() => jspmUnavailableReason();


Future<Uint8List> captureReceiptWidgetForThermal(
  Widget widget,
  Generator generator, {
  double logicalWidth = kReceiptLogicalWidth,
  double? pixelRatio,
  int? rasterWidth,
  bool iminBuiltIn = false,
}) async {
  final ratio = pixelRatio ?? kThermalCapturePixelRatio;
  final targetRaster = rasterWidth ?? kThermalRasterWidth;
  final controller = ScreenshotController();
  await Future<void>.delayed(const Duration(milliseconds: 400));

  final captureRoot = Directionality(
    textDirection: TextDirection.ltr,
    child: MediaQuery(
      data: const MediaQueryData(
        size: Size(kReceiptLogicalWidth, 4000),
        devicePixelRatio: 1,
      ),
      child: Theme(
        data: ThemeData(
          brightness: Brightness.light,
          canvasColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          dialogBackgroundColor: Colors.white,
        ),
        child: ColoredBox(
          color: Colors.white,
          child: SizedBox(width: logicalWidth, child: widget),
        ),
      ),
    ),
  );

  final captured = await controller.captureFromLongWidget(
    captureRoot,
    pixelRatio: ratio,
    delay: const Duration(milliseconds: 250),
    constraints: BoxConstraints(
      minWidth: logicalWidth,
      maxWidth: logicalWidth,
    ),
  );

  var imagebytes = img.decodeImage(captured);
  if (imagebytes == null) {
    throw Exception('Failed to decode captured receipt image');
  }
  imagebytes = prepareImageForThermalPrint(
    imagebytes,
    rasterWidth: targetRaster,
  );
  return encodeImageToEscPosRaster(imagebytes, generator);
}

String? windowsUsbQueueName({
  required String? name,
  required String? vendorId,
  String? ipAddress,
  String? availablePrinter,
}) =>
    name?.trim();

/// Web thermal printer — silent network print via Neodynamic JSPrintManager.
class ThermalPrinter {
  Future<List<Printer>> scan(List<ConnectionType> connectionTypes) async =>
      [];

  Future<List<Printer>> scanNetworkPrinters() async => [];

  Future<List<Printer>> scanBluetoothPrinters() async => [];

  Future<List<Printer>> scanUsbPrinters() async => [];

  Future<List<Printer>> manualIPScan() async => [];

  Future<void> connectDevice(
    Printer selectedPrinter, {
    bool reconnect = false,
    required bool isBle,
    Duration timeout = const Duration(seconds: 10),
    String? ipAddress,
    int? port,
    bool isUsb = false,
  }) async {}

  Future<void> printEscPos(
    List<int> bytes,
    ConnectionType connectionType, {
    Printer? specificPrinter,
    String? ipAddress,
    int port = 9100,
    bool autoConnect = true,
  }) async {
    final ip = (ipAddress ?? specificPrinter?.address)?.trim() ?? '';
    if (ip.isEmpty) {
      throw Exception('Network printer IP required for silent web print');
    }
    await silentPrintEscPosNetwork(
      printerIp: ip,
      bytes: bytes,
      port: port,
    );
  }

  Future<void> printPdfFile(
    dynamic filePath,
    ConnectionType connectionType, {
    Printer? specificPrinter,
    String? ipAddress,
    int port = 9100,
    BuildContext? context,
    bool autoConnect = true,
    bool isNetwork = false,
  }) async {
    final ip = (ipAddress ?? specificPrinter?.address)?.trim() ?? '';

    // Network IP configured → silent only (never Chrome preview).
    if (ip.isNotEmpty) {
      List<int>? escPos;
      if (filePath is List<int> && filePath.isNotEmpty) {
        escPos = filePath;
      } else if (filePath is Widget) {
        final profile = await CapabilityProfile.load();
        final generator = Generator(PaperSize.mm80, profile);
        final raster =
            await captureReceiptWidgetForThermal(filePath, generator);
        escPos = List<int>.from(raster)
          ..addAll(generator.cut(mode: PosCutMode.full));
      }
      if (escPos == null || escPos.isEmpty) {
        throw Exception('Unsupported print payload for silent web print');
      }
      await silentPrintEscPosNetwork(
        printerIp: ip,
        bytes: escPos,
        port: port,
      );
      return;
    }

    // No network IP: Chrome dialog fallback.
    if (filePath is Widget) {
      await printReceiptWidgetsInBrowser(
        [filePath],
        documentName: 'Flovix POS Receipt',
      );
      return;
    }

    Uint8List? pdfBytes;
    if (filePath is Uint8List) {
      pdfBytes = filePath;
    } else if (filePath is List<int>) {
      pdfBytes = Uint8List.fromList(filePath);
    }
    if (pdfBytes == null || pdfBytes.isEmpty) return;
    await Printing.layoutPdf(onLayout: (_) async => pdfBytes!);
  }

  void dispose() {}
}
