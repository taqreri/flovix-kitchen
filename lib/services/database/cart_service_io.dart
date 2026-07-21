import 'dart:async';
import 'dart:developer';
import 'package:flovix_kitchen/model/pos/cart/cart_items.dart';
import 'package:flovix_kitchen/model/pos/cart/cart_local_model/cart_local_model.dart';
import 'package:flovix_kitchen/model/pos/cart/cart_local_model/exclusion_local_model.dart';
import 'package:flovix_kitchen/model/pos/cart/cart_local_model/menu_local_model/menu_item_local_model.dart';
import 'package:flovix_kitchen/model/pos/cart/cart_local_model/shipping_local_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import 'database_init_io.dart';

class CartService {
  // static final CartService _instance = CartService._internal();
  //factory CartService() => _instance;
  //static final CartService instance = CartService();
  Database? _database;
  static final CartService instance = CartService();

  // CartService._internal();
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

// menu products

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
// exclusion
  static const columnExclusionParentProductId = "master_product_id";
  static const columnExclusionProductId = "product_menu_exclusion_id";
  static const columnExclusionName = "exclusion_name_en";
  static const columnExclusionNameAr = "exclusion_name_ar";
  static const columnExclusionIndex = "exclusion_index";
  static const columnExclusionSelected = "exclusion_selected";

  // dine in
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

  //printerdata
  static const columnPrinterSno = "printer_sno";
  static const columnPrinterName = "name";
  static const columnPrinterIsActive = "is_active";
  static const columnAvailablePrinter = "available_printer";
  static const columnPrinterType = "printer_type";
  static const columnPrinterProductId = "printer_product_id";
  static const columnPrinterVendorId = "vendor_id";
  static const columnPrinterIpAddress = "ip_address";
  static const columnPrinterPort = "printer_port";

