// import 'dart:async';
// import 'dart:developer' as developer;
// import 'dart:typed_data';
// import 'dart:ui' as ui;
//
// import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:image/image.dart' as img;
// import 'package:printing/printing.dart';

// import 'package:thermal_printer/thermal_printer.dart';

// import 'dart:io';

import 'dart:async';
import 'dart:developer' as developer;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flovix_kitchen/widgets/receipt/windows_raw_printer_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart' as thermal_printer;
import 'package:image/image.dart' as img;
// import 'package:printing/printing.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'dart:io';

//
// class ThermalPrinter {
//   var printerManager = PrinterManager.instance;
//   var devices = [];
//
//   PrinterType getPrinterType(PrinterDevice printer) {
//     if (printer.vendorId != null && printer.productId != null) {
//       return PrinterType.usb;
//     } else if (printer.address != null && printer.address!.contains(':')) {
//       return PrinterType.bluetooth;
//     } else if (printer.address != null) {
//       return PrinterType.network;
//     } else {
//       throw Exception(
//           'Unable to determine printer type for device: ${printer.name}');
//     }
//   }
//
//   void _showStatusSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//   PrinterDevice createDummyPrinter() {
//     return PrinterDevice(
//       name: 'Dummy Printer',
//       address: 'dummy_address',
//       vendorId: "",
//       productId: "",
//     );
//   }
//
//   Future<List<PrinterDevice>> scan(PrinterType type,
//       {bool isBle = false}) async {
//     List<PrinterDevice> devices = [];
//
//     final completer = Completer<List<PrinterDevice>>();
//
//     PrinterManager.instance.discovery(type: type, isBle: isBle).listen(
//       (device) {
//         devices.add(device);
//       },
//       onError: (error) {
//         completer.completeError(error);
//       },
//       onDone: () {
//             'Scanning completed. Total ${type.toString()} devices found: ${devices.length}');
//         completer.complete(devices);
//       },
//       cancelOnError: true,
//     );
//
//     return completer.future;
//   }
//
//   /// Scan only for Network Printers
//   Future<List<PrinterDevice>> scanNetworkPrinters() async {
//     List<PrinterDevice> devices = [];
//
//     final completer = Completer<List<PrinterDevice>>();
//
//     PrinterManager.instance
//         .discovery(
//       type: PrinterType.network,
//       isBle: false,
//     )
//         .listen(
//       (device) {
//             '📡 Found Network Printer: ${device.name}, IP: ${device.address}');
//         devices.add(device);
//       },
//       onError: (error) {
//         completer.completeError(error);
//       },
//       onDone: () {
//             '✅ Scanning complete. Found ${devices.length} network printer(s).');
//         completer.complete(devices);
//       },
//       cancelOnError: true,
//     );
//
//     return completer.future;
//   }
//
//   Future<void> sendBytesToPrint({
//     required List<int> invoiceDataBytes,
//     required PrinterType printerType,
//   }) async {
//
//     try {
//       final profile = await CapabilityProfile.load();
//
//       final generator = Generator(PaperSize.mm58, profile);
//
//       List<int> bytes = [];
//       // Define invoice left margin (in mm or printer units depending on your generator)
//       const double leftMarginInvoice = 10.0;
//
//       // ---- STEP A: Add logo ----
//       final ByteData data = await rootBundle.load('assets/images/logo.png');
//       final Uint8List imgBytes = data.buffer.asUint8List();
//       final img.Image? logo = img.decodeImage(imgBytes);
//       if (logo != null) {
//         final img.Image resized = img.copyResize(logo, width: 100, height: 100);
//         bytes += generator.image(resized, align: PosAlign.center);
//       } else {
//       }
//
//       // ---- STEP B: Add header ----
//       bytes += generator.text(
//         'Invoice',
//         styles: PosStyles(
//           align: PosAlign.center,
//           bold: true,
//           height: PosTextSize.size2,
//         ),
//         linesAfter: 1,
//       );
//
//       // ---- STEP C: Separator ----
//       bytes += generator.text('--------------------------',
//           styles: PosStyles(align: PosAlign.center));
//
//       // ---- STEP D: Add invoice data with left/right margin ----
//       const leftMargin = '   '; // 3 spaces ~ 20px margin on 58mm paper
//       bytes += generator.text(
//         '$leftMarginInvoice Data:',
//         styles: PosStyles(align: PosAlign.left),
//       );
//
//       // Add user invoice data bytes (already formatted outside)
//       bytes += invoiceDataBytes;
//
//       // ---- STEP E: Separator ----
//       bytes += generator.text('--------------------------',
//           styles: PosStyles(align: PosAlign.center));
//
//       // ---- STEP F: Thank you message ----
//       bytes += generator.text(
//         'Thank you for your business!',
//         styles: PosStyles(
//           align: PosAlign.center,
//           bold: true,
//         ),
//         linesAfter: 2,
//       );
//
//       final printerManager = PrinterManager.instance;
//       await printerManager.send(type: printerType, bytes: bytes);
//
//     } catch (e, stackTrace) {
//       rethrow;
//     }
//   }
//
//   Future<void> connectDevice(
//       PrinterDevice selectedPrinter,
//       PrinterType type, {
//         bool reconnect = false,
//         bool isBle = false,
//         String? ipAddress,
//       }) async {
//   // ├─ Selected Printer: ${selectedPrinter.name}
//   // ├─ Address: ${selectedPrinter.address}
//   // ├─ Type: $type
//   // ├─ Reconnect: $reconnect
//   // ├─ isBle: $isBle
//   // ├─ IP Address (param): $ipAddress
//   // ├─ Vendor ID: ${selectedPrinter.vendorId}
//   // └─ Product ID: ${selectedPrinter.productId}
//   // ''');
//
//     // Ensure any previous printer connections are closed
//     await PrinterManager.instance.disconnect(type: type);
//     // await Future.delayed(const Duration(milliseconds: 300));
//
//     switch (type) {
//       case PrinterType.usb:
//         await PrinterManager.instance.connect(
//           type: type,
//           model: UsbPrinterInput(
//             name: selectedPrinter.name,
//             productId: selectedPrinter.productId,
//             vendorId: selectedPrinter.vendorId,
//           ),
//         );
//         break;
//
//       case PrinterType.bluetooth:
//         await PrinterManager.instance.connect(
//           type: type,
//           model: BluetoothPrinterInput(
//             name: selectedPrinter.name,
//             address: selectedPrinter.address ?? '',
//             isBle: isBle,
//             autoConnect: reconnect,
//           ),
//         );
//         break;
//
//       case PrinterType.network:
//         final targetIp = ipAddress ?? selectedPrinter.address!;
//         await PrinterManager.instance.connect(
//           type: type,
//           model: TcpPrinterInput(ipAddress: targetIp),
//         );
//         break;
//
//       default:
//         throw Exception('Unsupported printer type: $type');
//     }
//
//   }
//
//
//   Future<void> printPdfFile(
//       String filePath,
//       PrinterType printerType, {
//         String? ipAddress,
//         int port = 9100,
//         bool isBle = false,
//       }) async {
//
//     try {
//       final file = File(filePath);
//       if (!file.existsSync()) {
//         throw Exception("❌ PDF file not found at $filePath");
//       }
//
//       final pdfBytes = await file.readAsBytes();
//       final profile = await CapabilityProfile.load();
//       final generator = Generator(PaperSize.mm80, profile);
//       final List<int> bytes = [];
//
//       int pageIndex = 0;
//       int totalPages = 0;
//
//       // Count total pages
//       await for (final page in Printing.raster(pdfBytes, dpi: 203)) {
//         totalPages++;
//       }
//
//       // Process pages
//       await for (final page in Printing.raster(pdfBytes, dpi: 203)) {
//         pageIndex++;
//         final bool isLastPage = (pageIndex == totalPages);
//
//
//         final uiImage = await page.toImage();
//         final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
//
//         if (byteData == null) continue;
//
//         final decodedImg = img.decodeImage(byteData.buffer.asUint8List());
//         if (decodedImg == null) continue;
//
//         // Process image
//         final resized = img.copyResize(decodedImg, width: 576);
//         final grayscale = img.grayscale(resized);
//         final enhanced = img.adjustColor(grayscale, contrast: 1.2, brightness: 15);
//
//         final hasNonWhiteContent = _hasNonWhiteContent(enhanced);
//
//         if (hasNonWhiteContent) {
//
//           if (isLastPage) {
//
//             // Find EXACTLY where content ends on this page
//             final contentEndData = _findExactContentEndPosition(enhanced);
//             final contentEndY = contentEndData['contentEndY'];
//             final emptyBottomSpace = contentEndData['emptyBottomSpace'];
//
//             if (emptyBottomSpace > 100) {
//               // Significant empty space - crop the image to remove it
//               final croppedHeight = contentEndY + 30; // Keep content + 30px margin
//               final croppedImage = _cropImageToContent(enhanced, croppedHeight);
//
//               bytes.addAll(generator.image(croppedImage, align: PosAlign.center));
//
//               // Cut immediately after cropped content
//               bytes.addAll(generator.cut(mode: PosCutMode.full));
//
//             } else {
//               // Content fills most of the page
//               bytes.addAll(generator.image(enhanced, align: PosAlign.center));
//
//               // Small feed and cut
//               bytes.addAll(generator.feed(1));
//               bytes.addAll(generator.cut(mode: PosCutMode.full));
//             }
//
//           } else {
//             // Regular page (not last)
//             bytes.addAll(generator.image(enhanced, align: PosAlign.center));
//             bytes.addAll(generator.feed(2));
//           }
//
//         } else {
//
//           if (isLastPage) {
//             bytes.addAll(generator.feed(1));
//             bytes.addAll(generator.cut(mode: PosCutMode.full));
//           }
//         }
//       }
//
//       if (bytes.isNotEmpty) {
//         await printerManager.send(type: printerType, bytes: bytes);
//         await Future.delayed(Duration(milliseconds: 1000));
//       }
//
//     } catch (e, stack) {
//       rethrow;
//     }
//   }
//
//   /// Finds EXACTLY where content ends on the page
//   /// Improved content detection that can identify nearly-empty pages
//   Map<String, dynamic> _findExactContentEndPosition(img.Image image) {
//
//     final whiteThreshold = 240;
//     int lastContentRow = 0;
//     int totalDarkPixels = 0;
//     int consecutiveEmptyRows = 0;
//     const int maxConsecutiveEmpty = 5;
//
//     // Scan from bottom to top
//     for (int y = image.height - 1; y >= 0; y--) {
//       bool rowHasContent = false;
//       int darkPixelsInRow = 0;
//
//       // Scan entire row with dense sampling
//       for (int x = 0; x < image.width; x += 2) {
//         final pixel = image.getPixel(x, y);
//         final luminance = (pixel.r + pixel.g + pixel.b) ~/ 3;
//
//         if (luminance < whiteThreshold) {
//           darkPixelsInRow++;
//           totalDarkPixels++;
//         }
//       }
//
//       // If row has significant content
//       if (darkPixelsInRow > (image.width / 10)) { // At least 10% of row has content
//         rowHasContent = true;
//         lastContentRow = y > lastContentRow ? y : lastContentRow;
//         consecutiveEmptyRows = 0;
//       } else {
//         consecutiveEmptyRows++;
//         if (consecutiveEmptyRows >= maxConsecutiveEmpty && lastContentRow > 0) {
//           break;
//         }
//       }
//     }
//
//     // Calculate content density
//     final totalPixels = image.width * image.height;
//     final contentDensity = (totalDarkPixels / totalPixels * 100).round();
//     final emptyBottomSpace = image.height - lastContentRow;
//
//
//     return {
//       'contentEndY': lastContentRow,
//       'emptyBottomSpace': emptyBottomSpace,
//       'contentDensity': contentDensity,
//       'isMostlyEmpty': contentDensity < 5, // Page is mostly empty if less than 5% content
//     };
//   }
//   /// Crops image to remove empty bottom space
//   img.Image _cropImageToContent(img.Image image, int newHeight) {
//     final croppedHeight = newHeight.clamp(1, image.height);
//     final cropped = img.Image(width: image.width, height: croppedHeight);
//
//     for (int y = 0; y < croppedHeight; y++) {
//       for (int x = 0; x < image.width; x++) {
//         final pixel = image.getPixel(x, y);
//         cropped.setPixel(x, y, pixel);
//       }
//     }
//
//     return cropped;
//   }
//
//   bool _hasNonWhiteContent(img.Image image) {
//     final whiteThreshold = 240;
//
//     for (int y = 0; y < image.height; y += 15) {
//       for (int x = 0; x < image.width; x += 15) {
//         final pixel = image.getPixel(x, y);
//         final luminance = (pixel.r + pixel.g + pixel.b) ~/ 3;
//         if (luminance < whiteThreshold) {
//           return true;
//         }
//       }
//     }
//     return false;
//   }
//
//   /// Helper function to check if an image has non-white content
//   // bool _hasNonWhiteContent(img.Image image) {
//   //   final whiteThreshold = 245; // Consider pixels above this as "white"
//   //   final minNonWhitePixels =
//   //       10; // Minimum non-white pixels to consider as content
//   //
//   //   int nonWhitePixels = 0;
//   //
//   //   // Get the raw bytes of the image
//   //   final bytes = image.getBytes();
//   //
//   //   // Iterate through each pixel (4 bytes per pixel: RGBA)
//   //   for (int i = 0; i < bytes.length; i += 4) {
//   //     final r = bytes[i]; // Red
//   //     final g = bytes[i + 1]; // Green
//   //     final b = bytes[i + 2]; // Blue
//   //     // bytes[i + 3] is Alpha, but we don't need it for white detection
//   //
//   //     // If any color channel is below threshold, it's not white
//   //     if (r < whiteThreshold || g < whiteThreshold || b < whiteThreshold) {
//   //       nonWhitePixels++;
//   //       // Early return if we already found enough non-white pixels
//   //       if (nonWhitePixels >= minNonWhitePixels) {
//   //         return true;
//   //       }
//   //     }
//   //   }
//   //
//   //   return nonWhitePixels >= minNonWhitePixels;
//   // }
// }

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path/path.dart' as path;
import 'package:printing/printing.dart' as printing;

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:image/image.dart' as img;
import 'package:printing/printing.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:screenshot/screenshot.dart';

