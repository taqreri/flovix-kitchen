import 'package:equatable/equatable.dart';
import 'package:flovix_kitchen/model/pdf_files/Printer_model.dart' show PrinterModel;
import 'package:flovix_kitchen/model/pos/cart/product_model/Uom_model.dart';
import 'package:flovix_kitchen/model/pos/cart/product_model/single_product_model/product_menu_exclusions.dart';

import 'menu_variation_types.dart';

class SingleProductModel extends Equatable {
  SingleProductModel({
    this.sno,
    this.pCode,
    this.productMenuExclusions,
    this.pTaxCode,
    this.subItemof,
    this.itemGroup,

    this.pCatId,
    this.uomList,
    this.pName,
    //this.sellable,
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
    this.menuVariationTypes,
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
    // this.hms,
    // this.slabs,
    // this.barcodes,
    this.productMenuVariations,
    this.variationData,
    this.singleProductVariations,
    this.totalDiscount = 0.0,
    this.totalAmount = 0.0,
  });

  SingleProductModel.fromJson(dynamic json) {
    sno = json['sno'];
    sellable =json['sellable']??0;
   // pCode = json['p_code'];
    unitMeasure = json['unit_id'] ?? json['unit_measure'] ?? 0;
    itemImage = json['item_image'];
    pName = json['p_name'];
    pNameAr = json['p_name_ar'];
    pType = json['p_type'];
    product_tags = json['product_tags'];
   // unitMeasure = json['unit_measure'];
    salesDescription = json['sales_description'];
    printerModel =json['printer'] != null ? PrinterModel.fromJson(json['printer']) : null ;
    // pTaxCode = json['p_tax_code'];
    // subItemof = json['sub_itemof'];
    // itemGroup = json['item_group'];
    // pCatId = json['p_cat_id'];

    // slug = json['slug'];
    // pRegDate = json['p_reg_date'];
    pType = json['p_type'];

    // ifPurchased = json['if_purchased'];
     unitSale = json['unit_sale'];
    // unitPurchase = json['unit_purchase'];
    // unitShipping = json['unit_shipping'];
    // vendorNumber = json['vendor_number'];
    // purchaseDescription = json['purchase_description'];
    salesDescription = json['sales_description'];
    costPrice = json['cost_price'];
    salePrice = json['sale_price'];
    isPercentage = json['is_percentage'];
    taxable = json['taxable'];
   taxInclusive = json['tax_inclusive'];
    defaultDiscount = json['default_discount'];

    // taxType = json['tax_type'];

    // cogsAccount = json['cogs_account'];
    // incomeAccount = json['income_account'];
    // assetsAccount = json['assets_account'];
    // taxAccount = json['tax_account'];
    // expenseAccount = json['expense_account'];
    // discount = json['discount'];
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
    //
    // defaultDiscount2 = json['default_discount2'];
    // defaultTax = json['default_tax'];
    // defaultTax2 = json['default_tax2'];
    // assemblyItemId = json['assembly_item_id'];
    // assemblyItemQty = json['assembly_item_qty'];
    // assemblyItemUnit = json['assembly_item_unit'];
    // assemblyNetCost = json['assembly_net_cost'];
    // assemblyItemWaste = json['assembly_item_waste'];
    // payMethod = json['pay_method'];
    // ;
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
     sellable = json['sellable'];
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
    // variationText = json['variation_text'];
    // variationId = json['variation_id'];
    // attributeId = json['attribute_id'];
    // parentId = json['parent_id'];
    // labTestType = json['lab_test_type'];
    // hospitalType = json['hospital_type'];
    // maxMenuItems = json['max_menu_items'];
    // outOfStock = json['out_of_stock'];
    // unitSalesQuantity = json['unit_sales_quantity'];
    // itemOrdering = json['item_ordering'];
    // sallaProductId = json['salla_product_id'];
    // sallaSalePrice = json['salla_sale_price'];
    // sallaCostPrice = json['salla_cost_price'];
    // sallaQty = json['salla_qty'];
    // isCoupenCodeAvailable = json['is_coupen_code_available'];

    if (json['variations'] != null) {
      singleProductVariations = [];
      json['variations'].forEach((v) {
        singleProductVariations?.add(SingleProductVariations.fromJson(v));
      });
    }
    if (json['uom_list'] != null) {
      uomList = [];
      json['uom_list'].forEach((v) {
        uomList?.add(UomModel.fromJson(v));
      });
    }
    if (json['productMenuExclusions'] != null) {
      productMenuExclusions = [];
      json['productMenuExclusions'].forEach((v) {
        productMenuExclusions?.add(ProductMenuExclusions.fromJson(v));
      });
    }
    if (json['menu_variation_types'] != null) {
      menuVariationTypes = [];
      json['menu_variation_types'].forEach((v) {
        menuVariationTypes?.add(MenuVariationTypes.fromJson(v));
      });
    }
  }