  Future<void> _createDb(Database db, int version) async {
    db.execute('''
      CREATE TABLE $dineInTableNew (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnDineIn INTEGER NOT NULL DEFAULT 1,
      $columnFloorName TEXT,
      $columnFloorId INTEGER NOT NULL DEFAULT 1,  
      $columnTableId INTEGER NOT NULL DEFAULT 1,
      $columnTableName TEXT,
      $columnDinners INTEGER NOT NULL DEFAULT 0,
      $columnSalePersonId INTEGER NOT NULL DEFAULT 0,
      $columnSalePersonShortName TEXT,
      $columnShippingName TEXT,
      $columnShippingId INTEGER NOT NULL DEFAULT 0,
      $columnDeliveryManName TEXT,
      $columnDeliveryManId INTEGER NOT NULL DEFAULT 0
      
      )
      ''');
    db.execute('''
      CREATE TABLE $exclusionTableNew (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnExclusionParentProductId INTEGER NOT NULL DEFAULT 1,
      $columnExclusionProductId INTEGER NOT NULL DEFAULT 1,
      $columnExclusionIndex INTEGER NOT NULL DEFAULT 1,
      $columnExclusionSelected INTEGER NOT NULL DEFAULT 0,
      $columnExclusionName TEXT,
      $columnExclusionNameAr TEXT
      )
      ''');
    db.execute('''
      CREATE TABLE $menuTableNew (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnParentProductId INTEGER NOT NULL DEFAULT 1,
      
      $columnMenuVariationId INTEGER NOT NULL DEFAULT 1,
      $columnVariationId INTEGER NOT NULL DEFAULT 1,
      $columnChildProductIndex INTEGER NOT NULL DEFAULT 1,
      $columnProductMenuVariationId INTEGER NOT NULL DEFAULT 1,
      $columnParentProductPType INTEGER NOT NULL DEFAULT 1,
      $columnParentProductName TEXT,
      $columnParentProductArabic TEXT,
      $columnParentProductImage TEXT,
      $columnParentProductTaxable INTEGER NOT NULL DEFAULT 0,
      $columnParentProductTaxInclusive INTEGER NOT NULL DEFAULT 0,
      $columnParentProductUnitMeasure REAL,
      $columnProductVariationName TEXT,
      $columnProductVariationArabic TEXT,
      $columnProductNameEnglishMenu TEXT,
      $columnProductNameArabicMenu TEXT,
      $columnProductImageMenu TEXT,
      $columnChildProductSalesDescription TEXT,
      $columnProductUnitMeasure REAL,
      $columnProductSalePrice REAL,
      $columnProductCostPrice REAL,
      $columnProductBarCode TEXT,
      $columnProductDefaultDiscount TEXT,
      $columnProductQuantity INTEGER NOT NULL DEFAULT 0,
      $columnProductItemId INTEGER NOT NULL DEFAULT 0,
      $columnProductCalculatedDiscount REAL,
      $columnProductCalculatedTax REAL,
      $columnProductCounterDiscount REAL,
      $columnProductStock INTEGER NOT NULL DEFAULT 0,
      $columnProductIsPercentage INTEGER NOT NULL DEFAULT 0,
      $columnProductIsTaxable INTEGER NOT NULL DEFAULT 0,
      $columnProductIsTaxInclusive INTEGER NOT NULL DEFAULT 0,
      $columnProductPType INTEGER NOT NULL DEFAULT 0,
      $columnIsSingleChoice INTEGER NOT NULL DEFAULT 0,
      $columnIsMultiChoice INTEGER NOT NULL DEFAULT 0,
      $columnIsNoPrint INTEGER NOT NULL DEFAULT 0,
      $columnMaxAllowQuantity INTEGER NOT NULL DEFAULT 0

      )
      ''');

    db.execute('''
      CREATE TABLE $cartTableNew (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnProductID INTEGER NOT NULL DEFAULT 1,
      $columnQuantity INTEGER NOT NULL DEFAULT 1,
      $columnIsRemove INTEGER NOT NULL DEFAULT 1,
      $columnIsReturn INTEGER NOT NULL DEFAULT 0,
      $columnIsMenuItem INTEGER NOT NULL DEFAULT 0,
      $columnInvoiceReg INTEGER NOT NULL DEFAULT 1,
      $columnIsExclusionItem INTEGER NOT NULL DEFAULT 1,
      $columnProductIndex INTEGER NOT NULL DEFAULT 1,
      $columnImagePath TEXT,     
      $columnProductNameEnglish TEXT,
      $columnProductTags TEXT,
      $columnProductNameArabic TEXT,
      $columnProductSalesDescription TEXT,
      $columnTaxable INTEGER NOT NULL DEFAULT 1,
      $columnTaxInclusive INTEGER NOT NULL DEFAULT 1,
      $columnPType INTEGER NOT NULL DEFAULT 1,
      $columnTaxId INTEGER NOT NULL DEFAULT 1,
      $columnCustomDefaultDiscountPercentage INTEGER NOT NULL DEFAULT 0,
      $columnDefaultDiscount TEXT,
      $columnCustomDefaultDiscount TEXT,
      $columnSalePrice REAL,
      $columnUomValue REAL,
      $columnCostPrice REAL,
      $columnUnitMeasure INTEGER NOT NULL DEFAULT 1,
      $columnTaxValue REAL,
      $columnIsTaxPercent INTEGER NOT NULL DEFAULT 1,
      $columnBarCode TEXT,
      $columnEmployeeId INTEGER NOT NULL DEFAULT 0,
      $columnEmployeeName TEXT,
      $columnProductNote TEXT,
      $columnCourseId INTEGER,
      $columnUomListJson TEXT,
      $columnPrinterSno INTEGER,
      $columnPrinterName TEXT,
      $columnPrinterIsActive INTEGER,
      $columnAvailablePrinter TEXT,
      $columnPrinterType TEXT,
      $columnPrinterProductId TEXT,
      $columnPrinterVendorId TEXT,
      $columnPrinterIpAddress TEXT,
      $columnPrinterPort TEXT
      
      
      

      )
      ''');
    await db.execute('''
      CREATE TABLE cart_items(
        id TEXT PRIMARY KEY, 
        imagePath TEXT, 
        name TEXT, 
        description TEXT, 
        quantity INTEGER, 
        price REAL, 
        discount REAL, 
        tax REAL, 
        tax_inclusive_amount REAL,  
        tax_exclusive_amount REAL,  
        itemTaxRate REAL,           
        itemTaxValue REAL,          
        variations TEXT, 
        menuOptions TEXT, 
        variationsIds TEXT, 
        menuOptionsIds TEXT,
        unitMeasure INTEGER DEFAULT 0,
        taxable TEXT,
        default_tax TEXT,
        default_tax2 TEXT,
        max_tax TEXT,
        min_tax TEXT,
        p_tax_code TEXT,
        tax_account TEXT,
        tax_inclusive TEXT,
        tax_type TEXT,
        taxSno TEXT,
        itemBatch TEXT
      )
    ''');
  }

