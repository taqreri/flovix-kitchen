import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_init_io.dart';


/// Local SQLite database for POS offline data: categories and products.
/// Load from here until user presses Sync; Sync fetches from API and writes here.
class PosOfflineDatabase {
  PosOfflineDatabase._();
  static final PosOfflineDatabase _instance = PosOfflineDatabase._();
  static PosOfflineDatabase get instance => _instance;

  static const String _tableCategories = 'pos_categories';
  static const String _tableProducts = 'pos_products';

  // Generic key-value API cache table (legacy / fallback).
  static const String _tableApiCache = 'pos_offline_api_cache';

  // Dedicated tables for specific API resources.
  static const String _tableDialCodes = 'pos_dial_codes';
  static const String _tableCounterDiscounts = 'pos_counter_discounts';
  static const String _tableOrderTags = 'pos_order_tags';
  static const String _tablePaymentMethods = 'pos_payment_methods';
  static const String _tableOrderTypes = 'pos_order_types';
  static const String _tableFloorTables = 'pos_floor_tables';
  static const String _tableShippingMethods = 'pos_shipping_methods';
  static const String _tableDeliveryMen = 'pos_delivery_men';
  static const String _tableSaleRepresentatives = 'pos_sale_representatives';
  static const String _tableFloors = 'pos_floors';
  static const String _tableLocalTransactions = 'pos_local_transactions';
  static const String _tableLocalTransactionReturns = 'pos_local_transaction_returns';

  static const String _colId = 'id';
  static const String _colData = 'data';
  static const String _colUpdatedAt = 'updated_at';
  static const String _colCategoryId = 'category_id';
  static const String _colPage = 'page';
  static const String _colKey = 'key';
  static const String _colInvId = 'inv_id';
  static const String _colInvNumber = 'inv_number';
  static const String _colMainInvNumber = 'main_inv_number';
  static const String _colSynced = 'synced';
  static const String _colIsSync = 'is_sync';
  static const String _colSyncedInvId = 'synced_inv_id';

  Database? _db;
  // Bump version whenever schema changes.
  static const int _version = 8;

