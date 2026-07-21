import 'dart:developer';

import 'package:equatable/equatable.dart';

/// sno : 1
/// variation_name : "single choice"
/// variation_name_ar : "single choice"
/// branch : 0
/// status : 1
/// is_multi_choice : 0
/// is_no_print : 0
/// single_choice : 1
/// created_by : 1
/// created_at : "2023-11-06 06:42:41"
/// updated_by : 1
/// updated_at : "2023-12-22 18:29:43"
/// menu_items : [{"product_menu_variation_id":629,"product_menu_list_id":1,"master_product_id":1627,"item_id":1,"item_sale_price":50,"item_quantity":1,"item_unit_id":21,"item_total":50,"is_active":1,"is_default":1,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"product":{"sno":1,"p_code":"","p_tax_code":null,"sub_itemof":0,"item_group":"0","p_cat_id":2,"p_name":"1-T.Excl","p_name_ar":"","slug":"1-T-Excl","p_reg_date":"2023-05-31","p_type":4,"unit_measure":21,"if_purchased":0,"unit_sale":0,"unit_purchase":0,"unit_shipping":0,"vendor_number":null,"purchase_description":"","sales_description":"حبة بروست/عادي","cost_price":0,"sale_price":50,"tax_type":0,"is_percentage":0,"taxable":1,"cogs_account":0,"income_account":6,"assets_account":0,"tax_account":0,"expense_account":0,"discount":null,"discount_start_at":null,"discount_end_at":null,"discount_account":0,"preferred_vendor":0,"reorder_point_min":0,"reorder_point_max":0,"assembly_specific":0,"client_sno":28,"company_sno":347,"user_sno":616,"product_photo":null,"gl_account":0,"bar_code":"10011","sku":"0","default_discount":"0","default_discount2":"0","default_tax":"0","default_tax2":"0","assembly_item_id":"","assembly_item_qty":"","assembly_item_unit":"","assembly_net_cost":0,"assembly_item_waste":"","pay_method":0,"item_image":null,"reporting_unit":0,"weight_unit":0,"p_status":1,"min_sale_price":0,"max_sale_price":0,"min_sale_qty":0,"max_sale_qty":0,"min_discount":"0","max_discount":"0","min_tax":"0","max_tax":"0","consumer_price":0,"is_bonus":0,"p_brand_id":0,"product_unit_label":0,"sellable":1,"p_branch_id":0,"opening_qty":0,"b_profile_id":1,"is_featured":0,"tax_inclusive":0,"product_tags":"","product_time":null,"available_online":1,"expiry_in_days":0,"short_description":"","long_description":"","shipping_weight":"0","product_volume":"0","admin_cost":0,"indirect_cost":0,"labor_cost":0,"machine_cost":0,"sales_cost":0,"other_cost":0,"bom_cost":0,"emp_id":1,"updated_at":"2025-05-15 06:54:12","variation_text":"","variation_id":"","attribute_id":"","parent_id":0,"lab_test_type":0,"hospital_type":0,"max_menu_items":"","out_of_stock":0,"unit_sales_quantity":0,"item_ordering":0,"salla_product_id":null,"salla_sale_price":0,"salla_cost_price":0,"salla_qty":0,"is_coupen_code_available":0}},{"product_menu_variation_id":630,"product_menu_list_id":1,"master_product_id":1627,"item_id":2,"item_sale_price":70,"item_quantity":1,"item_unit_id":21,"item_total":70,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"product":{"sno":2,"p_code":"","p_tax_code":null,"sub_itemof":0,"item_group":"7","p_cat_id":2,"p_name":"2 T.Incl","p_name_ar":"نص بروست عادي","slug":"2-T-Incl","p_reg_date":"2023-05-31","p_type":4,"unit_measure":21,"if_purchased":0,"unit_sale":0,"unit_purchase":0,"unit_shipping":0,"vendor_number":null,"purchase_description":"","sales_description":"Fried Onions Description ","cost_price":0,"sale_price":50,"tax_type":0,"is_percentage":0,"taxable":1,"cogs_account":0,"income_account":6,"assets_account":0,"tax_account":0,"expense_account":0,"discount":null,"discount_start_at":null,"discount_end_at":null,"discount_account":0,"preferred_vendor":0,"reorder_point_min":0,"reorder_point_max":0,"assembly_specific":0,"client_sno":28,"company_sno":347,"user_sno":616,"product_photo":null,"gl_account":0,"bar_code":"1002","sku":"0","default_discount":"2","default_discount2":"0","default_tax":"0","default_tax2":"0","assembly_item_id":"","assembly_item_qty":"","assembly_item_unit":"","assembly_net_cost":0,"assembly_item_waste":"","pay_method":0,"item_image":"friedonionsuserdb240105040810pm6597ff3ae5604.png","reporting_unit":0,"weight_unit":0,"p_status":1,"min_sale_price":1,"max_sale_price":1,"min_sale_qty":0,"max_sale_qty":0,"min_discount":"0","max_discount":"0","min_tax":"0","max_tax":"0","consumer_price":0,"is_bonus":0,"p_brand_id":0,"product_unit_label":0,"sellable":1,"p_branch_id":0,"opening_qty":0,"b_profile_id":1,"is_featured":0,"tax_inclusive":1,"product_tags":"","product_time":null,"available_online":1,"expiry_in_days":0,"short_description":"","long_description":"","shipping_weight":"0","product_volume":"0","admin_cost":0,"indirect_cost":0,"labor_cost":0,"machine_cost":0,"sales_cost":0,"other_cost":0,"bom_cost":0,"emp_id":1,"updated_at":"2025-09-07 20:42:04","variation_text":"","variation_id":"","attribute_id":"","parent_id":0,"lab_test_type":0,"hospital_type":0,"max_menu_items":"","out_of_stock":0,"unit_sales_quantity":0,"item_ordering":0,"salla_product_id":null,"salla_sale_price":0,"salla_cost_price":0,"salla_qty":0,"is_coupen_code_available":0}}]