/// Logical receipt width (keep in sync with [kThermalPaperWidth] on payment screen).
const double kReceiptLogicalWidth = 384;

/// 80mm @ 203dpi — same width as the PDF raster path below.
const int kThermalRasterWidth = 576;

/// Fixed capture scale so iOS (3x) and Android (~2x) produce identical bitmaps.
const double kThermalCapturePixelRatio =
    kThermalRasterWidth / kReceiptLogicalWidth;

/// iMin built-in / 57–58mm roll (SDK text width 384 dots — do not upscale to 576).
const int kIminBuiltinRasterWidth = 384;
const double kIminBuiltinLogicalWidth = 384.0;
const double kIminBuiltinCapturePixelRatio = 1.0;

int _thermalWidthDivisibleBy8(int width) {
  if (width % 8 == 0) return width;
  return width + (8 - (width % 8));
}

img.Image _thermalRasterSafeWidth(img.Image image) {
  if (image.width % 8 == 0) return image;
  return img.copyResize(image, width: _thermalWidthDivisibleBy8(image.width));
}

/// Newer iOS captures PNGs with alpha; transparent pixels decode as black → solid print.
img.Image _flattenImageOnWhite(img.Image src) {
  final flat = img.Image(width: src.width, height: src.height, numChannels: 4);
  img.fill(flat, color: img.ColorRgba8(255, 255, 255, 255));
  img.compositeImage(flat, src, dstX: 0, dstY: 0);
  return flat;
}

