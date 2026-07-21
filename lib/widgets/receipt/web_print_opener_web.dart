import 'dart:html' as html;
import 'dart:typed_data';

/// Opens a PDF blob for printing when the `printing` package fails.
/// Prefer a new tab — most reliable on deployed hosts / CSP-restricted sites.
void openPdfBlobForBrowserPrint(
  Uint8List pdfBytes, {
  String documentName = 'Flovix POS Receipt',
}) {
  final blob = html.Blob([pdfBytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);

  // New tab with PDF — user can print with Ctrl/Cmd+P if auto-print is blocked.
  final opened = html.window.open(url, '_blank');
  if (opened == null) {
    // Popup blocked: navigate current tab to the PDF.
    html.window.location.assign(url);
  }

  Future<void>.delayed(const Duration(seconds: 120), () {
    html.Url.revokeObjectUrl(url);
  });
}
