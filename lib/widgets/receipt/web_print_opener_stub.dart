import 'dart:typed_data';

/// Non-web stub — browser blob print is unavailable.
void openPdfBlobForBrowserPrint(
  Uint8List pdfBytes, {
  String documentName = 'Flovix POS Receipt',
}) {
  throw UnsupportedError('Browser PDF print is only available on web');
}