class MenuVariationTypes extends Equatable {
  int? sno;
  int? isLocked;
  String? variationName;
  String? variationNameAr;
  int? branch;
  int? status;
  int? isMultiChoice;
  int? isNoPrint;
  int? singleChoice;
  String? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? maxAllowQty;
  List<MenuItems>? menuItems;

  MenuVariationTypes({
    this.sno,
    this.variationName,
    this.variationNameAr,
    this.branch,
    this.status,
    this.isMultiChoice,
    this.isLocked,
    this.isNoPrint,
    this.singleChoice,
    this.createdBy,
    this.maxAllowQty,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.menuItems,
  });

  @override
  List<Object?> get props => [
    sno,
    variationName,
    variationNameAr,
    branch,
    status,
    isMultiChoice,
    isNoPrint,
    isLocked,
    singleChoice,
    createdBy,
    createdAt,
    updatedBy,
    updatedAt,
    maxAllowQty,
    menuItems,
  ];

  MenuVariationTypes.fromJson(dynamic json) {
    // Use null-aware operators and sane defaults so missing / null fields
    // don't cause runtime issues elsewhere.
    sno = json['sno'] is int ? json['sno'] as int : int.tryParse('${json['sno'] ?? 0}');
    variationName = json['variation_name']?.toString();
    variationNameAr = json['variation_name_ar']?.toString();
    branch = json['branch'] is int ? json['branch'] as int : int.tryParse('${json['branch'] ?? 0}');
    isLocked = json['is_locked'] is int ? json['is_locked'] as int : int.tryParse('${json['is_locked'] ?? 0}');
    status = json['status'] is int ? json['status'] as int : int.tryParse('${json['status'] ?? 0}');
    isMultiChoice = json['is_multi_choice'] is int
        ? json['is_multi_choice'] as int
        : int.tryParse('${json['is_multi_choice'] ?? 0}');
    
    isNoPrint = json['is_no_print'] is int
        ? json['is_no_print'] as int
        : int.tryParse('${json['is_no_print'] ?? 0}');

    singleChoice = json['single_choice'] is int
        ? json['single_choice'] as int
        : int.tryParse('${json['single_choice'] ?? 0}');
    maxAllowQty = json['max_qty']?.toString();
    // createdBy = json['created_by'];
    // createdAt = json['created_at'];
    // updatedBy = json['updated_by'];
    // updatedAt = json['updated_at'];

    if (json['menu_items'] != null && json['menu_items'] is Iterable) {
      menuItems = [];
      for (final v in (json['menu_items'] as Iterable)) {
        menuItems!.add(MenuItems.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['variation_name'] = variationName;
    map['variation_name_ar'] = variationNameAr;
    map['branch'] = branch;
    map['is_locked'] = isLocked;
    map['status'] = status;
    map['is_multi_choice'] = isMultiChoice;
    map['max_qty'] = maxAllowQty;
    map['is_no_print'] = isNoPrint;
    map['single_choice'] = singleChoice;
    map['created_by'] = createdBy;
    map['created_at'] = createdAt;
    map['updated_by'] = updatedBy;
    map['updated_at'] = updatedAt;
    if (menuItems != null) {
      map['menu_items'] = menuItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  /// ✅ Added copyWith function
  MenuVariationTypes copyWith({
    int? sno,
    String? variationName,
    String? variationNameAr,
    int? branch,
    int? isLocked,
    int? status,
    int? isMultiChoice,
    int? isNoPrint,
    int? singleChoice,
    String? createdBy,
    String? createdAt,
    int? updatedBy,
    String? updatedAt,
    String? maxAllowQty,
    List<MenuItems>? menuItems,
  }) {
    return MenuVariationTypes(
      sno: sno ?? this.sno,
      variationName: variationName ?? this.variationName,
      variationNameAr: variationNameAr ?? this.variationNameAr,
      branch: branch ?? this.branch,
      status: status ?? this.status,
      isMultiChoice: isMultiChoice ?? this.isMultiChoice,
      isNoPrint: isNoPrint ?? this.isNoPrint,
      singleChoice: singleChoice ?? this.singleChoice,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      isLocked: isLocked ?? this.isLocked,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
      maxAllowQty: maxAllowQty ?? this.maxAllowQty,
      menuItems: menuItems ?? this.menuItems,
    );
  }
}

/// product_menu_variation_id : 629
/// product_menu_list_id : 1
/// master_product_id : 1627
/// item_id : 1
/// item_sale_price : 50
/// item_quantity : 1
/// item_unit_id : 21
/// item_total : 50
/// is_active : 1
/// is_default : 1
/// is_delete : 0
/// created_at : null
/// created_by : null
/// updated_at : null
/// updated_by : null
/// product : {"sno":1,"p_code":"","p_tax_code":null,"sub_itemof":0,"item_group":"0","p_cat_id":2,"p_name":"1-T.Excl","p_name_ar":"","slug":"1-T-Excl","p_reg_date":"2023-05-31","p_type":4,"unit_measure":21,"if_purchased":0,"unit_sale":0,"unit_purchase":0,"unit_shipping":0,"vendor_number":null,"purchase_description":"","sales_description":"حبة بروست/عادي","cost_price":0,"sale_price":50,"tax_type":0,"is_percentage":0,"taxable":1,"cogs_account":0,"income_account":6,"assets_account":0,"tax_account":0,"expense_account":0,"discount":null,"discount_start_at":null,"discount_end_at":null,"discount_account":0,"preferred_vendor":0,"reorder_point_min":0,"reorder_point_max":0,"assembly_specific":0,"client_sno":28,"company_sno":347,"user_sno":616,"product_photo":null,"gl_account":0,"bar_code":"10011","sku":"0","default_discount":"0","default_discount2":"0","default_tax":"0","default_tax2":"0","assembly_item_id":"","assembly_item_qty":"","assembly_item_unit":"","assembly_net_cost":0,"assembly_item_waste":"","pay_method":0,"item_image":null,"reporting_unit":0,"weight_unit":0,"p_status":1,"min_sale_price":0,"max_sale_price":0,"min_sale_qty":0,"max_sale_qty":0,"min_discount":"0","max_discount":"0","min_tax":"0","max_tax":"0","consumer_price":0,"is_bonus":0,"p_brand_id":0,"product_unit_label":0,"sellable":1,"p_branch_id":0,"opening_qty":0,"b_profile_id":1,"is_featured":0,"tax_inclusive":0,"product_tags":"","product_time":null,"available_online":1,"expiry_in_days":0,"short_description":"","long_description":"","shipping_weight":"0","product_volume":"0","admin_cost":0,"indirect_cost":0,"labor_cost":0,"machine_cost":0,"sales_cost":0,"other_cost":0,"bom_cost":0,"emp_id":1,"updated_at":"2025-05-15 06:54:12","variation_text":"","variation_id":"","attribute_id":"","parent_id":0,"lab_test_type":0,"hospital_type":0,"max_menu_items":"","out_of_stock":0,"unit_sales_quantity":0,"item_ordering":0,"salla_product_id":null,"salla_sale_price":0,"salla_cost_price":0,"salla_qty":0,"is_coupen_code_available":0}

class MenuItems  extends Equatable{

  @override
  List<Object?> get props => [productMenuVariationId, productMenuListId, product];
  MenuItems({
    this.productMenuVariationId,
    this.pName,
    this.description,
    this.productMenuListId,
    this.masterProductId,
    this.itemId,
    this.itemImage,
    this.itemSalePrice,
    this.itemQuantity,
    this.itemUnitId,
    this.itemTotal,
    this.isActive,
    this.isDefault,
    this.isDelete,
    this.createdAt,
    this.createdBy,
    this.salesDescription,
    this.updatedAt,
    this.updatedBy,
    this.selectedQuantity,
    this.product, this.selectedApi,
    this.isSelected=false,
  });

  MenuItems.fromJson(dynamic json) {
    productMenuVariationId = json['product_menu_variation_id'] is int
        ? json['product_menu_variation_id'] as int
        : int.tryParse('${json['product_menu_variation_id'] ?? 0}');
    productMenuListId = json['product_menu_list_id'] is int
        ? json['product_menu_list_id'] as int
        : int.tryParse('${json['product_menu_list_id'] ?? 0}');
    masterProductId = json['master_product_id'] is int
        ? json['master_product_id'] as int
        : int.tryParse('${json['master_product_id'] ?? 0}');
    itemId = json['item_id'] is int ? json['item_id'] as int : int.tryParse('${json['item_id'] ?? 0}');
    // Prices / qty can be int or double in API, keep them as num/dynamic
    itemSalePrice = json['item_sale_price'] ?? 0;
    salesDescription = json['sales_description'] ?? "";

    
    itemImage = json['item_image']?.toString()??"223";
    pName = json['p_name']?.toString();
    isDefault = json['is_default'] is int ? json['is_default'] as int : int.tryParse('${json['is_default'] ?? 0}');
    selectedApi = json['selected'] is int ? json['selected'] as int : int.tryParse('${json['selected'] ?? 0}');
    selectedQuantity =
        json['selected_qty'] is int ? json['selected_qty'] as int : int.tryParse('${json['selected_qty'] ?? 0}');
    itemQuantity = json['item_quantity'] ?? 0;
    product = json['main_product'] != null ? Product.fromJson(json['main_product']) : null;
  }

  int? productMenuVariationId;
  int? productMenuListId;
  int? masterProductId;
  int? selectedQuantity;
  String? itemImage;
  String? description;
  String? salesDescription;
  String? pName;
  int? itemId;
  int? selectedApi;
  var itemSalePrice;
  var itemQuantity;
  int? itemUnitId;
  var itemTotal;
  int? isActive;
  int? isDefault;
  int? isDelete;
  dynamic createdAt;
  dynamic createdBy;
  dynamic updatedAt;
  dynamic updatedBy;
  Product? product;
  bool? isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_menu_variation_id'] = productMenuVariationId;
    map['product_menu_list_id'] = productMenuListId;
    map['sales_description'] = salesDescription;
    map['p_name'] = pName;
    map['p_description'] = description;
    map['master_product_id'] = masterProductId;
    map['item_id'] = itemId;
    map['item_image'] = itemImage;
    map['item_sale_price'] = itemSalePrice;
    map['item_quantity'] = itemQuantity;
    map['item_unit_id'] = itemUnitId;
    map['item_total'] = itemTotal;
    map['is_active'] = isActive;
    map['is_default'] = isDefault;
    map['is_delete'] = isDelete;
    map['created_at'] = createdAt;
    map['created_by'] = createdBy;
    map['selected'] = selectedApi;
    map['selected_qty'] = selectedQuantity;
    map['updated_at'] = updatedAt;
    map['updated_by'] = updatedBy;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    return map;
  }

  MenuItems copyWith({
    int? productMenuVariationId,
    int? productMenuListId,
    int? masterProductId,
    String? pName,
    String? salesDescription,
    String? description,
    int? selectedApi,
    int? selectedQuantity,
    int? itemId,
    String? itemImage,
    dynamic itemSalePrice,
    dynamic itemQuantity,
    int? itemUnitId,
    dynamic itemTotal,
    int? isActive,
    int? isDefault,
    int? isDelete,
    dynamic createdAt,
    dynamic createdBy,
    dynamic updatedAt,
    dynamic updatedBy,
    Product? product,
    bool? isSelected,
  }) {
    return MenuItems(
      productMenuVariationId:
      productMenuVariationId ?? this.productMenuVariationId,  salesDescription:
    salesDescription ?? this.salesDescription,
      selectedQuantity: selectedQuantity ?? this.selectedQuantity,
      selectedApi: selectedApi ?? this.selectedApi,
      productMenuListId: productMenuListId ?? this.productMenuListId,
      pName: pName ?? this.pName,
      description: description ?? this.description,
      masterProductId: masterProductId ?? this.masterProductId,
      itemId: itemId ?? this.itemId,
      itemSalePrice: itemSalePrice ?? this.itemSalePrice,
      itemQuantity: itemQuantity ?? this.itemQuantity,itemImage: itemImage??this.itemImage,
      itemUnitId: itemUnitId ?? this.itemUnitId,
      itemTotal: itemTotal ?? this.itemTotal,
      isActive: isActive ?? this.isActive,
      isDefault: isDefault ?? this.isDefault,
      isDelete: isDelete ?? this.isDelete,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      product: product ?? this.product,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

/// sno : 1
/// p_code : ""
/// p_tax_code : null
/// sub_itemof : 0
/// item_group : "0"
/// p_cat_id : 2
/// p_name : "1-T.Excl"
/// p_name_ar : ""
/// slug : "1-T-Excl"
/// p_reg_date : "2023-05-31"
/// p_type : 4
/// unit_measure : 21
/// if_purchased : 0
/// unit_sale : 0
/// unit_purchase : 0
/// unit_shipping : 0
/// vendor_number : null
/// purchase_description : ""
/// sales_description : "حبة بروست/عادي"
/// cost_price : 0
/// sale_price : 50
/// tax_type : 0
/// is_percentage : 0
/// taxable : 1
/// cogs_account : 0
/// income_account : 6
/// assets_account : 0
/// tax_account : 0
/// expense_account : 0
/// discount : null
/// discount_start_at : null
/// discount_end_at : null
/// discount_account : 0
/// preferred_vendor : 0
/// reorder_point_min : 0
/// reorder_point_max : 0
/// assembly_specific : 0
/// client_sno : 28
/// company_sno : 347
/// user_sno : 616
/// product_photo : null
/// gl_account : 0
/// bar_code : "10011"
/// sku : "0"
/// default_discount : "0"
/// default_discount2 : "0"
/// default_tax : "0"
/// default_tax2 : "0"
/// assembly_item_id : ""
/// assembly_item_qty : ""
/// assembly_item_unit : ""
/// assembly_net_cost : 0
/// assembly_item_waste : ""
/// pay_method : 0
/// item_image : null
/// reporting_unit : 0
/// weight_unit : 0
/// p_status : 1
/// min_sale_price : 0
/// max_sale_price : 0
/// min_sale_qty : 0
/// max_sale_qty : 0
/// min_discount : "0"
/// max_discount : "0"
/// min_tax : "0"
/// max_tax : "0"
/// consumer_price : 0
/// is_bonus : 0
/// p_brand_id : 0
/// product_unit_label : 0
/// sellable : 1
/// p_branch_id : 0
/// opening_qty : 0
/// b_profile_id : 1
/// is_featured : 0
/// tax_inclusive : 0
/// product_tags : ""
/// product_time : null
/// available_online : 1
/// expiry_in_days : 0
/// short_description : ""
/// long_description : ""
/// shipping_weight : "0"
/// product_volume : "0"
/// admin_cost : 0
/// indirect_cost : 0
/// labor_cost : 0
/// machine_cost : 0
/// sales_cost : 0
/// other_cost : 0
/// bom_cost : 0
/// emp_id : 1
/// updated_at : "2025-05-15 06:54:12"
/// variation_text : ""
/// variation_id : ""
/// attribute_id : ""
/// parent_id : 0
/// lab_test_type : 0
/// hospital_type : 0
/// max_menu_items : ""
/// out_of_stock : 0
/// unit_sales_quantity : 0
/// item_ordering : 0
/// salla_product_id : null
/// salla_sale_price : 0
/// salla_cost_price : 0
/// salla_qty : 0
/// is_coupen_code_available : 0

class Product {
  Product({
    this.sno,
    this.stock,
    this.pCode,
    this.pTaxCode,
    this.subItemof,
    this.itemGroup,
    this.pCatId,
    this.pName,
    this.pNameAr,
    this.slug,
    this.pRegDate,
    this.pType,
    this.unitMeasure,
    this.ifPurchased,
    this.unitSale,
    this.unitPurchase,
    this.unitShipping,
    this.vendorNumber,
    this.purchaseDescription,
    this.salesDescription,
    this.costPrice,
    this.salePrice,
    this.taxType,
    this.isPercentage,
    this.taxable,
    this.cogsAccount,
    this.incomeAccount,
    this.assetsAccount,
    this.taxAccount,
    this.expenseAccount,
    this.discount,
    this.discountStartAt,
    this.discountEndAt,
    this.discountAccount,
    this.preferredVendor,
    this.reorderPointMin,
    this.reorderPointMax,
    this.assemblySpecific,
    this.clientSno,
    this.companySno,
    this.userSno,
    this.productPhoto,
    this.glAccount,
    this.barCode,
    this.sku,
    this.defaultDiscount,
    this.defaultDiscount2,
    this.defaultTax,
    this.defaultTax2,
    this.assemblyItemId,
    this.assemblyItemQty,
    this.assemblyItemUnit,
    this.assemblyNetCost,
    this.assemblyItemWaste,
    this.payMethod,
    this.itemImage,
    this.reportingUnit,
    this.weightUnit,
    this.pStatus,
    this.minSalePrice,
    this.maxSalePrice,
    this.minSaleQty,
    this.maxSaleQty,
    this.minDiscount,
    this.maxDiscount,
    this.minTax,
    this.maxTax,
    this.consumerPrice,
    this.isBonus,
    this.pBrandId,
    this.productUnitLabel,
    this.sellable,
    this.pBranchId,
    this.openingQty,
    this.bProfileId,
    this.isFeatured,
    this.taxInclusive,
    this.productTags,
    this.productTime,
    this.availableOnline,
    this.expiryInDays,
    this.shortDescription,
    this.longDescription,
    this.shippingWeight,
    this.productVolume,
    this.adminCost,
    this.indirectCost,
    this.laborCost,
    this.machineCost,
    this.salesCost,
    this.otherCost,
    this.bomCost,
    this.empId,
    this.updatedAt,
    this.variationText,
    this.variationId,
    this.attributeId,
    this.parentId,
    this.labTestType,
    this.hospitalType,
    this.maxMenuItems,
    this.outOfStock,
    this.unitSalesQuantity,
    this.itemOrdering,
    this.sallaProductId,
    this.sallaSalePrice,
    this.sallaCostPrice,
    this.sallaQty,
    this.isCoupenCodeAvailable,
    this.calculatedDiscount,
    this.calculatedTax,
    this.counterDiscount,
    this.quantitySelectedByUser=0,
  });

  Product.fromJson(dynamic json) {
    sno = json['sno'];
    pCode = json['p_code'];
    pTaxCode = json['p_tax_code'];
    subItemof = json['sub_itemof'];
    itemGroup = json['item_group'];
    pCatId = json['p_cat_id'];
    stock = json['stock'];
    pName = json['p_name'];
    pNameAr = json['p_name_ar'];
    // slug = json['slug'];
    // pRegDate = json['p_reg_date'];
    // pType = json['p_type'];
    // unitMeasure = json['unit_measure'];
    // ifPurchased = json['if_purchased'];
    // unitSale = json['unit_sale'];
    // unitPurchase = json['unit_purchase'];
    // unitShipping = json['unit_shipping'];
    // vendorNumber = json['vendor_number'];
    // purchaseDescription = json['purchase_description'];
    salesDescription = json['sales_description'];
    calculatedDiscount = json['calculated_discount'].toString();
    calculatedTax = json['calculated_tax'];
    counterDiscount = json['counter_discount'];
   
    costPrice = json['cost_price'];
    salePrice = json['sale_price'];
    taxType = json['tax_type'];
    isPercentage = json['is_percentage'];
    taxable = json['taxable'];
    // cogsAccount = json['cogs_account'];
    // incomeAccount = json['income_account'];
    // assetsAccount = json['assets_account'];
    // taxAccount = json['tax_account'];
    // expenseAccount = json['expense_account'];
    discount = json['discount'];
    // discountStartAt = json['discount_start_at'];
    // discountEndAt = json['discount_end_at'];
    // discountAccount = json['discount_account'];
    // preferredVendor = json['preferred_vendor'];
    // reorderPointMin = json['reorder_point_min'];
    // reorderPointMax = json['reorder_point_max'];
    // assemblySpecific = json['assembly_specific'];
    // clientSno = json['client_sno'];
    // companySno = json['company_sno'];
    // userSno = json['user_sno'];
    // productPhoto = json['product_photo'];
    // glAccount = json['gl_account'];
    // barCode = json['bar_code'];
    // sku = json['sku'];
    defaultDiscount = json['default_discount'];
    // defaultDiscount2 = json['default_discount2'];
    // defaultTax = json['default_tax'];
    // defaultTax2 = json['default_tax2'];
    // assemblyItemId = json['assembly_item_id'];
    // assemblyItemQty = json['assembly_item_qty'];
    // assemblyItemUnit = json['assembly_item_unit'];
    // assemblyNetCost = json['assembly_net_cost'];
    // assemblyItemWaste = json['assembly_item_waste'];
    // payMethod = json['pay_method'];
    itemImage = json['item_image'];
    // reportingUnit = json['reporting_unit'];
    // weightUnit = json['weight_unit'];
    // pStatus = json['p_status'];
    // minSalePrice = json['min_sale_price'];
    // maxSalePrice = json['max_sale_price'];
    // minSaleQty = json['min_sale_qty'];
    // maxSaleQty = json['max_sale_qty'];
    // minDiscount = json['min_discount'];
    // maxDiscount = json['max_discount'];
    // minTax = json['min_tax'];
    // maxTax = json['max_tax'];
    // consumerPrice = json['consumer_price'];
    // isBonus = json['is_bonus'];
    // pBrandId = json['p_brand_id'];
    // productUnitLabel = json['product_unit_label'];
    // sellable = json['sellable'];
    // pBranchId = json['p_branch_id'];
    // openingQty = json['opening_qty'];
    // bProfileId = json['b_profile_id'];
    // isFeatured = json['is_featured'];
    // taxInclusive = json['tax_inclusive'];
    // productTags = json['product_tags'];
    // productTime = json['product_time'];
    // availableOnline = json['available_online'];
    // expiryInDays = json['expiry_in_days'];
    // shortDescription = json['short_description'];
    // longDescription = json['long_description'];
    // shippingWeight = json['shipping_weight'];
    // productVolume = json['product_volume'];
    // adminCost = json['admin_cost'];
    // indirectCost = json['indirect_cost'];
    // laborCost = json['labor_cost'];
    // machineCost = json['machine_cost'];
    // salesCost = json['sales_cost'];
    // otherCost = json['other_cost'];
    // bomCost = json['bom_cost'];
    // empId = json['emp_id'];
    // updatedAt = json['updated_at'];
    variationText = json['variation_text'];
    variationId = json['variation_id'];
    attributeId = json['attribute_id'];
    parentId = json['parent_id'];
    labTestType = json['lab_test_type'];
    hospitalType = json['hospital_type'];
    maxMenuItems = json['max_menu_items'];
    outOfStock = json['out_of_stock'];
    //   unitSalesQuantity = json['unit_sales_quantity'];
    //   itemOrdering = json['item_ordering'];
    //   sallaProductId = json['salla_product_id'];
    //   sallaSalePrice = json['salla_sale_price'];
    //   sallaCostPrice = json['salla_cost_price'];
    //   sallaQty = json['salla_qty'];
    //   isCoupenCodeAvailable = json['is_coupen_code_available'];
  }

  int? sno;
  String? pCode;
  String ?calculatedDiscount;
  var counterDiscount;
  var calculatedTax;
  dynamic pTaxCode;
  int? subItemof;
  String? itemGroup;
  int? pCatId;
  String? pName;
  String? pNameAr;
  String? slug;
  String? pRegDate;
  int? stock;
  int? pType;
  int? unitMeasure;
  int? ifPurchased;
  int? unitSale;
  int? unitPurchase;
  int? unitShipping;
  dynamic vendorNumber;
  String? purchaseDescription;
  String? salesDescription;
  var costPrice;
  var salePrice;
  int? taxType;
  int? isPercentage;
  int? taxable;
  int? cogsAccount;
  int? incomeAccount;
  int? assetsAccount;
  int? taxAccount;
  int? expenseAccount;
  dynamic discount;
  dynamic discountStartAt;
  dynamic discountEndAt;
  int? discountAccount;
  int? preferredVendor;
  int? reorderPointMin;
  int? reorderPointMax;
  int? assemblySpecific;
  int? clientSno;
  int? companySno;
  int? userSno;
  dynamic productPhoto;
  int? glAccount;
  String? barCode;
  String? sku;
  String? defaultDiscount;
  String? defaultDiscount2;
  String? defaultTax;
  String? defaultTax2;
  String? assemblyItemId;
  String? assemblyItemQty;
  String? assemblyItemUnit;
  int? assemblyNetCost;
  String? assemblyItemWaste;
  int? payMethod;
  dynamic itemImage;
  int? reportingUnit;
  int? weightUnit;
  int? pStatus;
  int? minSalePrice;
  int? maxSalePrice;
  int? minSaleQty;
  int? maxSaleQty;
  String? minDiscount;
  String? maxDiscount;
  String? minTax;
  String? maxTax;
  int? consumerPrice;
  int? isBonus;
  int? pBrandId;
  int? productUnitLabel;
  int? sellable;
  int? pBranchId;
  int? openingQty;
  int? bProfileId;
  int? isFeatured;
  int? taxInclusive;
  String? productTags;
  dynamic productTime;
  int? availableOnline;
  int? expiryInDays;
  String? shortDescription;
  String? longDescription;
  String? shippingWeight;
  String? productVolume;
  int? adminCost;
  int? indirectCost;
  int? laborCost;
  int? machineCost;
  int? salesCost;
  int? otherCost;
  int? bomCost;
  int? empId;
  String? updatedAt;
  String? variationText;
  String? variationId;
  String? attributeId;
  int? parentId;
  int? labTestType;
  int? hospitalType;
  String? maxMenuItems;
  int? outOfStock;
  int? unitSalesQuantity;
  int? itemOrdering;
  dynamic sallaProductId;
  int? sallaSalePrice;
  int? sallaCostPrice;
  int? sallaQty;
  int? isCoupenCodeAvailable;
  int? quantitySelectedByUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['p_code'] = pCode;
    map['p_tax_code'] = pTaxCode;
    //map['calculated_tax'] = counterTax;
    map['counter_discount'] = counterDiscount;
    map['calculated_tax'] = calculatedTax;
    map['calculated_discount'] = calculatedDiscount;
    map['sub_itemof'] = subItemof;
    map['item_group'] = itemGroup;
    map['p_cat_id'] = pCatId;
    map['stock'] = stock;
    map['p_name'] = pName;
    map['p_name_ar'] = pNameAr;
    map['slug'] = slug;
    map['p_reg_date'] = pRegDate;
    map['p_type'] = pType;
    map['unit_measure'] = unitMeasure;
    map['if_purchased'] = ifPurchased;
    map['unit_sale'] = unitSale;
    map['unit_purchase'] = unitPurchase;
    map['unit_shipping'] = unitShipping;
    map['vendor_number'] = vendorNumber;
    map['purchase_description'] = purchaseDescription;
    map['sales_description'] = salesDescription;
    map['cost_price'] = costPrice;
    map['sale_price'] = salePrice;
    map['tax_type'] = taxType;
    map['is_percentage'] = isPercentage;
    map['taxable'] = taxable;
    map['cogs_account'] = cogsAccount;
    map['income_account'] = incomeAccount;
    map['assets_account'] = assetsAccount;
    map['tax_account'] = taxAccount;
    map['expense_account'] = expenseAccount;
    map['discount'] = discount;
    map['discount_start_at'] = discountStartAt;
    map['discount_end_at'] = discountEndAt;
    map['discount_account'] = discountAccount;
    map['preferred_vendor'] = preferredVendor;
    map['reorder_point_min'] = reorderPointMin;
    map['reorder_point_max'] = reorderPointMax;
    map['assembly_specific'] = assemblySpecific;
    map['client_sno'] = clientSno;
    map['company_sno'] = companySno;
    map['user_sno'] = userSno;
    map['product_photo'] = productPhoto;
    map['gl_account'] = glAccount;
    map['bar_code'] = barCode;
    map['sku'] = sku;
    map['default_discount'] = defaultDiscount;
    map['default_discount2'] = defaultDiscount2;
    map['default_tax'] = defaultTax;
    map['default_tax2'] = defaultTax2;
    map['assembly_item_id'] = assemblyItemId;
    map['assembly_item_qty'] = assemblyItemQty;
    map['assembly_item_unit'] = assemblyItemUnit;
    map['assembly_net_cost'] = assemblyNetCost;
    map['assembly_item_waste'] = assemblyItemWaste;
    map['pay_method'] = payMethod;
    map['item_image'] = itemImage;
    map['reporting_unit'] = reportingUnit;
    map['weight_unit'] = weightUnit;
    map['p_status'] = pStatus;
    map['min_sale_price'] = minSalePrice;
    map['max_sale_price'] = maxSalePrice;
    map['min_sale_qty'] = minSaleQty;
    map['max_sale_qty'] = maxSaleQty;
    map['min_discount'] = minDiscount;
    map['max_discount'] = maxDiscount;
    map['min_tax'] = minTax;
    map['max_tax'] = maxTax;
    map['consumer_price'] = consumerPrice;
    map['is_bonus'] = isBonus;
    map['p_brand_id'] = pBrandId;
    map['product_unit_label'] = productUnitLabel;
    map['sellable'] = sellable;
    map['p_branch_id'] = pBranchId;
    map['opening_qty'] = openingQty;
    map['b_profile_id'] = bProfileId;
    map['is_featured'] = isFeatured;
    map['tax_inclusive'] = taxInclusive;
    map['product_tags'] = productTags;
    map['product_time'] = productTime;
    map['available_online'] = availableOnline;
    map['expiry_in_days'] = expiryInDays;
    map['short_description'] = shortDescription;
    map['long_description'] = longDescription;
    map['shipping_weight'] = shippingWeight;
    map['product_volume'] = productVolume;
    map['admin_cost'] = adminCost;
    map['indirect_cost'] = indirectCost;
    map['labor_cost'] = laborCost;
    map['machine_cost'] = machineCost;
    map['sales_cost'] = salesCost;
    map['other_cost'] = otherCost;
    map['bom_cost'] = bomCost;
    map['emp_id'] = empId;
    map['updated_at'] = updatedAt;
    map['variation_text'] = variationText;
    map['variation_id'] = variationId;
    map['attribute_id'] = attributeId;
    map['parent_id'] = parentId;
    map['lab_test_type'] = labTestType;
    map['hospital_type'] = hospitalType;
    map['max_menu_items'] = maxMenuItems;
    map['out_of_stock'] = outOfStock;
    map['unit_sales_quantity'] = unitSalesQuantity;
    map['item_ordering'] = itemOrdering;
    map['salla_product_id'] = sallaProductId;
    map['salla_sale_price'] = sallaSalePrice;
    map['salla_cost_price'] = sallaCostPrice;
    map['salla_qty'] = sallaQty;
    map['is_coupen_code_available'] = isCoupenCodeAvailable;
    return map;
  }

  Product copyWith({
    int? sno,
    String? pCode,
    dynamic pTaxCode,
    int? subItemof,
    var counterDiscount,
    String? calculatedDiscount,
    var calculatedTax,
    String? itemGroup,
    int? pCatId,
    String? pName,
    String? pNameAr,
    String? slug,
    String? pRegDate,
    int? pType,
    int? unitMeasure,
    int? ifPurchased,
    int? unitSale,
    int? unitPurchase,
    int? unitShipping,
    dynamic vendorNumber,
    String? purchaseDescription,
    String? salesDescription,
    var costPrice,
    var salePrice,
    int? taxType,
    int? isPercentage,
    int? taxable,
    int? cogsAccount,
    int? incomeAccount,
    int? assetsAccount,
    int? taxAccount,
    int? expenseAccount,
    dynamic discount,
    dynamic discountStartAt,
    dynamic discountEndAt,
    int? discountAccount,
    int? preferredVendor,
    int? reorderPointMin,
    int? reorderPointMax,
    int? assemblySpecific,
    int? clientSno,
    int? companySno,
    int? userSno,
    dynamic productPhoto,
    int? glAccount,
    String? barCode,
    String? sku,
    String? defaultDiscount,
    String? defaultDiscount2,
    String? defaultTax,
    String? defaultTax2,
    String? assemblyItemId,
    String? assemblyItemQty,
    String? assemblyItemUnit,
    int? assemblyNetCost,
    String? assemblyItemWaste,
    int? payMethod,
    dynamic itemImage,
    int? reportingUnit,
    int? weightUnit,
    int? pStatus,
    int? minSalePrice,
    int? maxSalePrice,
    int? minSaleQty,
    int? maxSaleQty,
    String? minDiscount,
    String? maxDiscount,
    String? minTax,
    String? maxTax,
    int? consumerPrice,
    int? isBonus,
    int? pBrandId,
    int? productUnitLabel,
    int? sellable,
    int? pBranchId,
    int? openingQty,
    int? bProfileId,
    int? isFeatured,
    int? taxInclusive,
    String? productTags,
    dynamic productTime,
    int? availableOnline,
    int? expiryInDays,
    String? shortDescription,
    String? longDescription,
    String? shippingWeight,
    String? productVolume,
    int? adminCost,
    int? indirectCost,
    int? laborCost,
    int? machineCost,
    int? salesCost,
    int? otherCost,
    int? bomCost,
    int? empId,
    String? updatedAt,
    String? variationText,
    String? variationId,
    String? attributeId,
    int? parentId,
    int? labTestType,
    int? hospitalType,
    String? maxMenuItems,
    int? outOfStock,
    int? unitSalesQuantity,
    int? itemOrdering,
    dynamic sallaProductId,
    int? sallaSalePrice,
    int? sallaCostPrice,
    int? sallaQty,
    int? isCoupenCodeAvailable,
    int? quantitySelectedByUser,
  }) {
    return Product(
      sno: sno ?? this.sno,
      pCode: pCode ?? this.pCode,
      pTaxCode: pTaxCode ?? this.pTaxCode,
      subItemof: subItemof ?? this.subItemof,
      itemGroup: itemGroup ?? this.itemGroup,
      pCatId: pCatId ?? this.pCatId,
      pName: pName ?? this.pName,
      pNameAr: pNameAr ?? this.pNameAr,
      slug: slug ?? this.slug,
      pRegDate: pRegDate ?? this.pRegDate,
      pType: pType ?? this.pType,
      unitMeasure: unitMeasure ?? this.unitMeasure,
      ifPurchased: ifPurchased ?? this.ifPurchased,
      unitSale: unitSale ?? this.unitSale,
      unitPurchase: unitPurchase ?? this.unitPurchase,
      unitShipping: unitShipping ?? this.unitShipping,
      vendorNumber: vendorNumber ?? this.vendorNumber,
      purchaseDescription: purchaseDescription ?? this.purchaseDescription,
      salesDescription: salesDescription ?? this.salesDescription,
      costPrice: costPrice ?? this.costPrice,
      counterDiscount: counterDiscount ?? this.counterDiscount,
      calculatedTax: calculatedTax ?? this.calculatedTax,
      calculatedDiscount: calculatedDiscount ?? this.calculatedDiscount,
      salePrice: salePrice ?? this.salePrice,
      taxType: taxType ?? this.taxType,
      isPercentage: isPercentage ?? this.isPercentage,
      taxable: taxable ?? this.taxable,
      cogsAccount: cogsAccount ?? this.cogsAccount,
      incomeAccount: incomeAccount ?? this.incomeAccount,
      assetsAccount: assetsAccount ?? this.assetsAccount,
      taxAccount: taxAccount ?? this.taxAccount,
      expenseAccount: expenseAccount ?? this.expenseAccount,
      discount: discount ?? this.discount,
      discountStartAt: discountStartAt ?? this.discountStartAt,
      discountEndAt: discountEndAt ?? this.discountEndAt,
      discountAccount: discountAccount ?? this.discountAccount,
      preferredVendor: preferredVendor ?? this.preferredVendor,
      reorderPointMin: reorderPointMin ?? this.reorderPointMin,
      reorderPointMax: reorderPointMax ?? this.reorderPointMax,
      assemblySpecific: assemblySpecific ?? this.assemblySpecific,
      clientSno: clientSno ?? this.clientSno,
      companySno: companySno ?? this.companySno,
      userSno: userSno ?? this.userSno,
      productPhoto: productPhoto ?? this.productPhoto,
      glAccount: glAccount ?? this.glAccount,
      barCode: barCode ?? this.barCode,
      sku: sku ?? this.sku,
      defaultDiscount: defaultDiscount ?? this.defaultDiscount,
      defaultDiscount2: defaultDiscount2 ?? this.defaultDiscount2,
      defaultTax: defaultTax ?? this.defaultTax,
      defaultTax2: defaultTax2 ?? this.defaultTax2,
      assemblyItemId: assemblyItemId ?? this.assemblyItemId,
      assemblyItemQty: assemblyItemQty ?? this.assemblyItemQty,
      assemblyItemUnit: assemblyItemUnit ?? this.assemblyItemUnit,
      assemblyNetCost: assemblyNetCost ?? this.assemblyNetCost,
      assemblyItemWaste: assemblyItemWaste ?? this.assemblyItemWaste,
      payMethod: payMethod ?? this.payMethod,
      itemImage: itemImage ?? this.itemImage,
      reportingUnit: reportingUnit ?? this.reportingUnit,
      weightUnit: weightUnit ?? this.weightUnit,
      pStatus: pStatus ?? this.pStatus,
      minSalePrice: minSalePrice ?? this.minSalePrice,
      maxSalePrice: maxSalePrice ?? this.maxSalePrice,
      minSaleQty: minSaleQty ?? this.minSaleQty,
      maxSaleQty: maxSaleQty ?? this.maxSaleQty,
      minDiscount: minDiscount ?? this.minDiscount,
      maxDiscount: maxDiscount ?? this.maxDiscount,
      minTax: minTax ?? this.minTax,
      maxTax: maxTax ?? this.maxTax,
      consumerPrice: consumerPrice ?? this.consumerPrice,
      isBonus: isBonus ?? this.isBonus,
      pBrandId: pBrandId ?? this.pBrandId,
      productUnitLabel: productUnitLabel ?? this.productUnitLabel,
      sellable: sellable ?? this.sellable,
      pBranchId: pBranchId ?? this.pBranchId,
      openingQty: openingQty ?? this.openingQty,
      bProfileId: bProfileId ?? this.bProfileId,
      isFeatured: isFeatured ?? this.isFeatured,
      taxInclusive: taxInclusive ?? this.taxInclusive,
      productTags: productTags ?? this.productTags,
      productTime: productTime ?? this.productTime,
      availableOnline: availableOnline ?? this.availableOnline,
      expiryInDays: expiryInDays ?? this.expiryInDays,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      shippingWeight: shippingWeight ?? this.shippingWeight,
      productVolume: productVolume ?? this.productVolume,
      adminCost: adminCost ?? this.adminCost,
      indirectCost: indirectCost ?? this.indirectCost,
      laborCost: laborCost ?? this.laborCost,
      machineCost: machineCost ?? this.machineCost,
      salesCost: salesCost ?? this.salesCost,
      otherCost: otherCost ?? this.otherCost,
      bomCost: bomCost ?? this.bomCost,
      empId: empId ?? this.empId,
      updatedAt: updatedAt ?? this.updatedAt,
      variationText: variationText ?? this.variationText,
      variationId: variationId ?? this.variationId,
      attributeId: attributeId ?? this.attributeId,
      parentId: parentId ?? this.parentId,
      labTestType: labTestType ?? this.labTestType,
      hospitalType: hospitalType ?? this.hospitalType,
      maxMenuItems: maxMenuItems ?? this.maxMenuItems,
      outOfStock: outOfStock ?? this.outOfStock,
      unitSalesQuantity: unitSalesQuantity ?? this.unitSalesQuantity,
      itemOrdering: itemOrdering ?? this.itemOrdering,
      sallaProductId: sallaProductId ?? this.sallaProductId,
      sallaSalePrice: sallaSalePrice ?? this.sallaSalePrice,
      sallaCostPrice: sallaCostPrice ?? this.sallaCostPrice,
      sallaQty: sallaQty ?? this.sallaQty,
      isCoupenCodeAvailable: isCoupenCodeAvailable ?? this.isCoupenCodeAvailable,
      quantitySelectedByUser:
      quantitySelectedByUser ?? this.quantitySelectedByUser,
    );
  }
}
