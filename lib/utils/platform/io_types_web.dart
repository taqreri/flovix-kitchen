import 'dart:typed_data';

/// Minimal web stubs for dart:io types used in shared UI code.
class File {
  File(this.path);

  final String path;

  Future<int> length() async => 0;

  Future<bool> exists() async => false;

  bool existsSync() => false;

  Future<File> writeAsBytes(
    List<int> bytes, {
    bool flush = false,
  }) async =>
      this;

  Future<Uint8List> readAsBytes() async => Uint8List(0);
}

class SocketException implements Exception {
  SocketException([this.message]);

  final String? message;

  @override
  String toString() => 'SocketException: ${message ?? ''}';
}
