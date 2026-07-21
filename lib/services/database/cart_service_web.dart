import 'dart:convert';

import 'package:flovix_kitchen/model/pos/cart/cart_items.dart';
import 'package:flovix_kitchen/model/pos/cart/cart_local_model/cart_local_model.dart' show CartLocalModel;
import 'package:flovix_kitchen/model/pos/cart/cart_local_model/exclusion_local_model.dart';
import 'package:flovix_kitchen/model/pos/cart/cart_local_model/menu_local_model/menu_item_local_model.dart';
import 'package:flovix_kitchen/model/pos/cart/cart_local_model/shipping_local_model.dart';
import 'package:flovix_kitchen/services/database/web_local_store.dart';




class CartService {
  static final CartService instance = CartService();

  static const columnProductID = "product_id";
  static const cartTableNew = "cart_table_new";
  static const dineInTableNew = "dine_in_table_new";
  static const menuTableNew = "menu_table_new";
  static const exclusionTableNew = "exclusion_table_new";
  static const columnImagePath = "image_url";
  static const columnIsExclusionItem = "is_exclusion_item";
  static const columnProductNameEnglish = "name_en";

  static const columnProductNameArabic = "name_ar";

  static const columnProductSalesDescription = "sales_description";
  static const columnTaxable = "taxable";
  static const columnPType = "p_type";
  static const columnInvoiceReg = "invoice_reg_num";
  static const columnTaxInclusive = "tax_inclusive";
  static const columnDefaultDiscount = "default_discount";
  static const columnCustomDefaultDiscount = "custom_default_discount";
  static const columnCustomDefaultDiscountPercentage =
      "custom_discount_percentage";
  static const columnSalePrice = "sale_price";
  static const columnUomValue = "uom_value";
  static const columnCostPrice = "cost_price";
  static const columnIsTobacco = "is_tobacco";
  static const columnProductMenuVariationId = "product_menu_variation_id";
  static const columnUnitMeasure = "unit_measure";
  static const columnStock = "stock";
  static const columnIsMenuItem = "is_menu_item";
  static const columnQuantity = "quantity";
  static const columnProductTags = "product_tags";
  static const columnIsRemove = "is_remove";
  static const columnIsReturn = "is_return";
  static const columnBarCode = "bar_code";
  static const columnIsTaxPercent = "is_tax_percent";
  static const columnTaxValue = "tax_value";
  static const columnProductIndex = "productIndex";
  static const columnProductNote = "product_note";
  static const columnCourseId = "course_id";

  static const columnParentProductId = "parentProductId";
  static const columnMenuVariationId = "menuVariationId";
  static const columnParentProductPType = "parentProductPType";
  static const columnParentProductName = "parentProductName";
  static const columnParentProductArabic = "parentProductArabic";
  static const columnParentProductImage = "parentProductImage";
  static const columnChildProductIndex = "childProductIndex";
  static const columnParentProductTaxable = "parentProductTaxable";
  static const columnParentProductTaxInclusive = "parentProductTaxInclusive";
  static const columnParentProductUnitMeasure = "parentProductUnitMeasure";
  static const columnProductVariationName = "productVariationName";
  static const columnProductItemId = "productItemId";
  static const columnProductVariationArabic = "productVariationArabic";
  static const columnProductNameEnglishMenu = "productNameEnglishMenu";
  static const columnProductNameArabicMenu = "productNameArabicMenu";
  static const columnProductImageMenu = "productImageMenu";
  static const columnProductUnitMeasure = "productUnitMeasure";
  static const columnProductSalePrice = "productSalePrice";
  static const columnProductCostPrice = "productCostPrice";
  static const columnProductBarCode = "productBarCode";
  static const columnProductDefaultDiscount = "productDefaultDiscount";
  static const columnProductQuantity = "productQuantity";
  static const columnProductCalculatedDiscount = "productCalculatedDiscount";
  static const columnProductCalculatedTax = "productCounterTax";
  static const columnProductCounterDiscount = "productCounterDiscount";
  static const columnProductStock = "productStock";
  static const columnProductIsPercentage = "productIsPercentage";
  static const columnProductIsTaxable = "productIsTaxable";
  static const columnProductIsTaxInclusive = "productIsTaxInclusive";
  static const columnProductPType = "productPType";
  static const columnIsSingleChoice = "isSingleChoice";
  static const columnIsMultiChoice = "isMultiChoice";
  static const columnChildProductSalesDescription = "productSalesDescription";
  static const columnIsNoPrint = "isNoPrint";
  static const columnVariationId = "variationId";
  static const columnMaxAllowQuantity = "maxAllowQuantity";