  double totalAmount = 0.0;
  double totalDiscount = 0.0;

  int? sellable;
  int? sno;
  String? pCode;
  dynamic pTaxCode;
  int? subItemof;  List<UomModel>? uomList;
  String? itemGroup;
  String? product_tags;
  int? pCatId;
  String? pName;
  PrinterModel? printerModel;
  String? pNameAr;
  String? slug;
  String? pRegDate;
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
  var reorderPointMin;
  var reorderPointMax;
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
  String? itemImage;
  int? reportingUnit;
  int? weightUnit;
  int? pStatus;
  var minSalePrice;
  var maxSalePrice;
  var minSaleQty;
  int? maxSaleQty;
  String? minDiscount;
  String? maxDiscount;
  String? minTax;
  String? maxTax;
  var consumerPrice;
  int? isBonus;
  int? pBrandId;
  int? productUnitLabel;

  int? pBranchId;
  int? openingQty;
  int? bProfileId;
  int? isFeatured;
  int? taxInclusive;
  String? productTags;
  String? productTime;
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
  var sallaSalePrice;
  var sallaCostPrice;
  var sallaQty;
  int? isCoupenCodeAvailable;

/*  List<dynamic>? hms;
  List<dynamic>? slabs;
  List<dynamic>? barcodes;***/
  List<dynamic>? productMenuVariations;
  List<VariationData>? variationData;