/// Off-screen capture on recent iOS can use a black canvas instead of white.
bool _thermalCaptureIsMostlyDark(img.Image image, {int sampleStep = 14}) {
  var darkSamples = 0;
  var totalSamples = 0;
  for (var y = 0; y < image.height; y += sampleStep) {
    for (var x = 0; x < image.width; x += sampleStep) {
      final p = image.getPixel(x, y);
      if (p.a < 24) continue;
      final lum = (p.r + p.g + p.b) ~/ 3;
      if (lum < 140) darkSamples++;
      totalSamples++;
    }
  }
  if (totalSamples == 0) return false;
  return darkSamples / totalSamples > 0.72;
}

int _thermalCountInkPixels(img.Image image, {int maxLum = 150}) {
  var count = 0;
  const step = 10;
  for (var y = 0; y < image.height; y += step) {
    for (var x = 0; x < image.width; x += step) {
      final p = image.getPixel(x, y);
      if ((p.r + p.g + p.b) ~/ 3 < maxLum) count++;
    }
  }
  return count;
}

/// Share of sampled pixels that would print as ink (0–1).
double _thermalInkFillRatio(img.Image image, {int step = 8}) {
  var dark = 0;
  var total = 0;
  for (var y = 0; y < image.height; y += step) {
    for (var x = 0; x < image.width; x += step) {
      final p = image.getPixel(x, y);
      if (p.a < 24) continue;
      if ((p.r + p.g + p.b) ~/ 3 < 150) dark++;
      total++;
    }
  }
  if (total == 0) return 0;
  return dark / total;
}

/// Force 1-bit black/white — threshold must stay low enough to keep text ink.
void _thermalBinarizeInPlace(
  img.Image image, {
  int luminanceThreshold = 140,
}) {
  for (var y = 0; y < image.height; y++) {
    for (var x = 0; x < image.width; x++) {
      final p = image.getPixel(x, y);
      if (p.a < 128) {
        image.setPixelRgb(x, y, 255, 255, 255);
        continue;
      }
      final lum = (p.r + p.g + p.b) ~/ 3;
      if (lum < luminanceThreshold) {
        image.setPixelRgb(x, y, 0, 0, 0);
      } else {
        image.setPixelRgb(x, y, 255, 255, 255);
      }
    }
  }
}

/// Light horizontal stroke for built-in iMin (subtle bold, not full thicken).
img.Image _thermalSlightlyBoldenInk(img.Image image) {
  final w = image.width;
  final h = image.height;
  final out = img.Image.from(image);
  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      if ((image.getPixel(x, y).r +
              image.getPixel(x, y).g +
              image.getPixel(x, y).b) ~/
          3 <
          150) {
        if (x > 0) out.setPixelRgb(x - 1, y, 0, 0, 0);
        if (x < w - 1) out.setPixelRgb(x + 1, y, 0, 0, 0);
      }
    }
  }
  return out;
}