  static const columnExclusionParentProductId = "master_product_id";
  static const columnExclusionProductId = "product_menu_exclusion_id";
  static const columnExclusionName = "exclusion_name_en";
  static const columnExclusionNameAr = "exclusion_name_ar";
  static const columnExclusionIndex = "exclusion_index";
  static const columnExclusionSelected = "exclusion_selected";

  static const columnDineIn = "dine_in";
  static const columnFloorName = "floor_name";
  static const columnFloorId = "floor_id";
  static const columnTableId = "table_id";
  static const columnTableName = "table_name";
  static const columnTaxId = "tax_id";
  static const columnDinners = "dinners";
  static const columnSalePersonId = "sale_person_id";
  static const columnSalePersonShortName = "sale_person_name";
  static const columnShippingName = "shipping_name";
  static const columnDeliveryManName = "delivery_man_name";
  static const columnShippingId = "shipping_id";
  static const columnDeliveryManId = "delivery_man_id";
  static const columnEmployeeId = "employee_id";
  static const columnEmployeeName = "employee_name";
  static const columnUomListJson = "uom_list_json";

  static const columnPrinterSno = "printer_sno";
  static const columnPrinterName = "name";
  static const columnPrinterIsActive = "is_active";
  static const columnAvailablePrinter = "available_printer";
  static const columnPrinterType = "printer_type";
  static const columnPrinterProductId = "printer_product_id";
  static const columnPrinterVendorId = "vendor_id";
  static const columnPrinterIpAddress = "ip_address";
  static const columnPrinterPort = "printer_port";

  static const _cartItemsTable = 'cart_items';

  String _tableKey(String tableName) => 'web_cart_table_$tableName';

