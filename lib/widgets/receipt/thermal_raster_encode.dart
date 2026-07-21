import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:image/image.dart' as img;

/// Shared thermal raster helpers (web + IO).
const int kSharedThermalRasterWidth = 576;

img.Image prepareImageForThermalPrint(
  img.Image src, {
  int rasterWidth = kSharedThermalRasterWidth,
}) {
  var image = _flattenOnWhite(src);
  final targetWidth = rasterWidth - (rasterWidth % 8);
  if (image.width != targetWidth) {
    image = img.copyResize(image, width: targetWidth);
  }
  image = img.grayscale(image);
  image = img.adjustColor(image, contrast: 1.55, brightness: 8);
  _binarizeInPlace(image, threshold: 140);
  return image;
}

Uint8List encodeImageToEscPosRaster(
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

img.Image _flattenOnWhite(img.Image src) {
  final out = img.Image(width: src.width, height: src.height);
  img.fill(out, color: img.ColorRgb8(255, 255, 255));
  img.compositeImage(out, src);
  return out;
}

void _binarizeInPlace(img.Image image, {required int threshold}) {
  for (final pixel in image) {
    final lum = img.getLuminanceRgb(pixel.r, pixel.g, pixel.b);
    final v = lum < threshold ? 0 : 255;
    pixel
      ..r = v
      ..g = v
      ..b = v;
  }
}