  static const int _currentDbVersion = 19;

  Future<Null> updateProductQuantity({
    required int productId,
    required int quantity,
  }) async {
    final db = instance._database;

    return await db!
        .update(
      cartTableNew,
      {
        columnQuantity: quantity,
      },
      where: '$columnProductID = ?',
      whereArgs: [productId],
    )
        .then((onValue) {
    }).onError((handleError, sta) {
    });
  }

  Future<Null> updateCartItemByProductIndex({
    required int productIndex,
    required double salePrice,
  }) async {
    final db = await _initDB();

    return await db
        .update(
      cartTableNew,
      {
        columnSalePrice: salePrice,
      },
      where: '$columnProductIndex = ?',
      whereArgs: [productIndex],
    )
        .then((onValue) {
    }).onError((handleError, sta) {
    });
  }

  Future<Null> updateCartItemByProductIndexFull({
    required int productIndex,
    required Map<String, dynamic> data,
  }) async {
    final db = await _initDB();

    return await db
        .update(
      cartTableNew,
      data,
      where: '$columnProductIndex = ?',
      whereArgs: [productIndex],
    )
        .then((onValue) {
    }).onError((handleError, sta) {
    });
  }

  Future<Null> updateCartItemCourseId({
    required int productIndex,
    required int? courseId,
  }) async {
    final db = await _initDB();

    return await db
        .update(
      cartTableNew,
      {
        columnCourseId: courseId,
      },
      where: '$columnProductIndex = ?',
      whereArgs: [productIndex],
    )
        .then((onValue) {
    }).onError((handleError, sta) {
    });
  }

  Future<Map<String, dynamic>?> getCartItemByProductIndex(int productIndex) async {
    final db = await _initDB();
    final List<Map<String, dynamic>> maps = await db.query(
      cartTableNew,
      where: '$columnProductIndex = ?',
      whereArgs: [productIndex],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }
    return maps.first;
  }

  Future<Null> updateIsRemoveFlag({
    required int productId,
    required int isRemove,
  }) async {
    final db = instance._database;
    
    return await db!
        .update(
      cartTableNew,
      {
        columnIsRemove: isRemove,
      },
      where: '$columnProductID = ?',
      whereArgs: [productId],
    )
        .then((onValue) {
    }).onError((handleError, sta) {
    });
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
    final db = await CartService.instance._initDB();

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
    final where = useProductIndex
        ? '$columnProductIndex = ?'
        : '$columnProductID = ?';
    final whereArgs = <Object?>[
      useProductIndex ? productIndex : productId,
    ];

    return await db
        .update(
      cartTableNew,
      data,
      where: where,
      whereArgs: whereArgs,
    )
        .then((onValue) {
    }).onError((handleError, sta) {
    });
  }Future<Null> updateQuantityDiscount({
    required int quantity,
    int? productId,
    int? productIndex,
  }) async {
    final db = await _initDB();
    final useProductIndex = productIndex != null && productIndex > 0;
    final where = useProductIndex
        ? '$columnProductIndex = ?'
        : '$columnProductID = ?';
    final whereArgs = <Object?>[
      useProductIndex ? productIndex : productId,
    ];

    return await db
        .update(
      cartTableNew,
      {
        columnQuantity: quantity,
      },
      where: where,
      whereArgs: whereArgs,
    )
        .then((onValue) {
    }).onError((handleError, sta) {
    });
  }

