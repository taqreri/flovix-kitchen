import 'dart:convert';

import 'package:flovix_kitchen/services/database/web_local_store.dart';

/// Web session cache for POS reference data (online-first; no SQLite).
class PosOfflineDatabase {
  PosOfflineDatabase._();
  static final PosOfflineDatabase _instance = PosOfflineDatabase._();
  static PosOfflineDatabase get instance => _instance;

  final WebLocalStore _store = WebLocalStore.instance;

  Future<void> _saveBlob(String key, String dataJson) async {
    await _store.writeString(key, dataJson);
  }

  Future<String?> _readBlob(String key) => _store.readString(key);

  Future<void> saveCategoriesData(String dataJson) async =>
      _saveBlob('pos_categories', dataJson);

  Future<String?> getCategoriesData() => _readBlob('pos_categories');

  Future<bool> hasCachedCategories() async {
    final raw = await getCategoriesData();
    return raw != null && raw.isNotEmpty;
  }

  Future<void> saveProductsForCategory(
    String categoryId,
    int page,
    String dataJson,
  ) async {
    await _saveBlob('pos_products_${categoryId}_$page', dataJson);
  }

  Future<String?> getProductsForCategory(String categoryId, int page) =>
      _readBlob('pos_products_${categoryId}_$page');

  Future<List<String>> getAllProductDataPagesForCategory(
    String categoryId,
  ) async {
    final prefix = 'pos_products_${categoryId}_';
    final pages = <int>[];
    for (final key in await _store.allKeys()) {
      if (!key.startsWith(prefix)) continue;
      final page = int.tryParse(key.substring(prefix.length));
      if (page != null) pages.add(page);
    }
    pages.sort();
    final out = <String>[];
    for (final page in pages) {
      final raw = await getProductsForCategory(categoryId, page);
      if (raw != null && raw.isNotEmpty) out.add(raw);
    }
    return out;
  }

  Future<List<Map<String, dynamic>>> getProductPagesForCategory(
    String categoryId,
  ) async {
    final prefix = 'pos_products_${categoryId}_';
    final rows = <Map<String, dynamic>>[];
    for (final key in await _store.allKeys()) {
      if (!key.startsWith(prefix)) continue;
      final raw = await _store.getString(key);
      if (raw == null || raw.isEmpty) continue;
      final page = int.tryParse(key.substring(prefix.length)) ?? 1;
      rows.add({'page': page, 'data': raw});
    }
    rows.sort((a, b) => (a['page'] as int).compareTo(b['page'] as int));
    return rows;
  }

  Future<void> saveDialCodesData(String dataJson) async =>
      _saveBlob('pos_dial_codes', dataJson);
  Future<String?> getDialCodesData() => _readBlob('pos_dial_codes');

  Future<void> saveCounterDiscountListData(String dataJson) async =>
      _saveBlob('pos_counter_discounts', dataJson);
  Future<String?> getCounterDiscountListData() =>
      _readBlob('pos_counter_discounts');

  Future<void> saveOrderTagsData(String dataJson) async =>
      _saveBlob('pos_order_tags', dataJson);
  Future<String?> getOrderTagsData() => _readBlob('pos_order_tags');

  Future<void> savePaymentMethodsData(String dataJson) async =>
      _saveBlob('pos_payment_methods', dataJson);
  Future<String?> getPaymentMethodsData() => _readBlob('pos_payment_methods');

  Future<void> saveShippingMethodsData(String dataJson) async =>
      _saveBlob('pos_shipping_methods', dataJson);
  Future<String?> getShippingMethodsData() => _readBlob('pos_shipping_methods');

  Future<void> saveDeliveryMenData(String dataJson) async =>
      _saveBlob('pos_delivery_men', dataJson);
  Future<String?> getDeliveryMenData() => _readBlob('pos_delivery_men');

  Future<void> saveSaleRepresentativesData(String dataJson) async =>
      _saveBlob('pos_sale_representatives', dataJson);
  Future<String?> getSaleRepresentativesData() =>
      _readBlob('pos_sale_representatives');

  Future<void> saveFloorsData(String dataJson) async =>
      _saveBlob('pos_floors', dataJson);
  Future<String?> getFloorsData() => _readBlob('pos_floors');

  Future<void> saveFloorTablesData(String floorId, String dataJson) async =>
      _saveBlob('pos_floor_tables_$floorId', dataJson);
  Future<String?> getFloorTablesData(String floorId) =>
      _readBlob('pos_floor_tables_$floorId');

  Future<void> saveOrderTypesData(String dataJson) async =>
      _saveBlob('pos_order_types', dataJson);
  Future<String?> getOrderTypesData() => _readBlob('pos_order_types');

  Future<void> saveApiCache(String key, String dataJson) async =>
      _saveBlob('pos_api_cache_$key', dataJson);
  Future<String?> getApiCache(String key) => _readBlob('pos_api_cache_$key');

  Future<void> clearAll() async {
    await _store.clearPrefix('pos_');
  }

  Future<void> clearProductsOnly() async {
    await _store.clearPrefix('pos_products_');
  }

  Future<void> close() async {}

  // Online web POS does not queue offline invoice sync locally.
  Future<void> saveLocalTransaction({
    required int invId,
    required String? invNumber,
    required String dataJson,
    int synced = 1,
  }) async {}

  Future<void> upsertLocalTransaction({
    required int invId,
    required String? invNumber,
    required String dataJson,
    int synced = 1,
  }) async {}

  Future<List<Map<String, dynamic>>> getAllLocalTransactions() async => [];

  Future<Map<String, dynamic>?> getLocalTransactionByInvId(int invId) async =>
      null;

  Future<void> upsertLocalReturnPayload({
    required int invId,
    String? mainInvId,
    required String dataJson,
    int isSync = 0,
    int? syncedInvId,
  }) async {}

  Future<Map<String, dynamic>?> getLocalReturnPayloadByInvId(int invId) async =>
      null;

  Future<Map<String, dynamic>?> getLocalReturnPayloadRecordByInvId(
    int invId,
  ) async =>
      null;

  Future<List<Map<String, dynamic>>> getReturnTransactionsByParentInvId(
    int parentInvId,
  ) async =>
      [];

  Future<void> deleteLocalReturnPayloadByInvId(int invId) async {}

  Future<void> markLocalReturnSynced({
    required int invId,
    required int syncedInvId,
  }) async {}

  Future<void> markLocalReturnCreateSynced({
    required String mainInvId,
    required int invId,
    required int syncedInvId,
  }) async {}

  Future<void> updateLocalTransactionInvoiceNumbers({
    required int invId,
    required String serverInvNumber,
  }) async {}

  Future<void> updateLocalTransactionInvItemIds({
    required int invId,
    required Map<String, int> offlineToInvItemIdMap,
  }) async {}

  Future<void> markLocalTransactionSynced(int invId) async {}

  Future<void> deleteLocalTransactionByInvId(int invId) async {}

  Future<void> deleteLocalTransactionAndLinkedReturns(int invId) async {}

  Future<void> deleteAllLocalTransactions() async {}
}