  Future<Database> _getDb() async {
    if (_db != null && (_db?.isOpen ?? false)) return _db!;
    final path = await getAppDatabasePath('taqreri_pos_offline.db');
    _db = await openDatabase(
      path,
      version: _version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableCategories (
        $_colId INTEGER PRIMARY KEY DEFAULT 1,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableProducts (
        $_colCategoryId TEXT NOT NULL,
        $_colPage INTEGER NOT NULL,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL,
        PRIMARY KEY ($_colCategoryId, $_colPage)
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableApiCache (
        $_colKey TEXT PRIMARY KEY,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');

    // Dedicated tables (each stores a single JSON blob row with id=1).
    await db.execute('''
      CREATE TABLE $_tableDialCodes (
        $_colId INTEGER PRIMARY KEY DEFAULT 1,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableCounterDiscounts (
        $_colId INTEGER PRIMARY KEY DEFAULT 1,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableOrderTags (
        $_colId INTEGER PRIMARY KEY DEFAULT 1,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tablePaymentMethods (
        $_colId INTEGER PRIMARY KEY DEFAULT 1,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableOrderTypes (
        $_colId INTEGER PRIMARY KEY DEFAULT 1,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableFloorTables (
        $_colCategoryId TEXT PRIMARY KEY,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableShippingMethods (
        $_colId INTEGER PRIMARY KEY DEFAULT 1,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableDeliveryMen (
        $_colId INTEGER PRIMARY KEY DEFAULT 1,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableSaleRepresentatives (
        $_colId INTEGER PRIMARY KEY DEFAULT 1,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableFloors (
        $_colId INTEGER PRIMARY KEY DEFAULT 1,
        $_colData TEXT NOT NULL,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableLocalTransactions (
        $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_colInvId INTEGER NOT NULL,
        $_colInvNumber TEXT,
        $_colMainInvNumber TEXT,
        $_colData TEXT NOT NULL,
        $_colSynced INTEGER NOT NULL DEFAULT 1,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tableLocalTransactionReturns (
        $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_colInvId INTEGER NOT NULL UNIQUE,
         $_colInvNumber TEXT,
        $_colMainInvNumber TEXT,
        $_colData TEXT NOT NULL,
        $_colIsSync INTEGER NOT NULL DEFAULT 0,
        $_colSyncedInvId INTEGER,
        $_colUpdatedAt INTEGER NOT NULL
      )
    ''');
  }

  // Handles upgrades when adding new tables/columns.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableApiCache (
          $_colKey TEXT PRIMARY KEY,
          $_colData TEXT NOT NULL,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
    }

    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableDialCodes (
          $_colId INTEGER PRIMARY KEY DEFAULT 1,
          $_colData TEXT NOT NULL,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableCounterDiscounts (
          $_colId INTEGER PRIMARY KEY DEFAULT 1,
          $_colData TEXT NOT NULL,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableOrderTags (
          $_colId INTEGER PRIMARY KEY DEFAULT 1,
          $_colData TEXT NOT NULL,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tablePaymentMethods (
          $_colId INTEGER PRIMARY KEY DEFAULT 1,
          $_colData TEXT NOT NULL,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableOrderTypes (
          $_colId INTEGER PRIMARY KEY DEFAULT 1,
          $_colData TEXT NOT NULL,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableFloorTables (
          $_colCategoryId TEXT PRIMARY KEY,
          $_colData TEXT NOT NULL,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableShippingMethods (
          $_colId INTEGER PRIMARY KEY DEFAULT 1,
          $_colData TEXT NOT NULL,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableDeliveryMen (
          $_colId INTEGER PRIMARY KEY DEFAULT 1,
          $_colData TEXT NOT NULL,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
    }

    if (oldVersion < 4) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableSaleRepresentatives (
          $_colId INTEGER PRIMARY KEY DEFAULT 1,
          $_colData TEXT NOT NULL,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
    }

    if (oldVersion < 5) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableFloors (
          $_colId INTEGER PRIMARY KEY DEFAULT 1,
          $_colData TEXT NOT NULL,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
    }

    if (oldVersion < 6) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableLocalTransactions (
          $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_colInvId INTEGER NOT NULL,
          $_colInvNumber TEXT,
          $_colData TEXT NOT NULL,
          $_colSynced INTEGER NOT NULL DEFAULT 1,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
    }
    if (oldVersion < 7) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableLocalTransactionReturns (
          $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_colInvId INTEGER NOT NULL UNIQUE,
          $_colData TEXT NOT NULL,
          $_colIsSync INTEGER NOT NULL DEFAULT 0,
          $_colSyncedInvId INTEGER,
          $_colUpdatedAt INTEGER NOT NULL
        )
      ''');
    }
    if (oldVersion < 8) {
      try {
        await db.execute(
          'ALTER TABLE $_tableLocalTransactionReturns ADD COLUMN $_colIsSync INTEGER NOT NULL DEFAULT 0',
        );
      } catch (_) {}
      try {
        await db.execute(
          'ALTER TABLE $_tableLocalTransactionReturns ADD COLUMN $_colSyncedInvId INTEGER',
        );
      } catch (_) {}
    }
  }

  /// Save category payload (full API data map as JSON string).
  Future<void> saveCategoriesData(String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableCategories,
      <String, dynamic>{
        _colId: 1,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get saved category data; null if none.
  Future<String?> getCategoriesData() async {
    final db = await _getDb();
    final rows = await db.query(
      _tableCategories,
      columns: [_colData],
      where: '$_colId = ?',
      whereArgs: [1],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  /// Save products for a category (page, usually 1).
  Future<void> saveProductsForCategory(String categoryId, int page, String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableProducts,
      <String, dynamic>{
        _colCategoryId: categoryId,
        _colPage: page,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get saved products for a category and page; null if none.
  Future<String?> getProductsForCategory(String categoryId, int page) async {
    final db = await _getDb();
    final rows = await db.query(
      _tableProducts,
      columns: [_colData],
      where: '$_colCategoryId = ? AND $_colPage = ?',
      whereArgs: [categoryId, page],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  /// Get all saved product data for a category (all pages), ordered by page.
  /// Returns list of JSON array strings, one per page.
  Future<List<String>> getAllProductDataPagesForCategory(String categoryId) async {
    final db = await _getDb();
    final rows = await db.query(
      _tableProducts,
      columns: [_colData],
      where: '$_colCategoryId = ?',
      whereArgs: [categoryId],
      orderBy: '$_colPage ASC',
    );
    return rows.map((r) => r[_colData] as String).toList();
  }

  /// Returns cached product pages with their page numbers.
  Future<List<Map<String, dynamic>>> getProductPagesForCategory(
      String categoryId) async {
    final db = await _getDb();
    final rows = await db.query(
      _tableProducts,
      columns: [_colPage, _colData],
      where: '$_colCategoryId = ?',
      whereArgs: [categoryId],
      orderBy: '$_colPage ASC',
    );
    return rows
        .map(
          (row) => <String, dynamic>{
            'page': row[_colPage] as int,
            'data': row[_colData] as String,
          },
        )
        .toList();
  }

  /// Whether any category data exists.
  Future<bool> hasCachedCategories() async {
    final raw = await getCategoriesData();
    return raw != null && raw.isNotEmpty;
  }

  // Dedicated table helpers for specific API payloads

  Future<void> saveDialCodesData(String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableDialCodes,
      <String, dynamic>{
        _colId: 1,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getDialCodesData() async {
    final db = await _getDb();
    final rows = await db.query(
      _tableDialCodes,
      columns: [_colData],
      where: '$_colId = ?',
      whereArgs: [1],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  Future<void> saveCounterDiscountListData(String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableCounterDiscounts,
      <String, dynamic>{
        _colId: 1,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getCounterDiscountListData() async {
    final db = await _getDb();
    final rows = await db.query(
      _tableCounterDiscounts,
      columns: [_colData],
      where: '$_colId = ?',
      whereArgs: [1],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  Future<void> saveOrderTagsData(String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableOrderTags,
      <String, dynamic>{
        _colId: 1,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getOrderTagsData() async {
    final db = await _getDb();
    final rows = await db.query(
      _tableOrderTags,
      columns: [_colData],
      where: '$_colId = ?',
      whereArgs: [1],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  Future<void> savePaymentMethodsData(String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tablePaymentMethods,
      <String, dynamic>{
        _colId: 1,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getPaymentMethodsData() async {
    final db = await _getDb();
    final rows = await db.query(
      _tablePaymentMethods,
      columns: [_colData],
      where: '$_colId = ?',
      whereArgs: [1],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  Future<void> saveShippingMethodsData(String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableShippingMethods,
      <String, dynamic>{
        _colId: 1,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getShippingMethodsData() async {
    final db = await _getDb();
    final rows = await db.query(
      _tableShippingMethods,
      columns: [_colData],
      where: '$_colId = ?',
      whereArgs: [1],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  Future<void> saveDeliveryMenData(String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableDeliveryMen,
      <String, dynamic>{
        _colId: 1,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getDeliveryMenData() async {
    final db = await _getDb();
    final rows = await db.query(
      _tableDeliveryMen,
      columns: [_colData],
      where: '$_colId = ?',
      whereArgs: [1],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  Future<void> saveSaleRepresentativesData(String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableSaleRepresentatives,
      <String, dynamic>{
        _colId: 1,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getSaleRepresentativesData() async {
    final db = await _getDb();
    final rows = await db.query(
      _tableSaleRepresentatives,
      columns: [_colData],
      where: '$_colId = ?',
      whereArgs: [1],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  Future<void> saveFloorsData(String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableFloors,
      <String, dynamic>{
        _colId: 1,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getFloorsData() async {
    final db = await _getDb();
    final rows = await db.query(
      _tableFloors,
      columns: [_colData],
      where: '$_colId = ?',
      whereArgs: [1],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  // Floor tables per floorId (stored in _colCategoryId)
  Future<void> saveFloorTablesData(String floorId, String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableFloorTables,
      <String, dynamic>{
        _colCategoryId: floorId,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getFloorTablesData(String floorId) async {
    final db = await _getDb();
    final rows = await db.query(
      _tableFloorTables,
      columns: [_colData],
      where: '$_colCategoryId = ?',
      whereArgs: [floorId],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  Future<void> saveOrderTypesData(String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableOrderTypes,
      <String, dynamic>{
        _colId: 1,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getOrderTypesData() async {
    final db = await _getDb();
    final rows = await db.query(
      _tableOrderTypes,
      columns: [_colData],
      where: '$_colId = ?',
      whereArgs: [1],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  /// Save arbitrary API response JSON by key (e.g. 'dial_codes', 'counter_discount_list').
  Future<void> saveApiCache(String key, String dataJson) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableApiCache,
      <String, dynamic>{
        _colKey: key,
        _colData: dataJson,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get cached API response JSON by key; null if missing.
  Future<String?> getApiCache(String key) async {
    final db = await _getDb();
    final rows = await db.query(
      _tableApiCache,
      columns: [_colData],
      where: '$_colKey = ?',
      whereArgs: [key],
    );
    if (rows.isEmpty) return null;
    return rows.first[_colData] as String?;
  }

  /// Save a local transaction (created from createInvoiceB or offline).
  /// [dataJson] should be a JSON string that can be parsed to TransactionModelNew.
  Future<void> saveLocalTransaction({
    required int invId,
    required String? invNumber,
    required String dataJson,
    int synced = 1,
  }) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableLocalTransactions,
      <String, dynamic>{
        _colInvId: invId,
        _colInvNumber: invNumber ?? '',
        _colMainInvNumber:invNumber,
        //_colMainInvNumber: mainInvId,
        _colData: dataJson,
        _colSynced: synced,
        _colUpdatedAt: now,
      },
    );
  }

  /// Upsert a local transaction by [invId] to avoid duplicate rows while editing.
  Future<void> upsertLocalTransaction({
    required int invId,
    required String? invNumber,
    required String dataJson,
    int synced = 1,
  }) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    final updated = await db.update(
      _tableLocalTransactions,
      <String, dynamic>{
        _colInvNumber: invNumber ?? '',
        _colData: dataJson,
        _colSynced: synced,
        _colUpdatedAt: now,
      },
      where: '$_colInvId = ?',
      whereArgs: [invId],
    );
    if (updated == 0) {
      await db.insert(
        _tableLocalTransactions,
        <String, dynamic>{
          _colInvId: invId,
       //   _colInvNumber: invNumber ?? '',
          _colInvNumber: invNumber ?? '',
          _colMainInvNumber: invNumber,
          _colData: dataJson,
          _colSynced: synced,
          _colUpdatedAt: now,
        },
      );
    }
  }

  /// Returns all local transactions as list of maps: { data: parsed JSON map, synced: 0|1 }.
  Future<List<Map<String, dynamic>>> getAllLocalTransactions() async {

    final db = await _getDb();
    final rows = await db.query(
      _tableLocalTransactions,
      columns: [_colId, _colInvId, _colInvNumber, _colData, _colSynced, _colUpdatedAt],
      orderBy: '$_colUpdatedAt DESC',
    );
    final returnRows = await db.query(
      _tableLocalTransactionReturns,
      columns: [_colInvId, _colData, _colIsSync, _colSyncedInvId],
    );
    final returnPayloadByInvId = <int, Map<String, dynamic>>{};
    for (final r in returnRows) {
      final rawInvId = r[_colInvId];
      final invId = rawInvId is int ? rawInvId : int.tryParse(rawInvId.toString());
      if (invId == null) continue;
      final dataStr = r[_colData] as String?;
      if (dataStr == null || dataStr.isEmpty) continue;
      try {
        returnPayloadByInvId[invId] = <String, dynamic>{
          'payload': jsonDecode(dataStr) as Map<String, dynamic>,
          _colIsSync: r[_colIsSync] ?? 0,
          _colSyncedInvId: r[_colSyncedInvId],
        };
      } catch (_) {}
    }

    return rows.map((row) {
      final dataStr = row[_colData] as String?;
      Map<String, dynamic> data = {};
      if (dataStr != null && dataStr.isNotEmpty) {
        try {
          data = jsonDecode(dataStr) as Map<String, dynamic>? ?? {};
        } catch (_) {}
      }
      data['inv_id'] = row[_colInvId];
      data['inv_number'] = row[_colInvNumber];
      final rowInvId = row[_colInvId];
      final invId = rowInvId is int ? rowInvId : int.tryParse(rowInvId.toString());
      final returnPayloadMeta = invId != null ? returnPayloadByInvId[invId] : null;
      final returnPayload = returnPayloadMeta?['payload'];
      final isStandaloneReturn = data['is_return_transaction'] == 1 ||
          data['is_return_transaction'] == true ||
          data['parent_inv_id'] != null;
      final isLegacyParentReturn = returnPayload != null &&
          !isStandaloneReturn &&
          (data['is_return'] == 1 || data['is_return'] == '1');
      if (returnPayload != null && (isStandaloneReturn || isLegacyParentReturn)) {
        data['return_invoice_payload'] = returnPayload;
        data['is_return'] = 1;
        data['return_is_sync'] = returnPayloadMeta?[_colIsSync] ?? 0;
        data['return_synced_inv_id'] = returnPayloadMeta?[_colSyncedInvId];
      }
      // Backward compatibility: older locally saved transactions may not
      // contain `is_return` in their JSON payload.
      data['is_return'] = data['is_return'] ?? 0;
      data['_local_synced'] = (row[_colSynced] as int?) == 1;
      data['_local_updated_at'] = row[_colUpdatedAt];
      return data;
    }).toList();
  }

  /// Returns one local transaction by [invId], merged with return payload if present.
  Future<Map<String, dynamic>?> getLocalTransactionByInvId(int invId) async {
    final db = await _getDb();
    final rows = await db.query(
      _tableLocalTransactions,
      columns: [_colId, _colInvId, _colInvNumber, _colData, _colSynced, _colUpdatedAt],
      where: '$_colInvId = ?',
      whereArgs: [invId],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final row = rows.first;
    final dataStr = row[_colData] as String?;
    Map<String, dynamic> data = {};
    if (dataStr != null && dataStr.isNotEmpty) {
      try {
        data = jsonDecode(dataStr) as Map<String, dynamic>? ?? {};
      } catch (_) {}
    }
    data['inv_id'] = row[_colInvId];
    data['inv_number'] = row[_colInvNumber];
    data['_local_synced'] = (row[_colSynced] as int?) == 1;
    data['_local_updated_at'] = row[_colUpdatedAt];
    final returnPayload = await getLocalReturnPayloadByInvId(invId);
    final isStandaloneReturn = data['is_return_transaction'] == 1 ||
        data['is_return_transaction'] == true ||
        data['parent_inv_id'] != null;
    if (returnPayload != null && isStandaloneReturn) {
      data['return_invoice_payload'] = returnPayload;
      data['is_return'] = 1;
      final returnRecord = await getLocalReturnPayloadRecordByInvId(invId);
      data['return_is_sync'] = returnRecord?[_colIsSync] ?? 0;
      data['return_synced_inv_id'] = returnRecord?[_colSyncedInvId];
    } else if (returnPayload != null &&
        (data['is_return'] == 1 || data['is_return'] == '1')) {
      data['return_invoice_payload'] = returnPayload;
      data['is_return'] = 1;
      final returnRecord = await getLocalReturnPayloadRecordByInvId(invId);
      data['return_is_sync'] = returnRecord?[_colIsSync] ?? 0;
      data['return_synced_inv_id'] = returnRecord?[_colSyncedInvId];
    } else {
      data['is_return'] = data['is_return'] ?? 0;
    }
    return data;
  }

  /// Upserts return payload linked to a local transaction [invId].
  Future<void> upsertLocalReturnPayload({
    required int invId,
    String? mainInvId,
    required String dataJson,
    int isSync = 0,
    int? syncedInvId,
  }) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableLocalTransactionReturns,
      <String, dynamic>{
        _colInvId: invId,
        _colData: dataJson,
        _colIsSync: isSync,
        _colInvNumber: mainInvId ?? '',

        _colMainInvNumber: mainInvId ?? '',
        _colSyncedInvId: syncedInvId,
        _colUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getLocalReturnPayloadByInvId(int invId) async {
    final db = await _getDb();
    final rows = await db.query(
      _tableLocalTransactionReturns,
      columns: [_colData],
      where: '$_colInvId = ?',
      whereArgs: [invId],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final dataStr = rows.first[_colData] as String?;
    if (dataStr == null || dataStr.isEmpty) return null;
    try {
      return jsonDecode(dataStr) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getLocalReturnPayloadRecordByInvId(int invId) async {
    final db = await _getDb();
    final rows = await db.query(
      _tableLocalTransactionReturns,
      columns: [_colInvId, _colData, _colIsSync, _colSyncedInvId, _colUpdatedAt],
      where: '$_colInvId = ?',
      whereArgs: [invId],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return Map<String, dynamic>.from(rows.first);
  }

  /// Return transaction rows linked to [parentInvId].
  Future<List<Map<String, dynamic>>> getReturnTransactionsByParentInvId(
    int parentInvId,
  ) async {
    final all = await getAllLocalTransactions();
    return all.where((row) {
      final rawParent = row['parent_inv_id'];
      final parsedParent =
          rawParent is int ? rawParent : int.tryParse(rawParent?.toString() ?? '');
      if (parsedParent != parentInvId) return false;
      return row['is_return_transaction'] == 1 ||
          row['is_return'] == 1 ||
          row['is_return'] == '1';
    }).toList();
  }

  Future<void> deleteLocalReturnPayloadByInvId(int invId) async {
    final db = await _getDb();
    await db.delete(
      _tableLocalTransactionReturns,
      where: '$_colInvId = ?',
      whereArgs: [invId],
    );
  }

  Future<void> markLocalReturnSynced({
    required int invId,
    required int syncedInvId,
  }) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.update(
      _tableLocalTransactionReturns,
      <String, dynamic>{
        _colIsSync: 1,
        _colSyncedInvId: syncedInvId,
        _colUpdatedAt: now,
      },
      where: '$_colInvId = ?',
      whereArgs: [invId],
    );
  }

  Future<void> markLocalReturnCreateSynced({
    required String mainInvId,
    required int invId,
    required int syncedInvId,
  }) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.update(
      _tableLocalTransactionReturns,
      <String, dynamic>{
        _colIsSync: 0,
        _colSyncedInvId: syncedInvId,
        _colInvNumber: mainInvId,
        _colMainInvNumber: mainInvId,
        _colUpdatedAt: now,
      },
      where: '$_colInvId = ?',
      whereArgs: [invId],
    );
    final row = await db.query(
      _tableLocalTransactionReturns,
      columns: [_colData],
      where: '$_colInvId = ?',
      whereArgs: [invId],
      limit: 1,
    );
    if (row.isNotEmpty) {
      final updatedJson = _updateInvoiceNumbersInJson(
        row.first[_colData] as String?,
        mainInvId,
      );
      if (updatedJson != null) {
        await db.update(
          _tableLocalTransactionReturns,
          <String, dynamic>{_colData: updatedJson, _colUpdatedAt: now},
          where: '$_colInvId = ?',
          whereArgs: [invId],
        );
      }
    }
  }

  Future<void> updateLocalTransactionInvoiceNumbers({
    required int invId,
    required String serverInvNumber,
  }) async {
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.update(
      _tableLocalTransactions,
      <String, dynamic>{
        _colInvNumber: serverInvNumber,
        _colMainInvNumber: serverInvNumber,
        _colUpdatedAt: now,
      },
      where: '$_colInvId = ?',
      whereArgs: [invId],
    );
    final row = await db.query(
      _tableLocalTransactions,
      columns: [_colData],
      where: '$_colInvId = ?',
      whereArgs: [invId],
      limit: 1,
    );
    if (row.isNotEmpty) {
      final updatedJson = _updateInvoiceNumbersInJson(
        row.first[_colData] as String?,
        serverInvNumber,
      );
      if (updatedJson != null) {
        await db.update(
          _tableLocalTransactions,
          <String, dynamic>{_colData: updatedJson, _colUpdatedAt: now},
          where: '$_colInvId = ?',
          whereArgs: [invId],
        );
      }
    }
  }

  Future<void> updateLocalTransactionInvItemIds({
    required int invId,
    required Map<String, int> offlineToInvItemIdMap,
  }) async {
    if (offlineToInvItemIdMap.isEmpty) return;
    final db = await _getDb();
    final now = DateTime.now().millisecondsSinceEpoch;

    final localRows = await db.query(
      _tableLocalTransactions,
      columns: [_colData],
      where: '$_colInvId = ?',
      whereArgs: [invId],
      limit: 1,
    );
    if (localRows.isNotEmpty) {
      final updatedLocalJson = _updateInvItemIdsInJson(
        localRows.first[_colData] as String?,
        offlineToInvItemIdMap,
      );
      if (updatedLocalJson != null) {
        await db.update(
          _tableLocalTransactions,
          <String, dynamic>{_colData: updatedLocalJson, _colUpdatedAt: now},
          where: '$_colInvId = ?',
          whereArgs: [invId],
        );
      }
    }

    final returnRows = await db.query(
      _tableLocalTransactionReturns,
      columns: [_colData],
      where: '$_colInvId = ?',
      whereArgs: [invId],
      limit: 1,
    );
    if (returnRows.isNotEmpty) {
      final updatedReturnJson = _updateInvItemIdsInJson(
        returnRows.first[_colData] as String?,
        offlineToInvItemIdMap,
      );
      if (updatedReturnJson != null) {
        await db.update(
          _tableLocalTransactionReturns,
          <String, dynamic>{_colData: updatedReturnJson, _colUpdatedAt: now},
          where: '$_colInvId = ?',
          whereArgs: [invId],
        );
      }
    }
  }

  /// Mark a local transaction as synced by inv_id.
  Future<void> markLocalTransactionSynced(int invId) async {
    final db = await _getDb();
    await db.update(
      _tableLocalTransactions,
      <String, dynamic>{_colSynced: 1},
      where: '$_colInvId = ?',
      whereArgs: [invId],
    );
  }

  /// Delete a single local transaction by inv_id.
  Future<void> deleteLocalTransactionByInvId(int invId) async {
    final db = await _getDb();
    await db.delete(
      _tableLocalTransactions,
      where: '$_colInvId = ?',
      whereArgs: [invId],
    );
    await deleteLocalReturnPayloadByInvId(invId);
  }

  /// Deletes [invId] and any standalone sale_return rows linked to it.
  Future<void> deleteLocalTransactionAndLinkedReturns(int invId) async {
    final linkedReturns = await getReturnTransactionsByParentInvId(invId);
    for (final returnRow in linkedReturns) {
      final returnInvIdRaw = returnRow['inv_id'];
      final returnInvId = returnInvIdRaw is int
          ? returnInvIdRaw
          : int.tryParse(returnInvIdRaw?.toString() ?? '');
      if (returnInvId == null) continue;
      await deleteLocalTransactionByInvId(returnInvId);
    }
    await deleteLocalTransactionByInvId(invId);
  }

  /// Delete all local transactions only (offline list).
  Future<void> deleteAllLocalTransactions() async {
    final db = await _getDb();
    await db.delete(_tableLocalTransactions);
    await db.delete(_tableLocalTransactionReturns);
  }

  /// Delete all categories and products (e.g. on logout if needed).
  Future<void> clearAll() async {
    final db = await _getDb();
    await db.delete(_tableCategories);
    await db.delete(_tableProducts);
    await db.delete(_tableApiCache);
    await db.delete(_tableDialCodes);
    await db.delete(_tableCounterDiscounts);
    await db.delete(_tableOrderTags);
    await db.delete(_tablePaymentMethods);
    await db.delete(_tableLocalTransactions);
    await db.delete(_tableLocalTransactionReturns);

  }

  /// Delete only cached products table.
  Future<void> clearProductsOnly() async {
    final db = await _getDb();
    await db.delete(_tableProducts);
  }

  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }

  String? _updateInvoiceNumbersInJson(String? dataJson, String invoiceNumber) {
    if (dataJson == null || dataJson.isEmpty) return null;
    try {
      final decoded = jsonDecode(dataJson);
      if (decoded is! Map) return null;
      final map = Map<String, dynamic>.from(decoded as Map);
      map['inv_num'] = invoiceNumber;
      map['main_inv_number'] = invoiceNumber;
      map['inv_number'] = invoiceNumber;
      return jsonEncode(map);
    } catch (_) {
      return null;
    }
  }

  String? _updateInvItemIdsInJson(
    String? dataJson,
    Map<String, int> offlineToInvItemIdMap,
  ) {
    if (dataJson == null || dataJson.isEmpty || offlineToInvItemIdMap.isEmpty) {
      return null;
    }
    try {
      final decoded = jsonDecode(dataJson);
      if (decoded is! Map) return null;
      final map = Map<String, dynamic>.from(decoded as Map);
      bool changed = false;

      List<dynamic>? updateNode(Map<String, dynamic> node) {
        final rawOfflineList = node['offline_item_id'];
        if (rawOfflineList is! List || rawOfflineList.isEmpty) return null;
        final offlineIds = rawOfflineList.map((e) => e?.toString() ?? '').toList();
        final currentInvItemIds = (node['inv_item_id'] is List)
            ? List<dynamic>.from(node['inv_item_id'] as List)
            : List<dynamic>.filled(offlineIds.length, '');
        final currentProductIdNew = (node['product_id_new'] is List)
            ? List<dynamic>.from(node['product_id_new'] as List)
            : List<dynamic>.filled(offlineIds.length, '');
        if (currentInvItemIds.length < offlineIds.length) {
          currentInvItemIds.addAll(
            List<dynamic>.filled(offlineIds.length - currentInvItemIds.length, ''),
          );
        }
        if (currentProductIdNew.length < offlineIds.length) {
          currentProductIdNew.addAll(
            List<dynamic>.filled(offlineIds.length - currentProductIdNew.length, ''),
          );
        }
        bool localChange = false;
        for (var i = 0; i < offlineIds.length; i++) {
          final offlineId = offlineIds[i].trim();
          if (offlineId.isEmpty) continue;
          final invItemId = offlineToInvItemIdMap[offlineId];
          if (invItemId == null) continue;
          if (currentInvItemIds[i].toString() != invItemId.toString()) {
            currentInvItemIds[i] = invItemId;
            localChange = true;
          }
          if (currentProductIdNew[i].toString() != invItemId.toString()) {
            currentProductIdNew[i] = invItemId;
            localChange = true;
          }
        }

        print("currentInvItemIdscurrentInvItemIds ${currentInvItemIds} ${currentProductIdNew}");
        if (localChange) {
          node['inv_item_id'] = currentInvItemIds;
          node['inv_item_array'] = List<dynamic>.from(currentInvItemIds);
          node['product_id_new'] = currentProductIdNew;
          changed = true;
        }
        return currentInvItemIds;
      }

      // update top-level payload
      updateNode(map);

      // update nested create payload snapshot
      final actual = map['actual_invoice_payload'];
      if (actual is Map) {
        final actualMap = Map<String, dynamic>.from(actual);
        updateNode(actualMap);
        map['actual_invoice_payload'] = actualMap;
        // Mirror mapped IDs to top-level payload so callers reading local row data
        // can access them directly (not only under actual_invoice_payload).
        if (actualMap['inv_item_id'] is List &&
            (actualMap['inv_item_id'] as List).isNotEmpty) {
          map['inv_item_id'] = List<dynamic>.from(actualMap['inv_item_id'] as List);
          changed = true;
        }
        if (actualMap['product_id_new'] is List &&
            (actualMap['product_id_new'] as List).isNotEmpty) {
          map['product_id_new'] =
              List<dynamic>.from(actualMap['product_id_new'] as List);
          changed = true;
        }
        if (map['offline_item_id'] is! List &&
            actualMap['offline_item_id'] is List) {
          map['offline_item_id'] =
              List<dynamic>.from(actualMap['offline_item_id'] as List);
          changed = true;
        }
      }

      // update nested return payload snapshot
      final ret = map['return_invoice_payload'];
      if (ret is Map) {
        final returnMap = Map<String, dynamic>.from(ret);
        updateNode(returnMap);
        map['return_invoice_payload'] = returnMap;
      }

      if (!changed) return null;
      return jsonEncode(map);
    } catch (_) {
      return null;
    }
  }
}