  Future<Null> updateCartItemEmployee({
    required int productId,
    int? employeeId,
    String? employeeName,
  }) async {
    final db = instance._database;

    return await db!
        .update(
      cartTableNew,
      {
        columnEmployeeId: employeeId,
        columnEmployeeName: employeeName,
      },
      where: '$columnProductIndex = ?',
      whereArgs: [productId],
    )
        .then((onValue) {
    }).onError((handleError, sta) {
    });
  }

  Future<Null> updateCartItemUom({
    required int productId,
    required int uomId,
    required double salePrice,
    required double uomValue,
  }) async {
    final db = instance._database;

    return await db!
        .update(
      cartTableNew,
      {
        columnUnitMeasure: uomId,
        columnSalePrice: salePrice,
        columnUomValue: uomValue,
      },
      where: '$columnProductIndex = ?',
      whereArgs: [productId],
    )
        .then((onValue) {
    }).onError((handleError, sta) {
    });
  }

  Future<bool> deleteMenuItemProduct({
    required int productIndex,
    //  required int quantity,
  }) async {
    final db = instance._database;

    return await db!.delete(
      menuTableNew,
      where: '$columnChildProductIndex = ?',
      whereArgs: [productIndex],
    ).then((onValue) {
      return true;
    }).onError((handleError, sta) {
      return false;
    });
  }
  Future<bool> deleteMenuItemExclusionProduct({
    required int productIndex,
    //  required int quantity,
  }) async {
    final db = instance._database;

    return await db!.delete(
      menuTableNew,
      where: '$columnExclusionIndex = ?',
      whereArgs: [productIndex],
    ).then((onValue) {
      return true;
    }).onError((handleError, sta) {
      return false;
    });
  }
  Future<bool> deleteProduct({
    required int productId,
    //  required int quantity,
  }) async {
    final db = instance._database;

    return await db!.delete(
      cartTableNew,
      where: 'id = ?',
      whereArgs: [productId],
    ).then((onValue) {
      return true;
    }).onError((handleError, sta) {
      return false;
    });
  }

  Future<Database> _initDB() async {
    if (_database != null) return _database!;

    final path = await getAppDatabasePath('taqreri_pos.db');
    _database = await openDatabase(
      path,
      version: _currentDbVersion,
      onCreate: _createDb,
      onUpgrade: _upgradeDb,
    );
    return _database!;
  }

