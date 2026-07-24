import 'dart:convert';

import 'package:flovix_kitchen/services/database/database_init.dart';
import 'package:flovix_kitchen/services/kitchen/kitchen_order_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

/// Local persistence for kitchen display tickets (SQLite).
class KitchenOrderDatabase {
  KitchenOrderDatabase._();

  static final KitchenOrderDatabase instance = KitchenOrderDatabase._();

  static const _dbName = 'flovix_kitchen_orders.db';
  static const _table = 'kitchen_orders';
  static const _colId = 'id';
  static const _colReceivedAt = 'received_at';
  static const _colStatus = 'status';
  static const _colInvoiceNumber = 'invoice_number';
  static const _colPayloadJson = 'payload_json';

  Database? _db;

  Future<Database> get database async {
    final existing = _db;
    if (existing != null && existing.isOpen) return existing;
    _db = await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final path = await getAppDatabasePath(_dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE IF NOT EXISTS $_table (
  $_colId TEXT PRIMARY KEY NOT NULL,
  $_colReceivedAt TEXT NOT NULL,
  $_colStatus TEXT NOT NULL,
  $_colInvoiceNumber TEXT,
  $_colPayloadJson TEXT NOT NULL
)
''');
        await db.execute(
          'CREATE INDEX IF NOT EXISTS idx_kitchen_orders_received '
          'ON $_table ($_colReceivedAt DESC)',
        );
      },
    );
  }

  /// Newest first.
  Future<List<KitchenOrderTicket>> loadAll() async {
    try {
      final db = await database;
      final rows = await db.query(
        _table,
        orderBy: '$_colReceivedAt DESC',
      );
      return rows
          .map((row) {
            final raw = row[_colPayloadJson]?.toString() ?? '';
            if (raw.isEmpty) return null;
            final decoded = jsonDecode(raw);
            if (decoded is! Map) return null;
            final ticket = KitchenOrderTicket.fromJson(
              Map<String, dynamic>.from(decoded),
            );
            // Column status is source of truth if payload is stale.
            final status = row[_colStatus]?.toString();
            if (status != null && status.isNotEmpty) {
              ticket.status = status;
            }
            return ticket;
          })
          .whereType<KitchenOrderTicket>()
          .where((t) => t.id.isNotEmpty)
          .toList();
    } catch (e, st) {
      debugPrint('[KitchenOrderDatabase] loadAll failed: $e');
      debugPrint('$st');
      return const [];
    }
  }

  Future<void> upsert(KitchenOrderTicket ticket) async {
    try {
      final db = await database;
      await db.insert(
        _table,
        {
          _colId: ticket.id,
          _colReceivedAt: ticket.receivedAt.toIso8601String(),
          _colStatus: ticket.status,
          _colInvoiceNumber: ticket.invoiceNumber,
          _colPayloadJson: jsonEncode(ticket.toJson()),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e, st) {
      debugPrint('[KitchenOrderDatabase] upsert failed: $e');
      debugPrint('$st');
      rethrow;
    }
  }

  Future<void> updateStatus(String id, String status) async {
    try {
      final db = await database;
      final rows = await db.query(
        _table,
        columns: [_colPayloadJson],
        where: '$_colId = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (rows.isEmpty) return;

      final raw = rows.first[_colPayloadJson]?.toString() ?? '';
      if (raw.isEmpty) return;
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return;
      final map = Map<String, dynamic>.from(decoded);
      map['status'] = status;

      await db.update(
        _table,
        {
          _colStatus: status,
          _colPayloadJson: jsonEncode(map),
        },
        where: '$_colId = ?',
        whereArgs: [id],
      );
    } catch (e, st) {
      debugPrint('[KitchenOrderDatabase] updateStatus failed: $e');
      debugPrint('$st');
    }
  }

  Future<void> deleteByIds(Iterable<String> ids) async {
    final list = ids.where((e) => e.isNotEmpty).toList();
    if (list.isEmpty) return;
    try {
      final db = await database;
      final placeholders = List.filled(list.length, '?').join(',');
      await db.delete(
        _table,
        where: '$_colId IN ($placeholders)',
        whereArgs: list,
      );
    } catch (e, st) {
      debugPrint('[KitchenOrderDatabase] deleteByIds failed: $e');
      debugPrint('$st');
    }
  }

  Future<void> delete(String id) async {
    if (id.isEmpty) return;
    await deleteByIds([id]);
  }
}