/// White background + solid black text, sized for thermal raster width.
img.Image _prepareImageForThermalPrint(
  img.Image src, {
  int rasterWidth = kThermalRasterWidth,
  bool iminBuiltIn = false,
}) {
  var image = _flattenImageOnWhite(src);

  if (_thermalCaptureIsMostlyDark(image)) {
    developer.log(
      'thermal: inverting mostly-dark capture (iOS off-screen render)',
      name: 'ThermalPrinter',
    );
    image = img.invert(image);
    image = _flattenImageOnWhite(image);
  }

  final targetWidth = _thermalWidthDivisibleBy8(rasterWidth);
  if (image.width != targetWidth) {
    image = img.copyResize(image, width: targetWidth);
  }
  image = _thermalRasterSafeWidth(image);

  image = img.grayscale(image);
  if (iminBuiltIn) {
    // Slightly darker than counter printers — mild bump only.
    image = img.adjustColor(image, contrast: 1.55, brightness: 10);
  } else {
    image = img.adjustColor(image, contrast: 1.55, brightness: 8);
  }

  final primaryThreshold = iminBuiltIn ? 140 : 140;
  final lowInkRetry = iminBuiltIn ? 100 : 100;
  final beforeBinarize = img.Image.from(image);
  _thermalBinarizeInPlace(image, luminanceThreshold: primaryThreshold);

  if (_thermalCountInkPixels(image) < 20) {
    developer.log(
      'thermal: ink pixels low after binarize, retry threshold=$lowInkRetry',
      name: 'ThermalPrinter',
    );
    image = img.Image.from(beforeBinarize);
    _thermalBinarizeInPlace(image, luminanceThreshold: lowInkRetry);
  }

  // Too much ink → solid black paper on some built-in printers.
  if (_thermalInkFillRatio(image) > 0.62) {
    developer.log(
      'thermal: ink fill too high, re-binarize with threshold=115',
      name: 'ThermalPrinter',
    );
    image = img.Image.from(beforeBinarize);
    _thermalBinarizeInPlace(image, luminanceThreshold: 115);
  }
  if (_thermalInkFillRatio(image) > 0.62) {
    developer.log(
      'thermal: ink fill still high, re-binarize with threshold=95',
      name: 'ThermalPrinter',
    );
    image = img.Image.from(beforeBinarize);
    _thermalBinarizeInPlace(image, luminanceThreshold: 95);
  }
  if (_thermalInkFillRatio(image) < 0.008) {
    developer.log(
      'thermal: ink fill too low (blank), re-binarize with threshold=130',
      name: 'ThermalPrinter',
    );
    image = img.Image.from(beforeBinarize);
    _thermalBinarizeInPlace(image, luminanceThreshold: 130);
  }

  if (iminBuiltIn) {
    image = _thermalSlightlyBoldenInk(image);
  }

  return image;
}

/// GS v 0 raster — reliable with pure B&W; chunk long receipts.
Uint8List _encodePreparedImageForThermal(
  img.Image image,
  Generator generator,
) {
  const chunkHeight = 40;
  final totalHeight = image.height;
  final totalWidth = image.width;
  final chunksCount = (totalHeight / chunkHeight).ceil();
  final bytes = <int>[];

  for (var i = 0; i < chunksCount; i++) {
    final startY = i * chunkHeight;
    final endY = (startY + chunkHeight > totalHeight)
        ? totalHeight
        : startY + chunkHeight;
    final cropped = img.copyCrop(
      image,
      x: 0,
      y: startY,
      width: totalWidth,
      height: endY - startY,
    );
    bytes.addAll(
      generator.imageRaster(
        cropped,
        highDensityHorizontal: true,
        highDensityVertical: true,
      ),
    );
  }
  return Uint8List.fromList(bytes);
}

/// Widget → PNG bitmap for iMin [IminPrinter.printBitmap] (white paper, black text).
Future<Uint8List> captureReceiptWidgetForIminBitmap(Widget widget) async {
  final controller = ScreenshotController();
  await Future<void>.delayed(const Duration(milliseconds: 600));

  final captureRoot = Theme(
    data: ThemeData(
      brightness: Brightness.light,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
    ),
    child: ColoredBox(
      color: Colors.white,
      child: widget,
    ),
  );

  final captured = await controller.captureFromLongWidget(
    captureRoot,
    pixelRatio: kIminBuiltinCapturePixelRatio,
    delay: const Duration(milliseconds: 150),
    constraints: const BoxConstraints(
      minWidth: kIminBuiltinLogicalWidth,
      maxWidth: kIminBuiltinLogicalWidth,
    ),
  );

  var imagebytes = img.decodeImage(captured);
  if (imagebytes == null) {
    throw Exception('Failed to decode captured receipt image');
  }

  imagebytes = _prepareImageForThermalPrint(
    imagebytes,
    rasterWidth: kIminBuiltinRasterWidth,
  );
  return Uint8List.fromList(img.encodePng(imagebytes));
}

/// Native apps talk to printers directly — no JSPrintManager.
Future<bool> isSilentPrintAvailable() async => false;

String silentPrintUnavailableMessage() =>
    'Silent print via JSPrintManager is only available in the web POS.';

/// Widget → bitmap at fixed DPI, then ESC/POS (cross-platform sizing).
///
/// Defaults match 80mm counter printers. Pass [logicalWidth], [pixelRatio], and
/// [rasterWidth] to override capture size.
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
  await Future<void>.delayed(const Duration(milliseconds: 600));

  final captureRoot = Theme(
    data: ThemeData(
      brightness: Brightness.light,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      dialogBackgroundColor: Colors.white,
    ),
    child: ColoredBox(
      color: Colors.white,
      child: widget,
    ),
  );

  final captured = await controller.captureFromLongWidget(
    captureRoot,
    pixelRatio: ratio,
    delay: const Duration(milliseconds: 150),
    constraints: BoxConstraints(
      minWidth: logicalWidth,
      maxWidth: logicalWidth,
    ),
  );

  var imagebytes = img.decodeImage(captured);
  if (imagebytes == null) {
    throw Exception('Failed to decode captured receipt image');
  }

  imagebytes = _prepareImageForThermalPrint(
    imagebytes,
    rasterWidth: targetRaster,
    iminBuiltIn: iminBuiltIn,
  );
  return _encodePreparedImageForThermal(imagebytes, generator);
}

