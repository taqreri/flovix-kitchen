import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

const _probeDbName = '_flovix_web_sqlite_probe.db';

/// Initializes SQLite on web (WASM + IndexedDB persistence).
Future<void> initializeAppDatabase() async {
  databaseFactory = databaseFactoryFfiWeb;

  if (!kDebugMode) return;

  try {
    final db = await databaseFactory.openDatabase(
      _probeDbName,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE IF NOT EXISTS probe(id INTEGER PRIMARY KEY)',
          );
        },
      ),
    );
    final version = await db.rawQuery('select sqlite_version()');
    await db.close();
    debugPrint(
      '[DB] Web SQLite ready (sqlite ${version.first.values.first})',
    );
  } catch (e, stackTrace) {
    debugPrint('[DB] Web SQLite init failed: $e');
    debugPrint('$stackTrace');
    debugPrint(
      '[DB] Ensure web/sqlite3.wasm and web/sqflite_sw.js exist. '
      'Run: dart run sqflite_common_ffi_web:setup',
    );
  }
}

/// Web SQLite uses a logical database name, not a filesystem path.
Future<String> getAppDatabasePath(String databaseName) async => databaseName;