  List<SingleProductVariations>? singleProductVariations;
  List<ProductMenuExclusions>? productMenuExclusions;
  List<MenuVariationTypes>? menuVariationTypes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['sellable'] = sellable;
    map['p_code'] = pCode;
    map['p_tax_code'] = pTaxCode;
    map['sub_itemof'] = subItemof;
    map['item_group'] = itemGroup;
    map['p_cat_id'] = pCatId;
    map['p_name'] = pName;
    map['p_name_ar'] = pNameAr;
    map['slug'] = slug;
    map['p_reg_date'] = pRegDate;
    map['p_type'] = pType;
    map['unit_id'] = unitMeasure;
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
    /*if (hms != null) {
      map['hms'] = hms?.map((v) => v.toJson()).toList();
    }
    if (slabs != null) {
      map['slabs'] = slabs?.map((v) => v.toJson()).toList();
    }
    if (barcodes != null) {
      map['barcodes'] = barcodes?.map((v) => v.toJson()).toList();
    }***/
    if (productMenuVariations != null) {
      map['productMenuVariations'] =
          productMenuVariations?.map((v) => v.toJson()).toList();
    }
    if (variationData != null) {
      map['variationData'] = variationData?.map((v) => v.toJson()).toList();
    }
    if (productMenuExclusions != null) {
      map['productMenuExclusions'] =
          productMenuExclusions?.map((v) => v.toJson()).toList();
    }
    if (singleProductVariations != null) {
      map['variations'] =
          singleProductVariations?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  SingleProductModel copyWith({
    double? totalAmount,
    double? totalDiscount,
    int? sno,
    String? pCode,
    dynamic pTaxCode,
    int? subItemof,
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
    dynamic costPrice,
    dynamic salePrice,
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
    dynamic reorderPointMin,
    dynamic reorderPointMax,
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
    String? itemImage,
    int? reportingUnit,
    int? weightUnit,
    int? pStatus,
    dynamic minSalePrice,
    dynamic maxSalePrice,
    dynamic minSaleQty,
    int? maxSaleQty,
    String? minDiscount,
    String? maxDiscount,
    String? minTax,
    String? maxTax,
    dynamic consumerPrice,
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
    String? productTime,
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
    dynamic sallaSalePrice,
    dynamic sallaCostPrice,
    dynamic sallaQty,
    int? isCoupenCodeAvailable,
    List<dynamic>? productMenuVariations,
    List<VariationData>? variationData,
    List<SingleProductVariations>? singleProductVariations,
    List<ProductMenuExclusions>? productMenuExclusions,
    List<MenuVariationTypes>? menuVariationTypes,
  }) {
    return SingleProductModel(
      sno: sno ?? this.sno,
      pCode: pCode ?? this.pCode,
      pTaxCode: pTaxCode ?? this.pTaxCode,
      subItemof: subItemof ?? this.subItemof,
      itemGroup: itemGroup ?? this.itemGroup,
      pCatId: pCatId ?? this.pCatId,
      pName: pName ?? this.pName,
      totalAmount: totalAmount ?? this.totalAmount,
      totalDiscount: totalDiscount ?? this.totalDiscount,
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
      isCoupenCodeAvailable:
          isCoupenCodeAvailable ?? this.isCoupenCodeAvailable,
      productMenuVariations:
          productMenuVariations ?? this.productMenuVariations,
      variationData: variationData ?? this.variationData,
      singleProductVariations:
          singleProductVariations ?? this.singleProductVariations,
      productMenuExclusions:
          productMenuExclusions ?? this.productMenuExclusions,
      menuVariationTypes: menuVariationTypes ?? this.menuVariationTypes,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        sno,
        pCode,
        productMenuExclusions,
        pTaxCode,
        subItemof,
        itemGroup,
        pCatId,
        pName,
        pNameAr,
        slug,
        pRegDate,
        pType,
        unitMeasure,
        ifPurchased,
        unitSale,
        unitPurchase,
        unitShipping,
        vendorNumber,
        purchaseDescription,
        salesDescription,
        costPrice,
        salePrice,
        taxType,
        isPercentage,
        taxable,
        cogsAccount,
        incomeAccount,
        assetsAccount,
        taxAccount,
        expenseAccount,
        discount,
        discountStartAt,
        discountEndAt,
        discountAccount,
        preferredVendor,
        reorderPointMin,
        reorderPointMax,
        assemblySpecific,
        clientSno,
        companySno,
        userSno,
        productPhoto,
        glAccount,
        barCode,
        sku,
        defaultDiscount,
        defaultDiscount2,
        defaultTax,
        defaultTax2,
        assemblyItemId,
        assemblyItemQty,
        assemblyItemUnit,
        assemblyNetCost,
        assemblyItemWaste,
        payMethod,
        itemImage,
        reportingUnit,
        weightUnit,
        pStatus,
        minSalePrice,
        maxSalePrice,
        minSaleQty,
        maxSaleQty,
        minDiscount,
        maxDiscount,
        minTax,
        maxTax,
        consumerPrice,
        isBonus,
        pBrandId,
        productUnitLabel,
        sellable,
        pBranchId,
        openingQty,
        bProfileId,
        isFeatured,
        taxInclusive,
        productTags,
        productTime,
        availableOnline,
        expiryInDays,
        shortDescription,
        longDescription,
        shippingWeight,
        productVolume,
        menuVariationTypes,
        adminCost,
        indirectCost,
        laborCost,
        machineCost,
        salesCost,
        otherCost,
        bomCost,
        empId,
        updatedAt,
        variationText,
        variationId,
        attributeId,
        parentId,
        labTestType,
        hospitalType,
        maxMenuItems,
        outOfStock,
        unitSalesQuantity,
        itemOrdering,
        sallaProductId,
        sallaSalePrice,
        sallaCostPrice,
        sallaQty,
        isCoupenCodeAvailable,
        // hms,
        // slabs,
        // barcodes,
        productMenuVariations,
        variationData,
        singleProductVariations,
        totalDiscount,
        totalAmount,
      ];
}

/// sno : 1629
/// p_code : ""
/// p_tax_code : null
/// sub_itemof : 0
/// item_group : "0"
/// p_cat_id : 10
/// p_name : "New veriation test product   red  small "
/// p_name_ar : ""
/// slug : "New-veriation-test-product-"
/// p_reg_date : "2025-09-04"
/// p_type : 4
/// unit_measure : 21
/// if_purchased : 0
/// unit_sale : 0
/// unit_purchase : 0
/// unit_shipping : 0
/// vendor_number : null
/// purchase_description : ""
/// sales_description : ""
/// cost_price : 10
/// sale_price : 20
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
/// bar_code : "4507291619332"
/// sku : ""
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
/// item_image : "1userdb250911060322pm68c2e4ba6d5ad.png"
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
/// product_time : "0"
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
/// updated_at : "2025-09-11 18:03:22"
/// variation_text : " red  small "
/// variation_id : "0"
/// attribute_id : "1,3"
/// parent_id : 1628
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

class SingleProductVariations {
  SingleProductVariations({
    this.sno,
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
    this.stock,
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
    this.uomList,
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
  });

  SingleProductVariations.fromJson(dynamic json) {
    sno = json['sno'];
    stock = json['stock'];
  //  pCode = json['p_code'];
   // pTaxCode = json['p_tax_code'];
  //  subItemof = json['sub_itemof'];
    itemGroup = json['item_group'];
  //  pCatId = json['p_cat_id'];
    pName = json['p_name'];
    pNameAr = json['p_name_ar'];
 //   slug = json['slug'];
   // pRegDate = json['p_reg_date'];
    pType = json['p_type'];
    unitMeasure = json['unit_id'] ?? json['unit_measure'] ?? 0;
   // ifPurchased = json['if_purchased'];
   // unitSale = json['unit_sale'];
  // unitPurchase = json['unit_purchase'];
  //  unitShipping = json['unit_shipping'];
   // vendorNumber = json['vendor_number'];
   // purchaseDescription = json['purchase_description'];
    salesDescription = json['sales_description'];
    costPrice = json['cost_price'];
    salePrice = json['sale_price'];
    taxType = json['tax_type'];
    isPercentage = json['is_percentage'];
    taxable = json['taxable'];
   // cogsAccount = json['cogs_account'];
  //  incomeAccount = json['income_account'];
   // assetsAccount = json['assets_account'];
  //  taxAccount = json['tax_account'];
   // expenseAccount = json['expense_account'];
    discount = json['discount'];
    if (json['uom_list'] != null) {
      uomList = [];
      json['uom_list'].forEach((v) {
        uomList?.add(UomModel.fromJson(v));
      });
    }
   // discountStartAt = json['discount_start_at'];
   // discountEndAt = json['discount_end_at'];
   // discountAccount = json['discount_account'];
   // preferredVendor = json['preferred_vendor'];
   // reorderPointMin = json['reorder_point_min'];
   // reorderPointMax = json['reorder_point_max'];
 //   assemblySpecific = json['assembly_specific'];
   // clientSno = json['client_sno'];
  //  companySno = json['company_sno'];
  //  userSno = json['user_sno'];
   // productPhoto = json['product_photo'];
   // glAccount = json['gl_account'];
    barCode = json['bar_code'];
    sku = json['sku'];
    defaultDiscount = json['default_discount'];
    //defaultDiscount2 = json['default_discount2'];
  //  defaultTax = json['default_tax'];
   // defaultTax2 = json['default_tax2'];
  // assemblyItemId = json['assembly_item_id'];
  //  assemblyItemQty = json['assembly_item_qty'];
 //   assemblyItemUnit = json['assembly_item_unit'];
 //   assemblyNetCost = json['assembly_net_cost'];
   // assemblyItemWaste = json['assembly_item_waste'];
  //  payMethod = json['pay_method'];
    itemImage = json['item_image'];
  //  reportingUnit = json['reporting_unit'];
 //   weightUnit = json['weight_unit'];
 //   pStatus = json['p_status'];
 //   minSalePrice = json['min_sale_price'];
  //  maxSalePrice = json['max_sale_price'];
  //  minSaleQty = json['min_sale_qty'];
  //  maxSaleQty = json['max_sale_qty'];
 //   minDiscount = json['min_discount'];
 //   maxDiscount = json['max_discount'];
   // minTax = json['min_tax'];
 //   maxTax = json['max_tax'];
   // consumerPrice = json['consumer_price'];
  //  isBonus = json['is_bonus'];
  //  pBrandId = json['p_brand_id'];
  //  productUnitLabel = json['product_unit_label'];
    sellable = json['sellable'];
 //   pBranchId = json['p_branch_id'];
 //   openingQty = json['opening_qty'];
  //  bProfileId = json['b_profile_id'];
   // isFeatured = json['is_featured'];
  taxInclusive = json['tax_inclusive'];
  //  productTags = json['product_tags'];
  //  productTime = json['product_time'];
  //  availableOnline = json['available_online'];
    //expiryInDays = json['expiry_in_days'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
   // shippingWeight = json['shipping_weight'];
  //  productVolume = json['product_volume'];
  //  adminCost = json['admin_cost'];
  //  indirectCost = json['indirect_cost'];
   // laborCost = json['labor_cost'];
  //  machineCost = json['machine_cost'];
  //  salesCost = json['sales_cost'];
  //  otherCost = json['other_cost'];
 //   bomCost = json['bom_cost'];
 //   empId = json['emp_id'];
    updatedAt = json['updated_at'];
 //   variationText = json['variation_text'];
   variationId = json['variation_id'];
//    attributeId = json['attribute_id'];
    parentId = json['parent_id'];
  //  labTestType = json['lab_test_type'];
  //  hospitalType = json['hospital_type'];
  //  maxMenuItems = json['max_menu_items'];
    outOfStock = json['out_of_stock'];
    unitSalesQuantity = json['unit_sales_quantity'];
  //  itemOrdering = json['item_ordering'];
   // sallaProductId = json['salla_product_id'];
  //  sallaSalePrice = json['salla_sale_price'];
  //  sallaCostPrice = json['salla_cost_price'];
   // sallaQty = json['salla_qty'];
    isCoupenCodeAvailable = json['is_coupen_code_available'];
  }

  int? sno;
  String? pCode;
  dynamic pTaxCode;
  int? subItemof;
  int? stock;
  String? itemGroup;
  int? pCatId;
  String? pName;
  String? pNameAr;
  String? slug;
  String? pRegDate;
  int? pType;
  int ?unitMeasure;
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
  int? taxable;  List<UomModel>? uomList;
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
  String? itemImage;
  int? reportingUnit;
  int? weightUnit;
  int? pStatus;
  var minSalePrice;
  var maxSalePrice;
  var minSaleQty;
  var maxSaleQty;
  String? minDiscount;
  String? maxDiscount;
  String? minTax;
  String? maxTax;
  var consumerPrice;
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
  String? productTime;
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
  var sallaSalePrice;
  var sallaCostPrice;
  var sallaQty;
  int? isCoupenCodeAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['p_code'] = pCode;
    map['p_tax_code'] = pTaxCode;
    map['sub_itemof'] = subItemof;
    map['item_group'] = itemGroup;
    map['p_cat_id'] = pCatId;
    map['p_name'] = pName;
    map['stock'] = stock;
    map['p_name_ar'] = pNameAr;
    map['slug'] = slug;
    map['p_reg_date'] = pRegDate;
    map['p_type'] = pType;
    map['unit_id'] = unitMeasure;
    map['if_purchased'] = ifPurchased;
    map['unit_sale'] = unitSale;   if (uomList != null) {
      map['uom_list'] = uomList?.map((v) => v.toJson()).toList();
    }
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
}

/// id : 3
/// var_name : "color"
/// var_name_ar : "لون"
/// branch_id : 0
/// variables : "red,yellow,porple"
/// created_by : 1
/// updated_by : 1
/// created_at : "2023-08-16 10:32:11"
/// updated_at : "2023-12-16 14:50:35"
/// status : 1
/// salla_id : null
/// attributes : [{"id":1,"name_en":"red","name_ar":"أحمر","product_variations_id":3,"status":1,"salla_id":null},{"id":2,"name_en":"black","name_ar":"أسود","product_variations_id":3,"status":1,"salla_id":null},{"id":12,"name_en":"white","name_ar":"white","product_variations_id":3,"status":1,"salla_id":null}]

class VariationData {
  VariationData({
    this.id,
    this.varName,
    this.varNameAr,
    this.branchId,
    this.variables,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.sallaId,
    this.attributes,
  });

  VariationData.fromJson(dynamic json) {
    id = json['id'];
    varName = json['var_name'];
    varNameAr = json['var_name_ar'];
    branchId = json['branch_id'];
    variables = json['variables'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    sallaId = json['salla_id'];
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add(Attributes.fromJson(v));
      });
    }
  }

  int? id;
  String? varName;
  String? varNameAr;
  int? branchId;
  String? variables;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? status;
  dynamic sallaId;
  List<Attributes>? attributes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['var_name'] = varName;
    map['var_name_ar'] = varNameAr;
    map['branch_id'] = branchId;
    map['variables'] = variables;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['status'] = status;
    map['salla_id'] = sallaId;
    if (attributes != null) {
      map['attributes'] = attributes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name_en : "red"
/// name_ar : "أحمر"
/// product_variations_id : 3
/// status : 1
/// salla_id : null

class Attributes {
  Attributes({
    this.id,
    this.nameEn,
    this.nameAr,
    this.productVariationsId,
    this.status,
    this.sallaId,
  });

  Attributes.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    productVariationsId = json['product_variations_id'];
    status = json['status'];
    sallaId = json['salla_id'];
  }

  int? id;
  String? nameEn;
  String? nameAr;
  int? productVariationsId;
  int? status;
  dynamic sallaId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['product_variations_id'] = productVariationsId;
    map['status'] = status;
    map['salla_id'] = sallaId;
    return map;
  }
}