/// On Windows, USB ESC/POS uses Win32 `OpenPrinter` with the installed queue name.
/// The plugin stores that name in [vendorId]/[address] during discovery, not Android USB ids.
String? windowsUsbQueueName({
  required String? name,
  required String? vendorId,
  String? ipAddress,
  String? availablePrinter,
}) {
  if (!Platform.isWindows) {
    return name?.trim();
  }

  bool looksLikeQueueName(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed.toLowerCase() == 'n/a') {
      return false;
    }
    if (trimmed.startsWith('USB:')) return false;
    if (RegExp(r'^(0x)?[0-9a-fA-F]+$').hasMatch(trimmed)) return false;
    if (RegExp(r'^\d+$').hasMatch(trimmed)) return false;
    return true;
  }

  for (final candidate in [vendorId, ipAddress, name, availablePrinter]) {
    if (candidate != null && looksLikeQueueName(candidate)) {
      return matchWindowsPrinterQueueName(preferredName: candidate.trim());
    }
  }
  return null;
}

class ThermalPrinter {
  final FlutterThermalPrinter _printerPlugin = FlutterThermalPrinter.instance;
  final NetworkInfo _networkInfo = NetworkInfo();

  List<thermal_printer.Printer> devices = [];
  StreamSubscription<List<thermal_printer.Printer>>? _devicesStreamSubscription;

  // Track connected printer
  thermal_printer.Printer? _connectedPrinter;

  // Add connection state management
  bool _isConnecting = false;
  bool _isPrinting = false;

  /// Main scan method that routes to appropriate scanner
  Future<List<thermal_printer.Printer>> scan(
      List<ConnectionType> connectionTypes) async {

    if (connectionTypes.contains(ConnectionType.NETWORK)) {
      return await scanNetworkPrinters();
    } else if (connectionTypes.contains(ConnectionType.BLE)) {
      return await scanBluetoothPrinters();
    } else if (connectionTypes.contains(ConnectionType.USB)) {
      return await scanUsbPrinters();
    } else {
      // Fallback to generic package scan
      return await _scanWithPackage(connectionTypes);
    }
  }

  /// Complete automated network printer discovery
  /// Network printer scanner using official package methods
  Future<List<thermal_printer.Printer>> scanNetworkPrinters() async {
    final Stopwatch stopwatch = Stopwatch()..start();

    try {
      // Method 1: Use package's built-in network discovery
      final packageResults = await _packageNetworkDiscovery();

     

      // Method 2: Fallback to manual IP scanning
      
      final manualResults = await manualIPScan();

      stopwatch.stop();
      
      return manualResults;
    } catch (e) {
      return [];
    }
  }

  /// Use package's built-in network discovery
  Future<List<thermal_printer.Printer>> _packageNetworkDiscovery() async {
    final List<thermal_printer.Printer> networkPrinters = [];
    final completer = Completer<List<thermal_printer.Printer>>();

    try {

      // Subscribe to devices stream
      final subscription = _printerPlugin.devicesStream.listen(
              (List<thermal_printer.Printer> devices) {

            // Filter for network printers
            final networkDevices = devices.where((printer) {
              return printer.connectionType == ConnectionType.NETWORK;
            }).toList();

            if (networkDevices.isNotEmpty) {
              networkPrinters.clear();
              networkPrinters.addAll(networkDevices);

              for (var printer in networkDevices) {
              }

              if (!completer.isCompleted) {
                completer.complete(networkPrinters);
              }
            }
          }, onError: (error) {
        if (!completer.isCompleted) {
          completer.complete([]);
        }
      });

      // Start network discovery using the package
      await _printerPlugin.getPrinters(
        connectionTypes: [ConnectionType.NETWORK],
      );

      // Wait for results with timeout
      final result = await completer.future.timeout(
        Duration(seconds: 15),
        onTimeout: () {
          return networkPrinters;
        },
      );

      await subscription.cancel();
      return result;
    } catch (e) {
      return [];
    }
  }

  /// Manual IP scanning as fallback
  Future<List<thermal_printer.Printer>> manualIPScan() async {
    final List<thermal_printer.Printer> printers = [];

    try {
      final NetworkInfo networkInfo = NetworkInfo();
      final wifiIP = await networkInfo.getWifiIP();

      if (wifiIP == null) {
        return printers;
      }

      // Extract network segment
      final parts = wifiIP.split('.');
      if (parts.length != 4) {
        return printers;
      }

      final networkBase = '${parts[0]}.${parts[1]}.${parts[2]}';
      final port = 9100; // Standard thermal printer port

      

      // Quick scan of most common IPs
      final commonIPs = _generateCommonIPs(networkBase);
      

      final tasks = <Future<void>>[];

      for (final ip in commonIPs) {
        final task = _testPrinterConnection(ip, port).then((isReachable) {
          if (isReachable) {
            printers.add(thermal_printer.Printer(
              name: 'Network Printer $ip',
              address: '$ip:$port',
              connectionType: ConnectionType.NETWORK,
              isConnected: false,
            ));
          }
        });
        tasks.add(task);
      }

      // Wait for all quick tests
      try {
        await Future.wait(tasks);
      } catch (e) {
      }
    } catch (e) {
    }

    return printers;
  }

  /// Scan for Bluetooth printers using official package methods
  Future<List<thermal_printer.Printer>> scanBluetoothPrinters() async {
    return await _scanWithPackage([ConnectionType.BLE]);
  }

  /// Scan for USB printers using official package methods
  Future<List<thermal_printer.Printer>> scanUsbPrinters() async {
    return await _scanWithPackage([ConnectionType.USB]);
  }

