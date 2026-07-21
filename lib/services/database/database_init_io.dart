import 'dart:ffi';
import 'dart:io';

import 'package:flovix_kitchen/utils/platform/platform_info.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sqflite_mobile;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite3/open.dart' as sqlite_open;


/// Initializes SQLite for desktop (Windows/macOS/Linux).
Future<void> initializeAppDatabase() async {
  if (kIsWeb || !PlatformInfo.isDesktop) return;

  if (Platform.isWindows) {
    await _ensureWindowsSqlite3Dll();
  }

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

/// Returns a writable database file path.
///
/// On desktop (including MSIX Store installs), [getDatabasesPath] may resolve
/// under the read-only install folder. Use app support storage instead.
Future<String> getAppDatabasePath(String databaseName) async {
  if (kIsWeb) {
    return p.join('databases', databaseName);
  }

  if (PlatformInfo.isDesktop) {
    final appDir = await getApplicationSupportDirectory();
    final dbDir = Directory(p.join(appDir.path, 'databases'));
    if (!await dbDir.exists()) {
      await dbDir.create(recursive: true);
    }

    final dbPath = p.join(dbDir.path, databaseName);
    if (!await File(dbPath).exists()) {
      await _migrateLegacyDesktopDatabase(databaseName, dbPath);
    }
    return dbPath;
  }

  return p.join(await sqflite_mobile.getDatabasesPath(), databaseName);
}

/// Copies or registers [sqlite3.dll] for Windows desktop / MSIX builds.
Future<void> _ensureWindowsSqlite3Dll() async {
  final exeDir = p.dirname(Platform.resolvedExecutable);
  final targetDll = p.join(exeDir, 'sqlite3.dll');
  if (await File(targetDll).exists()) {
    return;
  }

  final projectRoot = _findProjectRoot(exeDir);
  final candidates = <String>[
    p.join(exeDir, 'sqlite3.dll'),
    p.join(
      exeDir,
      'data',
      'flutter_assets',
      'native_assets',
      'windows',
      'sqlite3.dll',
    ),
    if (projectRoot != null)
      p.join(projectRoot, 'build', 'native_assets', 'windows', 'sqlite3.dll'),
    p.normalize(
      p.join(
        exeDir,
        '..',
        '..',
        '..',
        '..',
        'native_assets',
        'windows',
        'sqlite3.dll',
      ),
    ),
    p.join(Directory.current.path, 'build', 'native_assets', 'windows', 'sqlite3.dll'),
  ];

  for (final source in candidates) {
    final file = File(source);
    if (!await file.exists()) continue;

    try {
      await file.copy(targetDll);
      return;
    } catch (_) {
      // MSIX install directory is read-only; load sqlite3.dll from package path.
      _configureWindowsSqlite3Library(file.path);
      return;
    }
  }
}

void _configureWindowsSqlite3Library(String dllPath) {
  sqlite_open.open.overrideFor(sqlite_open.OperatingSystem.windows, () {
    return DynamicLibrary.open(dllPath);
  });
}

Future<void> _migrateLegacyDesktopDatabase(
  String databaseName,
  String newPath,
) async {
  try {
    final legacyDir = await getDatabasesPath();
    final legacyPath = p.join(legacyDir, databaseName);
    final legacyFile = File(legacyPath);
    if (await legacyFile.exists()) {
      await legacyFile.copy(newPath);
    }
  } catch (_) {
    // Legacy path may be unavailable in MSIX; start with a fresh database.
  }
}

String? _findProjectRoot(String startDir) {
  var dir = Directory(startDir);
  for (var i = 0; i < 8; i++) {
    final pubspec = File(p.join(dir.path, 'pubspec.yaml'));
    if (pubspec.existsSync()) {
      return dir.path;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }
  return null;
}