  int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString());
  }

  int? _rowId(Map<String, dynamic> row) => _asInt(row['id']);

  int _maxId(List<Map<String, dynamic>> rows) {
    var maxId = 0;
    for (final row in rows) {
      final id = _rowId(row);
      if (id != null && id > maxId) {
        maxId = id;
      }
    }
    return maxId;
  }

  Future<List<Map<String, dynamic>>> _loadTable(String tableName) async {
    final raw = await WebLocalStore.instance.readString(_tableKey(tableName));
    if (raw == null || raw.isEmpty) {
      return [];
    }
    final decoded = jsonDecode(raw);
    if (decoded is! List) {
      return [];
    }
    return decoded
        .whereType<Map>()
        .map((row) => Map<String, dynamic>.from(row))
        .toList();
  }

  Future<void> _saveTable(
    String tableName,
    List<Map<String, dynamic>> rows,
  ) async {
    await WebLocalStore.instance.writeString(
      _tableKey(tableName),
      jsonEncode(rows),
    );
  }

  Future<int> _upsertRow(Map<String, dynamic> row, String tableName) async {
    final rows = await _loadTable(tableName);
    final newRow = Map<String, dynamic>.from(row);
    if (newRow['id'] == null) {
      newRow['id'] = _maxId(rows) + 1;
    }
    final id = _rowId(newRow)!;
    final index = rows.indexWhere((existing) => _rowId(existing) == id);
    if (index >= 0) {
      rows[index] = newRow;
    } else {
      rows.add(newRow);
    }
    await _saveTable(tableName, rows);
    return id;
  }

  Future<bool> _deleteWhere(
    String tableName,
    bool Function(Map<String, dynamic> row) predicate,
  ) async {
    final rows = await _loadTable(tableName);
    final originalLength = rows.length;
    rows.removeWhere(predicate);
    if (rows.length == originalLength) {
      return false;
    }
    await _saveTable(tableName, rows);
    return true;
  }

  Future<void> _updateWhere(
    String tableName,
    bool Function(Map<String, dynamic> row) predicate,
    Map<String, dynamic> data,
  ) async {
    final rows = await _loadTable(tableName);
    var changed = false;
    for (var i = 0; i < rows.length; i++) {
      if (predicate(rows[i])) {
        rows[i] = {...rows[i], ...data};
        changed = true;
      }
    }
    if (changed) {
      await _saveTable(tableName, rows);
    }
  }

  Future<Null> updateProductQuantity({
    required int productId,
    required int quantity,
  }) async {
    await _updateWhere(
      cartTableNew,
      (row) => _asInt(row[columnProductID]) == productId,
      {columnQuantity: quantity},
    );
    return null;
  }

  Future<Null> updateCartItemByProductIndex({
    required int productIndex,
    required double salePrice,
  }) async {
    await _updateWhere(
      cartTableNew,
      (row) => _asInt(row[columnProductIndex]) == productIndex,
      {columnSalePrice: salePrice},
    );
    return null;
  }

  Future<Null> updateCartItemByProductIndexFull({
    required int productIndex,
    required Map<String, dynamic> data,
  }) async {
    await _updateWhere(
      cartTableNew,
      (row) => _asInt(row[columnProductIndex]) == productIndex,
      data,
    );
    return null;
  }

  Future<Null> updateCartItemCourseId({
    required int productIndex,
    required int? courseId,
  }) async {
    await _updateWhere(
      cartTableNew,
      (row) => _asInt(row[columnProductIndex]) == productIndex,
      {columnCourseId: courseId},
    );
    return null;
  }

  Future<Map<String, dynamic>?> getCartItemByProductIndex(
    int productIndex,
  ) async {
    final rows = await _loadTable(cartTableNew);
    for (final row in rows) {
      if (_asInt(row[columnProductIndex]) == productIndex) {
        return Map<String, dynamic>.from(row);
      }
    }
    return null;
  }

  Future<Null> updateIsRemoveFlag({
    required int productId,
    required int isRemove,
  }) async {
    await _updateWhere(
      cartTableNew,
      (row) => _asInt(row[columnProductID]) == productId,
      {columnIsRemove: isRemove},
    );
    return null;
  }

  Future<Null> updateCustomDiscount({
    required int productIndex,
    int? productId,
    required String? discount,
    required String? notes,
    required int quantity,
    int? customDiscountIsPercentage,
    double? salePrice,
    int? unitMeasure,
    double? uomValue,
    int? employeeId,
    String? employeeName,
  }) async {
    final data = <String, dynamic>{
      columnDefaultDiscount: discount,
      columnQuantity: quantity,
      columnProductNote: notes,
    };
    if (customDiscountIsPercentage != null) {
      data[columnCustomDefaultDiscountPercentage] = customDiscountIsPercentage;
    }
    if (salePrice != null) {
      data[columnSalePrice] = salePrice;
    }
    if (unitMeasure != null) {
      data[columnUnitMeasure] = unitMeasure;
    }
    if (uomValue != null) {
      data[columnUomValue] = uomValue;
    }
    if (employeeId != null) {
      data[columnEmployeeId] = employeeId;
    }
    if (employeeName != null) {
      data[columnEmployeeName] = employeeName;
    }

    final useProductIndex = productIndex > 0;
    await _updateWhere(
      cartTableNew,
      (row) => useProductIndex
          ? _asInt(row[columnProductIndex]) == productIndex
          : _asInt(row[columnProductID]) == productId,
      data,
    );
    return null;
  }

  Future<Null> updateQuantityDiscount({
    required int quantity,
    int? productId,
    int? productIndex,
  }) async {
    final useProductIndex = productIndex != null && productIndex > 0;
    await _updateWhere(
      cartTableNew,
      (row) => useProductIndex
          ? _asInt(row[columnProductIndex]) == productIndex
          : _asInt(row[columnProductID]) == productId,
      {columnQuantity: quantity},
    );
    return null;
  }

  Future<Null> updateCartItemEmployee({
    required int productId,
    int? employeeId,
    String? employeeName,
  }) async {
    await _updateWhere(
      cartTableNew,
      (row) => _asInt(row[columnProductIndex]) == productId,
      {
        columnEmployeeId: employeeId,
        columnEmployeeName: employeeName,
      },
    );
    return null;
  }

  Future<Null> updateCartItemUom({
    required int productId,
    required int uomId,
    required double salePrice,
    required double uomValue,
  }) async {
    await _updateWhere(
      cartTableNew,
      (row) => _asInt(row[columnProductIndex]) == productId,
      {
        columnUnitMeasure: uomId,
        columnSalePrice: salePrice,
        columnUomValue: uomValue,
      },
    );
    return null;
  }

  Future<bool> deleteMenuItemProduct({
    required int productIndex,
  }) async {
    return _deleteWhere(
      menuTableNew,
      (row) => _asInt(row[columnChildProductIndex]) == productIndex,
    );
  }

  Future<bool> deleteMenuItemExclusionProduct({
    required int productIndex,
  }) async {
    return _deleteWhere(
      menuTableNew,
      (row) => _asInt(row[columnExclusionIndex]) == productIndex,
    );
  }

  Future<bool> deleteProduct({
    required int productId,
  }) async {
    return _deleteWhere(
      cartTableNew,
      (row) => _rowId(row) == productId,
    );
  }

  Future<Null> updateIsReturnFlagByProductIndex({
    required int productIndex,
    required int isReturn,
  }) async {
    await _updateWhere(
      cartTableNew,
      (row) => _asInt(row[columnProductIndex]) == productIndex,
      {columnIsReturn: isReturn},
    );
    return null;
  }

  Future<void> addCartItem(CartItem item) async {}

  insert(Map<String, dynamic> row, String tableName) async {
    return _upsertRow(row, tableName);
  }

  insertShippingData(Map<String, dynamic> row, String tableName) async {
    row['id'] = 1;
    return _upsertRow(row, tableName);
  }

  Future<List<CartItem>> getCartItems() async => [];

  Future<void> updateCartItem(CartItem? item) async {}

  Future<void> clearCart() async {
    await _saveTable(cartTableNew, []);
    await _saveTable(menuTableNew, []);
    await _saveTable(dineInTableNew, []);
    await _saveTable(exclusionTableNew, []);
    await WebLocalStore.instance.remove(_tableKey(_cartItemsTable));
  }

  Future<void> deleteCartItem(String id) async {}

  Future<List<Map<String, dynamic>>> queryDatabase({
    required String tableName,
  }) async {
    final rows = await _loadTable(tableName);
    return rows.map((row) => Map<String, dynamic>.from(row)).toList();
  }

  Future<List<MenuItemLocalModelNew>> getMenuTableData() async {
    final maps = await CartService.instance.queryDatabase(
      tableName: menuTableNew,
    );
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(
      maps.length,
      (i) => MenuItemLocalModelNew.fromMap(maps[i]),
    );
  }

  Future<List<CartLocalModel>> getCartTableData() async {
    final maps = await CartService.instance.queryDatabase(
      tableName: cartTableNew,
    );
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(
      maps.length,
      (i) => CartLocalModel.fromMap(maps[i]),
    );
  }

  Future<List<ShippingLocalModel>> getDineTableData() async {
    final maps = await CartService.instance.queryDatabase(
      tableName: dineInTableNew,
    );
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(
      maps.length,
      (i) => ShippingLocalModel.fromMap(maps[i]),
    );
  }

  Future<List<ProductMenuExclusionLocal>> getExclusionTableData() async {
    final maps = await CartService.instance.queryDatabase(
      tableName: exclusionTableNew,
    );
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(
      maps.length,
      (i) => ProductMenuExclusionLocal.fromMap(maps[i]),
    );
  }

  Future<List<MenuItemLocalModelNew>> getMenuTableDataByProductIndex(
    int productIndex,
  ) async {
    final maps = await _loadTable(menuTableNew);
    final filtered = maps
        .where((row) => _asInt(row[columnChildProductIndex]) == productIndex)
        .map((row) => Map<String, dynamic>.from(row))
        .toList();
    if (filtered.isEmpty) {
      return [];
    }
    return List.generate(
      filtered.length,
      (i) => MenuItemLocalModelNew.fromMap(filtered[i]),
    );
  }

  Future<List<ProductMenuExclusionLocal>> getExclusionTableDataByProductIndex(
    int productIndex,
  ) async {
    final maps = await _loadTable(exclusionTableNew);
    final filtered = maps
        .where((row) => _asInt(row[columnExclusionIndex]) == productIndex)
        .map((row) => Map<String, dynamic>.from(row))
        .toList();
    if (filtered.isEmpty) {
      return [];
    }
    return List.generate(
      filtered.length,
      (i) => ProductMenuExclusionLocal.fromMap(filtered[i]),
    );
  }

  Future<void> deleteMenuItemsByProductIndex(int productIndex) async {
    await _deleteWhere(
      menuTableNew,
      (row) => _asInt(row[columnChildProductIndex]) == productIndex,
    );
  }

  Future<void> deleteExclusionsByProductIndex(int productIndex) async {
    await _deleteWhere(
      exclusionTableNew,
      (row) => _asInt(row[columnExclusionIndex]) == productIndex,
    );
  }

  Future<bool> menuItemExists({
    required int productIndex,
    required int productMenuVariationId,
    required int productItemId,
  }) async {
    final rows = await _loadTable(menuTableNew);
    return rows.any(
      (row) =>
          _asInt(row[columnChildProductIndex]) == productIndex &&
          _asInt(row[columnProductMenuVariationId]) == productMenuVariationId &&
          _asInt(row[columnProductItemId]) == productItemId,
    );
  }

  Future<void> updateMenuItemSelection({
    required int productIndex,
    required int productMenuVariationId,
    required int productItemId,
    required int quantity,
    String? productNameEnglish,
    String? productNameArabic,
    String? productSalesDescription,
    String? productImage,
  }) async {
    final data = <String, dynamic>{
      columnProductQuantity: quantity,
    };
    if (productNameEnglish != null && productNameEnglish.trim().isNotEmpty) {
      data[columnProductNameEnglishMenu] = productNameEnglish.trim();
    }
    if (productNameArabic != null && productNameArabic.trim().isNotEmpty) {
      data[columnProductNameArabicMenu] = productNameArabic.trim();
    }
    if (productSalesDescription != null &&
        productSalesDescription.trim().isNotEmpty) {
      data[columnChildProductSalesDescription] =
          productSalesDescription.trim();
    }
    if (productImage != null && productImage.trim().isNotEmpty) {
      data[columnProductImageMenu] = productImage.trim();
    }
    await _updateWhere(
      menuTableNew,
      (row) =>
          _asInt(row[columnChildProductIndex]) == productIndex &&
          _asInt(row[columnProductMenuVariationId]) == productMenuVariationId &&
          _asInt(row[columnProductItemId]) == productItemId,
      data,
    );
  }

  Future<List<MenuItemLocalModelNew>> getAllMenuItemsByProductIndex(
    int productIndex,
  ) async {
    return getMenuTableDataByProductIndex(productIndex);
  }

  Future<void> clearMenuAndExclusionTablesOnly() async {
    await _saveTable(menuTableNew, []);
    await _saveTable(exclusionTableNew, []);
  }

  int _snapshotQty(dynamic qty) {
    if (qty == null) return 0;
    if (qty is int) return qty;
    if (qty is double) return qty.toInt();
    return int.tryParse(qty.toString()) ?? 0;
  }

  Future<void> restoreMenuItemsSnapshot(List<dynamic>? rawList) async {
    if (rawList == null || rawList.isEmpty) return;
    for (final raw in rawList) {
      if (raw is! Map) continue;
      final row = Map<String, dynamic>.from(raw);
      if (_snapshotQty(row[columnProductQuantity]) <= 0) continue;
      await insert(row, menuTableNew);
    }
  }

  Future<void> restoreExclusionsSnapshot(List<dynamic>? rawList) async {
    if (rawList == null || rawList.isEmpty) return;
    for (final raw in rawList) {
      if (raw is! Map) continue;
      final row = Map<String, dynamic>.from(raw);
      final selected = row[columnExclusionSelected];
      final sel = selected is int
          ? selected
          : int.tryParse(selected?.toString() ?? '') ?? 0;
      if (sel != 1) continue;
      await insert(row, exclusionTableNew);
    }
  }

  Future<List<Map<String, dynamic>>> exportMenuTableSnapshot() async {
    return CartService.instance.queryDatabase(tableName: menuTableNew);
  }

  Future<List<Map<String, dynamic>>> exportExclusionTableSnapshot() async {
    return CartService.instance.queryDatabase(tableName: exclusionTableNew);
  }
}