  /// Generic scanner using official package methods
  Future<List<thermal_printer.Printer>> _scanWithPackage(
      List<ConnectionType> types) async {
    final List<thermal_printer.Printer> devices = [];
    final completer = Completer<List<thermal_printer.Printer>>();

    try {

      final subscription = _printerPlugin.devicesStream.listen(
              (List<thermal_printer.Printer> discoveredPrinters) {

            // Filter devices by requested types
            final filteredPrinters = discoveredPrinters.where((printer) {
              return types.contains(printer.connectionType);
            }).toList();

            devices.clear();
            devices.addAll(filteredPrinters);

            // Log found devices
            for (var printer in filteredPrinters) {
            }

            if (!completer.isCompleted && devices.isNotEmpty) {
              completer.complete(devices);
            }
          }, onError: (error) {
        if (!completer.isCompleted) {
          completer.complete([]);
        }
      });

      // Start discovery using package
      await _printerPlugin.getPrinters(connectionTypes: types);

      // Wait for results with timeout
      final result = await completer.future.timeout(
        Duration(seconds: 15),
        onTimeout: () {
          return devices;
        },
      );

      await subscription.cancel();
      return result;
    } catch (e) {
      return [];
    }
  }

  /// Generate common IP addresses to scan
  List<String> _generateCommonIPs(String networkBase) {
    final commonEndings = [
      // Very common printer IPs
      1, 2, 10, 50, 100, 101, 102,
      200, 201, 202, 240, 254,
      // Additional common ranges
      3, 4, 5, 20, 30, 40, 60, 70, 80, 90,
      110, 120, 130, 140, 150, 160, 170, 180, 190,
      210, 220, 230, 250, 251, 252, 253
    ];

    return commonEndings.map((ending) => '$networkBase.$ending').toList();
  }