  Future<void> _upgradeDb(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _migrateV1ToV2(db);
    }
    if (oldVersion < 3) {
      await _migrateV2ToV3(db);
    }
    if (oldVersion < 4) {
      await _migrateV3ToV4(db);
    }
    if (oldVersion < 5) {
      await _migrateV4ToV5(db);
    }
    if (oldVersion < 6) {
      await _migrateV5ToV6(db);
    }
    if (oldVersion < 12) {
      await _migrateV11ToV12(db);
    }
    if (oldVersion < 13) {
      await _migrateV12ToV13(db);
    }
    if (oldVersion < 17) {
      await _migrateV16ToV17(db);
    }
    if (oldVersion < 18) {
      await _migrateV17ToV18(db);
    }
    if (oldVersion < 19) {
      await _migrateV18ToV19(db);
    }
    /*  if (oldVersion < 10) {
      await _migrateV9ToV10(db);
    }**/
  }

  Future<void> _migrateV1ToV2(Database db) async {
    try {
      final columns = await db.rawQuery('PRAGMA table_info(cart_items)');
      if (!columns.any((col) => col['name'] == 'unitMeasure')) {
        await db.execute('''
          ALTER TABLE cart_items 
          ADD COLUMN unitMeasure INTEGER DEFAULT 0
        ''');
      }
    } catch (e) {
      await _recreateTable(db, 2);
    }
  }

  Future<void> _migrateV2ToV3(Database db) async {
    try {
      final columns = await db.rawQuery('PRAGMA table_info(cart_items)');
      final newColumns = [
        'tax_inclusive_amount',
        'tax_exclusive_amount',
        'taxable',
        'default_tax',
        'default_tax2',
        'max_tax',
        'min_tax',
        'p_tax_code',
        'tax_account',
        'tax_inclusive',
        'tax_type',
      ];

      for (final column in newColumns) {
        if (!columns.any((col) => col['name'] == column)) {
          final type = column.endsWith('_amount') ? 'REAL' : 'TEXT';
          await db.execute('''
            ALTER TABLE cart_items 
            ADD COLUMN $column $type
          ''');
        }
      }
    } catch (e) {
      await _recreateTable(db, 3);
    }
  }

  Future<void> _migrateV3ToV4(Database db) async {
    try {
      final columns = await db.rawQuery('PRAGMA table_info(cart_items)');
      if (!columns.any((col) => col['name'] == 'itemTaxRate')) {
        await db.execute('ALTER TABLE cart_items ADD COLUMN itemTaxRate REAL');
      }
      if (!columns.any((col) => col['name'] == 'itemTaxValue')) {
        await db.execute('ALTER TABLE cart_items ADD COLUMN itemTaxValue REAL');
      }
    } catch (e) {
      await _recreateTable(db, 4);
    }
  }

  Future<void> _migrateV4ToV5(Database db) async {
    try {
      final columns = await db.rawQuery('PRAGMA table_info(cart_items)');
      if (!columns.any((col) => col['name'] == 'taxSno')) {
        await db.execute('ALTER TABLE cart_items ADD COLUMN taxSno TEXT');
      }
    } catch (e) {
      await _recreateTable(db, 5);
    }
  }

  Future<void> _migrateV5ToV6(Database db) async {
    try {
      final columns = await db.rawQuery('PRAGMA table_info(cart_items)');
      if (!columns.any((col) => col['name'] == 'itemBatch')) {
        await db.execute('ALTER TABLE cart_items ADD COLUMN itemBatch TEXT');
      }
    } catch (e) {
      await _recreateTable(db, 6);
    }
  }

  Future<void> _migrateV11ToV12(Database db) async {
    try {
      final columns = await db.rawQuery('PRAGMA table_info($cartTableNew)');
      if (!columns.any((col) => col['name'] == 'printer_sno')) {
        await db.execute('ALTER TABLE $cartTableNew ADD COLUMN printer_sno INTEGER');
        
      }
    } catch (e) {
    }
  }

  Future<void> _migrateV12ToV13(Database db) async {
    try {
      // Clear old printer data to prevent inconsistencies with printer_sno
      await db.execute('''
        UPDATE $cartTableNew SET 
          $columnPrinterName = NULL,
          $columnPrinterIsActive = NULL,
          $columnAvailablePrinter = NULL,
          $columnPrinterType = NULL,
          $columnPrinterProductId = NULL,
          $columnPrinterVendorId = NULL,
          $columnPrinterIpAddress = NULL,
          $columnPrinterPort = NULL
      ''');
      
    } catch (e) {
    }
  }

  Future<void> _migrateV16ToV17(Database db) async {
    try {
      final columns = await db.rawQuery('PRAGMA table_info($cartTableNew)');
      if (!columns.any((col) => col['name'] == columnCourseId)) {
        await db.execute('ALTER TABLE $cartTableNew ADD COLUMN $columnCourseId INTEGER');
        
      }
    } catch (e) {
    }
  }

  Future<void> _migrateV17ToV18(Database db) async {
    try {
      final columns = await db.rawQuery('PRAGMA table_info($menuTableNew)');
      if (!columns.any((col) => col['name'] == columnProductImageMenu)) {
        await db.execute(
            'ALTER TABLE $menuTableNew ADD COLUMN $columnProductImageMenu TEXT');
        
      }
    } catch (e) {
    }
  }

  Future<void> _migrateV18ToV19(Database db) async {
    try {
      final columns = await db.rawQuery('PRAGMA table_info($cartTableNew)');
      if (!columns.any((col) => col['name'] == columnIsReturn)) {
        await db.execute(
            'ALTER TABLE $cartTableNew ADD COLUMN $columnIsReturn INTEGER NOT NULL DEFAULT 0');
        
      }
    } catch (e) {
    }
  }

  Future<Null> updateIsReturnFlagByProductIndex({
    required int productIndex,
    required int isReturn,
  }) async {
    final db = await _initDB();
    return await db
        .update(
      cartTableNew,
      {
        columnIsReturn: isReturn,
      },
      where: '$columnProductIndex = ?',
      whereArgs: [productIndex],
    )
        .then((onValue) {
    }).onError((handleError, sta) {
    });
  }

  Future<void> _recreateTable(Database db, int targetVersion) async {
    final List<Map<String, dynamic>> oldData = await db.query('cart_items');
    await db.execute('DROP TABLE IF EXISTS cart_items');

    if (targetVersion == 2) {
      await _createV2Table(db);
    } else {
      await _createDb(db, _currentDbVersion);
    }

    for (final item in oldData) {
      final newItem = Map<String, dynamic>.from(item);

      newItem['tax_inclusive_amount'] = item['tax_inclusive_amount'] ?? null;
      newItem['tax_exclusive_amount'] = item['tax_exclusive_amount'] ?? null;
      newItem['taxable'] = item['taxable'] ?? null;
      newItem['default_tax'] = item['default_tax'] ?? null;
      newItem['default_tax2'] = item['default_tax2'] ?? null;
      newItem['max_tax'] = item['max_tax'] ?? null;
      newItem['min_tax'] = item['min_tax'] ?? null;
      newItem['p_tax_code'] = item['p_tax_code'] ?? null;
      newItem['tax_account'] = item['tax_account'] ?? null;
      newItem['tax_inclusive'] = item['tax_inclusive'] ?? null;
      newItem['tax_type'] = item['tax_type'] ?? null;
      newItem['unitMeasure'] = item['unitMeasure'] ?? 0;
      newItem['itemTaxRate'] = item['itemTaxRate'] ?? null;
      newItem['itemTaxValue'] = item['itemTaxValue'] ?? null;
      newItem['taxSno'] = item['taxSno'] ?? null;
      newItem['itemBatch'] = item['itemBatch'] ?? null;

      await db.insert('cart_items', newItem);
    }
  }

  Future<void> _createV2Table(Database db) async {
    await db.execute('''
      CREATE TABLE cart_items(
        id TEXT PRIMARY KEY, 
        imagePath TEXT, 
        name TEXT, 
        description TEXT, 
        quantity INTEGER, 
        price REAL, 
        discount REAL, 
        tax REAL, 
        variations TEXT, 
        menuOptions TEXT, 
        variationsIds TEXT, 
        menuOptionsIds TEXT,
        unitMeasure INTEGER DEFAULT 0
      )
    ''');
  }

  Future<void> addCartItem(CartItem item) async {
    final db = await _initDB();
    await db.insert(
      'cart_items',
      item.toMap(), // Now includes itemBatch
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  insert(Map<String, dynamic> row, String tableName) async {
    // row['id'] = 1;
    Database? db = instance._database;
    return await db?.insert(
      tableName,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  insertShippingData(Map<String, dynamic> row, String tableName) async {
    row['id'] = 1;
    
    Database? db = instance._database;
    return await db?.insert(
      tableName,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await _initDB();
    final List<Map<String, dynamic>> maps = await db.query('cart_items');
    return List.generate(maps.length, (i) => CartItem.fromMap(maps[i]));
  }

  Future<void> updateCartItem(CartItem? item) async {
    final db = await _initDB();
    await db.update(
      'cart_items',
      item!.toMap(), // Now includes itemBatch
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  /// Clears all cart-related SQLite tables. Always uses [instance] and opens
  /// the DB first — calling `CartService().clearCart()` on a new instance
  /// previously left `_database` null so deletes never ran.
  Future<void> clearCart() async {
    final db = await CartService.instance._initDB();
    await db.delete(cartTableNew);
    await db.delete(menuTableNew);
    await db.delete(dineInTableNew);
    await db.delete(exclusionTableNew);
    try {
      await db.delete('cart_items');
    } catch (e, st) {
    }
  }

  Future<void> deleteCartItem(String id) async {
    final db = await _initDB();
    await db.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> queryDatabase({
    required String tableName,
  }) async {
    final db = await _initDB(); // <-- initialize database here
    return await db.query(tableName);
  }

  Future<List<MenuItemLocalModelNew>> getMenuTableData() async {
    //  Database? db = await instance._database;
    // var dbquery = await DatabaseHelper.instance.queryDatabase();
    final List<Map<String, dynamic>> maps =
    await CartService.instance.queryDatabase(tableName: menuTableNew);
    

    if (maps.isEmpty) {
      return [];
    }
    //  final List<Map<String, dynamic>> maps = await db!.query('recordings');
    return List.generate(maps.length, (i) {

      return MenuItemLocalModelNew.fromMap(maps[i]);
    });
  }

  Future<List<CartLocalModel>> getCartTableData() async {
    //  Database? db = await instance._database;
    // var dbquery = await DatabaseHelper.instance.queryDatabase();
    final List<Map<String, dynamic>> maps =
    await CartService.instance.queryDatabase(tableName: cartTableNew);
    

    if (maps.isEmpty) {

      return [];
    }
    //  final List<Map<String, dynamic>> maps = await db!.query('recordings');
    return List.generate(maps.length, (i) {

      return CartLocalModel.fromMap(maps[i]);
    });
  }

  Future<List<ShippingLocalModel>> getDineTableData() async {
    //  Database? db = await instance._database;
    // var dbquery = await DatabaseHelper.instance.queryDatabase();
    final List<Map<String, dynamic>> maps =
    await CartService.instance.queryDatabase(tableName: dineInTableNew);
    

    if (maps.isEmpty) {
      return [];
    }
    //  final List<Map<String, dynamic>> maps = await db!.query('recordings');
    return List.generate(maps.length, (i) {
      return ShippingLocalModel.fromMap(maps[i]);
    });
  }  Future<List<ProductMenuExclusionLocal>> getExclusionTableData() async {
    //  Database? db = await instance._database;
    // var dbquery = await DatabaseHelper.instance.queryDatabase();
    final List<Map<String, dynamic>> maps =
    await CartService.instance.queryDatabase(tableName: exclusionTableNew);
    

    if (maps.isEmpty) {
      return [];
    }
    //  final List<Map<String, dynamic>> maps = await db!.query('recordings');
    return List.generate(maps.length, (i) {
      return ProductMenuExclusionLocal.fromMap(maps[i]);
    });
  }

  Future<List<MenuItemLocalModelNew>> getMenuTableDataByProductIndex(int productIndex) async {
    final db = await _initDB();
    final List<Map<String, dynamic>> maps = await db.query(
      menuTableNew,
      where: '$columnChildProductIndex = ?',
      whereArgs: [productIndex],
    );
    
    maps.forEach((element){

    });
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (i) {

      return MenuItemLocalModelNew.fromMap(maps[i]);
    });
  }

  Future<List<ProductMenuExclusionLocal>> getExclusionTableDataByProductIndex(int productIndex) async {
    final db = await _initDB();
    final List<Map<String, dynamic>> maps = await db.query(
      exclusionTableNew,
      where: '$columnExclusionIndex = ?',
      whereArgs: [productIndex],
    );
    

    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (i) {
      return ProductMenuExclusionLocal.fromMap(maps[i]);
    });
  }

  Future<void> deleteMenuItemsByProductIndex(int productIndex) async {
    final db = await _initDB();
    await db.delete(
      menuTableNew,
      where: '$columnChildProductIndex = ?',
      whereArgs: [productIndex],
    );
    
  }

  Future<void> deleteExclusionsByProductIndex(int productIndex) async {
    final db = await _initDB();
    await db.delete(
      exclusionTableNew,
      where: '$columnExclusionIndex = ?',
      whereArgs: [productIndex],
    );
    
  }

  // Check if menu item exists in database
  Future<bool> menuItemExists({
    required int productIndex,
    required int productMenuVariationId,
    required int productItemId,
  }) async {
    final db = await _initDB();
    final result = await db.query(
      menuTableNew,
      where: '$columnChildProductIndex = ? AND $columnProductMenuVariationId = ? AND $columnProductItemId = ?',
      whereArgs: [productIndex, productMenuVariationId, productItemId],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  // Update menu item selection and quantity (instead of delete/insert)
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
    final db = await _initDB();
    final data = <String, Object?>{
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
    await db.update(
      menuTableNew,
      data,
      where:
          '$columnChildProductIndex = ? AND $columnProductMenuVariationId = ? AND $columnProductItemId = ?',
      whereArgs: [productIndex, productMenuVariationId, productItemId],
    );
  }

  // Get all menu items for a product (including unselected ones)
  Future<List<MenuItemLocalModelNew>> getAllMenuItemsByProductIndex(int productIndex) async {
    final db = await _initDB();
    final List<Map<String, dynamic>> maps = await db.query(
      menuTableNew,
      where: '$columnChildProductIndex = ?',
      whereArgs: [productIndex],
    );
    

    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (i) {
      return MenuItemLocalModelNew.fromMap(maps[i]);
    });
  }

  /// Clears menu + exclusion SQLite only (cart lines untouched).
  Future<void> clearMenuAndExclusionTablesOnly() async {
    final db = await _initDB();
    await db.delete(menuTableNew);
    await db.delete(exclusionTableNew);
  }

  int _snapshotQty(dynamic qty) {
    if (qty == null) return 0;
    if (qty is int) return qty;
    if (qty is double) return qty.toInt();
    return int.tryParse(qty.toString()) ?? 0;
  }

  /// Restores menu child rows saved via [menu_items_snapshot] on hold/invoice.
  Future<void> restoreMenuItemsSnapshot(List<dynamic>? rawList) async {
    if (rawList == null || rawList.isEmpty) return;
    for (final raw in rawList) {
      if (raw is! Map) continue;
      final row = Map<String, dynamic>.from(raw);
      if (_snapshotQty(row[columnProductQuantity]) <= 0) continue;
      await insert(row, menuTableNew);
    }
  }

  /// Restores exclusion rows saved via [exclusions_snapshot].
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

  /// Raw DB rows for offline hold snapshots (column names match insert).
  Future<List<Map<String, dynamic>>> exportMenuTableSnapshot() async {
    return CartService.instance.queryDatabase(tableName: menuTableNew);
  }

  Future<List<Map<String, dynamic>>> exportExclusionTableSnapshot() async {
    return CartService.instance.queryDatabase(tableName: exclusionTableNew);
  }
}
