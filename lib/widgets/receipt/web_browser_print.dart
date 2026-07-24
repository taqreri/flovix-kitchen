import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flovix_kitchen/widgets/receipt/web_print_opener.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';


/// Receipt width used for browser PDF pages (approx 80mm thermal look).
const double kWebReceiptLogicalWidth = 384;

/// Opens the Chrome / browser print dialog for one or more receipt widgets.
///
/// Must be called while the app still has a valid frame (ideally during the
/// same user gesture / before navigating away). Deployed browsers block print
/// popups that open after async navigation.
Future<void> printReceiptWidgetsInBrowser(
  List<Widget> widgets, {
  String documentName = 'Flovix POS Receipt',
}) async {
  final pdfBytes = await buildReceiptPdfBytesFromWidgets(widgets);
  await printPdfBytesInBrowser(
    pdfBytes,
    documentName: documentName,
  );
}

Future<Uint8List> buildReceiptPdfBytesFromWidgets(
  List<Widget> widgets,
) async {
  final printable = widgets.toList();
  if (printable.isEmpty) {
    throw Exception('Nothing to print');
  }

  final images = <Uint8List>[];
  for (final widget in printable) {
    try {
      final png = await captureReceiptWidgetAsPng(widget);
      if (png.isNotEmpty) {
        images.add(png);
      }
    } catch (e, st) {
      debugPrint('receipt capture failed: $e\n$st');
    }
  }
  if (images.isEmpty) {
    throw Exception('Failed to capture receipt for browser print');
  }
  return buildReceiptPdfFromImages(images);
}

Future<void> printPdfBytesInBrowser(
  Uint8List pdfBytes, {
  String documentName = 'Flovix POS Receipt',
}) async {
  if (pdfBytes.isEmpty) {
    throw Exception('Empty PDF');
  }

  try {
    await Printing.layoutPdf(
      name: documentName,
      onLayout: (_) async => pdfBytes,
    );
    return;
  } catch (e, st) {
    debugPrint('Printing.layoutPdf failed, using browser fallback: $e\n$st');
  }

  // Fallback for hosts that block pdf.js CDN / printing plugin.
  openPdfBlobForBrowserPrint(pdfBytes, documentName: documentName);
}

Future<Uint8List> captureReceiptWidgetAsPng(
  Widget widget, {
  double logicalWidth = kWebReceiptLogicalWidth,
  double pixelRatio = 2.0,
}) async {
  final controller = ScreenshotController();
  // Give fonts/layout a moment — release builds on remote hosts need more time.
  await Future<void>.delayed(const Duration(milliseconds: 400));

  final captureRoot = Directionality(
    textDirection: TextDirection.ltr,
    child: MediaQuery(
      data: const MediaQueryData(
        size: Size(kWebReceiptLogicalWidth, 4000),
        devicePixelRatio: 1,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Theme(
          data: ThemeData(
            brightness: Brightness.light,
            canvasColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            dialogBackgroundColor: Colors.white,
            fontFamily: 'Roboto',
          ),
          child: ColoredBox(
            color: Colors.white,
            child: SizedBox(
              width: logicalWidth,
              child: widget,
            ),
          ),
        ),
      ),
    ),
  );

  final captured = await controller.captureFromLongWidget(
    captureRoot,
    pixelRatio: pixelRatio,
    delay: const Duration(milliseconds: 300),
    constraints: BoxConstraints(
      minWidth: logicalWidth,
      maxWidth: logicalWidth,
    ),
  );
  if (captured.isEmpty) {
    throw Exception('Empty receipt screenshot');
  }
  return captured;
}

Future<Uint8List> buildReceiptPdfFromImages(List<Uint8List> pngImages) async {
  final doc = pw.Document();
  for (final png in pngImages) {
    final image = pw.MemoryImage(png);
    final decoded = await _decodeImage(png);
    final width = decoded.width.toDouble();
    final height = decoded.height.toDouble();
    const pageWidth = 80.0 * PdfPageFormat.mm;
    final pageHeight = (pageWidth * (height / width)).clamp(
      80.0 * PdfPageFormat.mm,
      2000.0 * PdfPageFormat.mm,
    );

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(pageWidth, pageHeight, marginAll: 4),
        build: (context) {
          return pw.Center(
            child: pw.Image(image, fit: pw.BoxFit.contain),
          );
        },
      ),
    );
  }
  return doc.save();
}

Future<ui.Image> _decodeImage(Uint8List bytes) {
  final completer = Completer<ui.Image>();
  ui.decodeImageFromList(bytes, completer.complete);
  return completer.future;
}