  /// Test printer connection
  Future<bool> _testPrinterConnection(String ip, int port) async {
    try {
      final socket =
      await Socket.connect(ip, port, timeout: Duration(milliseconds: 1000));
      await socket.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Enhanced connect method with better error handling
  /// Enhanced connect method with complete null safetyF
  Future<void> connectDevice(
      thermal_printer.Printer selectedPrinter, {
        bool reconnect = false,
        required bool isBle,
        Duration timeout = const Duration(seconds: 10),
      }) async {

    // Comprehensive null safety checks
    

    if (selectedPrinter.name == null) {
      throw Exception('Printer name cannot be null');
    }

    if (selectedPrinter.name!.isEmpty) {
      throw Exception('Printer name cannot be empty');
    }

    final isWindowsUsb = Platform.isWindows &&
        selectedPrinter.connectionType == ConnectionType.USB;

    if (isWindowsUsb) {
      final queueName = matchWindowsPrinterQueueName(
        preferredName: selectedPrinter.name ?? selectedPrinter.vendorId,
      );
      logWindowsUsbPrinterDiagnostics(
        configuredName: selectedPrinter.name,
        vendorId: selectedPrinter.vendorId,
        productId: selectedPrinter.productId,
        ipAddress: selectedPrinter.address,
        resolvedQueueName: queueName,
      );
      if (queueName == null || queueName.isEmpty) {
        throw Exception(
          'Windows USB printer queue name is missing. '
          'Re-select the printer from the USB scan list.',
        );
      }
      final installed = listWindowsInstalledPrinters();
      if (!installed.any((q) => q.toLowerCase() == queueName.toLowerCase())) {
        throw Exception(
          'Windows printer "$queueName" is not installed. '
          'Installed: ${installed.join(", ")}',
        );
      }
      _connectedPrinter = selectedPrinter;
      debugPrint('[USB/Windows] Ready to print via queue "$queueName"');
      return;
    }

    if (!isWindowsUsb) {
      if (selectedPrinter.address == null) {
        throw Exception('Printer address cannot be null');
      }

      if (selectedPrinter.address!.isEmpty) {
        throw Exception('Printer address cannot be empty');
      }
    }

    if (selectedPrinter.connectionType == null) {
      throw Exception('Printer connectionType cannot be null');
    }

    if (_isConnecting) {
      return;
    }

    try {
      _isConnecting = true;

      // Safe null check for connected printer comparison
      final isSamePrinter = _connectedPrinter != null &&
          _connectedPrinter?.address != null &&
          _connectedPrinter?.address == selectedPrinter.address;

      if (isSamePrinter && (selectedPrinter.isConnected == true)) {
        return;
      }

      // Safe disconnect logic
      if (reconnect || (_connectedPrinter != null && !isSamePrinter)) {
        try {
          if (_connectedPrinter != null) {
            await _printerPlugin.disconnect(_connectedPrinter!);
            await Future.delayed(const Duration(milliseconds: 500));
          }
          _connectedPrinter = null;
          
        } catch (e) {
        }
      }

      // Safe connection with timeout
      await _printerPlugin.connect(selectedPrinter).timeout(timeout,
          onTimeout: () {
            throw TimeoutException(
                'Printer connection timed out after ${timeout.inSeconds} seconds');
          });

      // Verify connection
      await Future.delayed(const Duration(milliseconds: 500));

      // Update connected printer reference and mark as connected
      _connectedPrinter = selectedPrinter;
      
      // Update the printer object's isConnected status
      // Note: Since Printer is likely immutable, we'll track connection via _connectedPrinter
      // But we need to ensure the printer object passed to print methods has isConnected = true

      
      
      
    } on TimeoutException catch (e) {
      _isConnecting = false;
      rethrow;
    } catch (e, stackTrace) {
      
      
      
      _isConnecting = false;
      rethrow;
    } finally {
      _isConnecting = false;
      
    }
  }

  /// Enhanced PDF printing with automatic connection management
  Future<void> printPdfFile(
  dynamic filePath,
      ConnectionType connectionType, {
        thermal_printer.Printer? specificPrinter,
        String? ipAddress,
        int port = 9100,
        BuildContext? context,
        bool autoConnect = true, // Auto connect if not connected
      }) async {
    
    
    
    
    
    
    

    if (_isPrinting) {
      throw Exception('Printing already in progress');
    }

    try {
      _isPrinting = true;

      // Validate file exists
      if(filePath is String) {
        final file = File(filePath);
        if (!file.existsSync()) {
          throw Exception("❌ PDF file not found at $filePath");
        }
      }

      // Network: rasterize then TCP print — skip USB/BLE connectDevice.
      if (connectionType == ConnectionType.NETWORK) {
        if (specificPrinter == null &&
            (ipAddress == null || ipAddress.trim().isEmpty)) {
          throw Exception(
              'For network printing, provide either specificPrinter or ipAddress');
        }
        final bytes = await _processPdfForPrinting(filePath, context);
        await _printViaNetwork(bytes, specificPrinter, ipAddress, port);
        return;
      }

      // Step 1: Connect to printer if needed (USB / BLE only)
      if (autoConnect && specificPrinter != null) {
        final isConnected = specificPrinter.isConnected ?? false;
        

        if (!isConnected) {
          await connectDevice(
            specificPrinter,
            isBle: connectionType == ConnectionType.BLE,
          );
        } else {
          _connectedPrinter = specificPrinter;
        }
      }

      // Step 2: Process PDF and generate print bytes
      final bytes = await _processPdfForPrinting(filePath,context);
      

      // Step 3: Print based on connection type
      switch (connectionType) {
        case ConnectionType.NETWORK:
          await _printViaNetwork(bytes, specificPrinter, ipAddress, port);
          break;

        case ConnectionType.USB:
        case ConnectionType.BLE:
          await _printViaPlugin(bytes, specificPrinter);
          break;

        default:
          throw Exception('Unsupported connection type: $connectionType');
      }

    } catch (e, stackTrace) {
      
      
      
      rethrow;
    } finally {
      _isPrinting = false;
    }
  }

  /// Send pre-built ESC/POS bytes (e.g. rasterized before leaving payment screen).
  Future<void> printEscPos(
    List<int> bytes,
    ConnectionType connectionType, {
    thermal_printer.Printer? specificPrinter,
    String? ipAddress,
    int port = 9100,
    bool autoConnect = true,
  }) async {
    if (_isPrinting) {
      throw Exception('Printing already in progress');
    }

    try {
      _isPrinting = true;

      // Network thermal printers: direct TCP :9100 — never use USB/BLE connect.
      if (connectionType == ConnectionType.NETWORK) {
        if (specificPrinter == null &&
            (ipAddress == null || ipAddress.trim().isEmpty)) {
          throw Exception(
            'For network printing, provide either specificPrinter or ipAddress',
          );
        }
        await _printViaNetwork(bytes, specificPrinter, ipAddress, port);
        return;
      }

      if (autoConnect && specificPrinter != null) {
        final isConnected = specificPrinter.isConnected ?? false;
        if (!isConnected) {
          await connectDevice(
            specificPrinter,
            isBle: connectionType == ConnectionType.BLE,
          );
        } else {
          _connectedPrinter = specificPrinter;
        }
      }

      switch (connectionType) {
        case ConnectionType.USB:
        case ConnectionType.BLE:
          await _printViaPlugin(bytes, specificPrinter);
          break;
        case ConnectionType.NETWORK:
          await _printViaNetwork(bytes, specificPrinter, ipAddress, port);
          break;
        default:
          throw Exception('Unsupported connection type: $connectionType');
      }
    } finally {
      _isPrinting = false;
    }
  }

  /// Process PDF file and convert to thermal printer bytes
  Future<List<int>> _processPdfForPrinting(dynamic filePath,BuildContext? context) async {

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    final List<int> bytes = [];

    /* =========================================================
   * CASE 1: Widget → Screenshot → ESC/POS (FAST, Arabic-safe)
   * ========================================================= ***/
    if (filePath is Widget) {
      try {
        // Fixed pixel ratio + 576px width — not View.devicePixelRatio (iOS is often 3x).
        final widgetBytesRaw = await captureReceiptWidgetForThermal(
          filePath,
          generator,
        );

        // Convert to growable list so we can add more bytes
        final List<int> widgetBytes = List<int>.from(widgetBytesRaw);
        widgetBytes.addAll(generator.cut(mode: PosCutMode.full));

        
        return widgetBytes;
      } catch (e, stack) {
        throw Exception('Widget screenshot print failed: $e');
      }
    }

    /* =========================================================
   * CASE 2: String → PDF → Raster → ESC/POS (CURRENT LOGIC)
   * ========================================================= ***/
    if (filePath is! String) {
      throw Exception(
        'Unsupported data type. Expected String (PDF path) or Widget',
      );
    }

    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception("❌ PDF file not found at $filePath");
    }

    final pdfBytes = await file.readAsBytes();

    // Single raster pass (was: count pass + process pass → 2× native decode work).
    // Build [img.Image] from raster RGBA directly — avoids ui.Image + PNG encode/decode.
    Future<void> emitPage(printing.PdfRaster page, bool isLastPage) async {
      final decodedImg = img.Image.fromBytes(
        width: page.width,
        height: page.height,
        bytes: page.pixels.buffer,
        bytesOffset: page.pixels.offsetInBytes,
        numChannels: 4,
        order: img.ChannelOrder.rgba,
      );

      final prepared = _prepareImageForThermalPrint(decodedImg);

      final hasNonWhiteContent = _hasNonWhiteContent(prepared);

      if (hasNonWhiteContent) {
        bytes.addAll(_encodePreparedImageForThermal(prepared, generator));
        if (isLastPage) {
          bytes.addAll(generator.cut(mode: PosCutMode.full));
        } else {
          bytes.addAll(generator.feed(2));
        }
      } else if (isLastPage) {
        bytes.addAll(generator.cut(mode: PosCutMode.full));
      }
    }

    printing.PdfRaster? pending;
    await for (final page in printing.Printing.raster(pdfBytes, dpi: 203)) {
      if (pending != null) {
        await emitPage(pending, false);
      }
      pending = page;
    }
    if (pending != null) {
      await emitPage(pending, true);
    }

    if (bytes.isEmpty) {
      throw Exception('No printable content found');
    }

    return bytes;
  }

  /// Print via network connection (Android / iOS / desktop).
  /// Prefer raw TCP :9100 — same path as POS counters expect.
  Future<void> _printViaNetwork(
      List<int> bytes,
      thermal_printer.Printer? specificPrinter,
      String? ipAddress,
      int port,
      ) async {

    final targetIp = (ipAddress ??
            specificPrinter?.address?.split(':').first ??
            '')
        .trim();
    if (targetIp.isEmpty) {
      throw Exception('Network printer IP is missing');
    }
    final targetPort = port <= 0 ? 9100 : port;

    debugPrint(
      '[thermal] network print ${bytes.length} bytes → $targetIp:$targetPort',
    );

    try {
      await _printViaRawSocket(bytes, targetIp, targetPort);
      return;
    } catch (socketError) {
      debugPrint('[thermal] raw socket failed: $socketError — trying plugin');
    }

    try {
      if (specificPrinter != null && (specificPrinter.isConnected ?? false)) {
        await _printerPlugin.printData(
          specificPrinter,
          bytes,
          longData: true,
        );
        return;
      }
      final service =
          FlutterThermalPrinterNetwork(targetIp, port: targetPort);
      await service.connect();
      await service.printTicket(bytes);
      await service.disconnect();
    } catch (e) {
      throw Exception(
        'Network print failed ($targetIp:$targetPort): $e',
      );
    }
  }

  /// Network print via raw TCP (ESC/POS port, usually 9100).
  Future<void> _printViaRawSocket(List<int> bytes, String ip, int port) async {
    try {
      final socket = await Socket.connect(
        ip,
        port,
        timeout: const Duration(seconds: 8),
      );
      socket.add(bytes);
      await socket.flush();
      await socket.close();
    } on SocketException catch (e) {
      final detail = e.message.toLowerCase();
      final timedOut = detail.contains('timed out') || e.osError?.errorCode == 110;
      if (timedOut) {
        throw Exception(
          'Cannot reach printer at $ip:$port. '
          'Put this device on the same Wi‑Fi as the printer, '
          'confirm the IP in counter settings, and that port 9100 is open.',
        );
      }
      throw Exception('Raw socket printing failed ($ip:$port): $e');
    } catch (e) {
      throw Exception('Raw socket printing failed ($ip:$port): $e');
    }
  }

  /// Print via plugin (for USB/BLE) or Win32 RAW queue on Windows USB.
  Future<void> _printViaPlugin(
      List<int> bytes, thermal_printer.Printer? specificPrinter)
  async {
    if (specificPrinter == null) {
      throw Exception('Specific printer required for USB/BLE printing');
    }

    final isWindowsUsb = Platform.isWindows &&
        specificPrinter.connectionType == ConnectionType.USB;

    if (isWindowsUsb) {
      final queueName = matchWindowsPrinterQueueName(
        preferredName: specificPrinter.name ?? specificPrinter.vendorId,
      );
      logWindowsUsbPrinterDiagnostics(
        configuredName: specificPrinter.name,
        vendorId: specificPrinter.vendorId,
        productId: specificPrinter.productId,
        ipAddress: specificPrinter.address,
        resolvedQueueName: queueName,
      );
      if (queueName == null || queueName.isEmpty) {
        throw Exception('Windows USB printer queue name is missing');
      }
      debugPrint(
        '[USB/Windows] Sending ${bytes.length} bytes to "$queueName"',
      );
      printEscPosToWindowsQueue(queueName, bytes);
      return;
    }

    // Check if printer is connected by comparing with _connectedPrinter
    // This is more reliable than checking isConnected flag which might not be updated
    final isActuallyConnected = _connectedPrinter != null &&
        (_connectedPrinter?.name == specificPrinter.name ||
         _connectedPrinter?.address == specificPrinter.address ||
         (_connectedPrinter?.vendorId == specificPrinter.vendorId &&
          _connectedPrinter?.productId == specificPrinter.productId &&
          specificPrinter.vendorId != null &&
          specificPrinter.productId != null));

    if (!isActuallyConnected && !(specificPrinter.isConnected ?? false)) {
      
      if (_connectedPrinter != null) {
        
        
      }
      throw Exception('Printer not connected. Please connect the printer first.');
    }

    // Use _connectedPrinter if available, otherwise use specificPrinter
    final printerToUse = _connectedPrinter ?? specificPrinter;
    
    

    await _printerPlugin.printData(
      printerToUse,
      bytes,
      longData: true,
    );

    
  }

  /// Disconnect from current printer
  Future<void> disconnectCurrentPrinter() async {
    if (_connectedPrinter != null) {
      await _printerPlugin.disconnect(_connectedPrinter!);
      _connectedPrinter = null;
      
    }
  }

  // Keep your existing helper methods...
  Map<String, dynamic> _findExactContentEndPosition(img.Image image) {
    // Your existing implementation
    final whiteThreshold = 240;
    int lastContentRow = 0;
    int totalDarkPixels = 0;
    int consecutiveEmptyRows = 0;
    const int maxConsecutiveEmpty = 5;

    for (int y = image.height - 1; y >= 0; y--) {
      bool rowHasContent = false;
      int darkPixelsInRow = 0;

      for (int x = 0; x < image.width; x += 2) {
        final pixel = image.getPixel(x, y);
        final luminance = (pixel.r + pixel.g + pixel.b) ~/ 3;

        if (luminance < whiteThreshold) {
          darkPixelsInRow++;
          totalDarkPixels++;
        }
      }

      if (darkPixelsInRow > (image.width / 10)) {
        rowHasContent = true;
        lastContentRow = y > lastContentRow ? y : lastContentRow;
        consecutiveEmptyRows = 0;
      } else {
        consecutiveEmptyRows++;
        if (consecutiveEmptyRows >= maxConsecutiveEmpty && lastContentRow > 0) {
          break;
        }
      }
    }

    final totalPixels = image.width * image.height;
    final contentDensity = (totalDarkPixels / totalPixels * 100).round();
    final emptyBottomSpace = image.height - lastContentRow;

    return {
      'contentEndY': lastContentRow,
      'emptyBottomSpace': emptyBottomSpace,
      'contentDensity': contentDensity,
      'isMostlyEmpty': contentDensity < 5,
    };
  }

  img.Image _cropImageToContent(img.Image image, int newHeight) {
    final croppedHeight = newHeight.clamp(1, image.height);
    final cropped = img.Image(width: image.width, height: croppedHeight);

    for (int y = 0; y < croppedHeight; y++) {
      for (int x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);
        cropped.setPixel(x, y, pixel);
      }
    }

    return cropped;
  }

  bool _hasNonWhiteContent(img.Image image) {
    final whiteThreshold = 240;

    for (int y = 0; y < image.height; y += 15) {
      for (int x = 0; x < image.width; x += 15) {
        final pixel = image.getPixel(x, y);
        final luminance = (pixel.r + pixel.g + pixel.b) ~/ 3;
        if (luminance < whiteThreshold) {
          return true;
        }
      }
    }
    return false;
  }

  void dispose() {
    _devicesStreamSubscription?.cancel();
    _printerPlugin.stopScan();
    disconnectCurrentPrinter();
  }
}
