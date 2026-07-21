

import 'package:equatable/equatable.dart';
import 'package:flovix_kitchen/model/pdf_files/Printer_model.dart' show PrinterModel;
import 'package:flovix_kitchen/model/pos/cart/product_model/variations_model.dart';
import 'package:flovix_kitchen/utils/product_stock_utils.dart';
import 'package:flutter/cupertino.dart';

import 'Default_batch.dart';
import 'Uom_model.dart';
import 'menu_item.dart';

/// sno : 157
/// p_name : "WHELL CUP - TEST"
/// sales_description : "TEST"
/// variation_text : null
/// item_image : "https://taqreri.com/sys_images/sv.png"
/// bar_code : ""
/// sale_price : 100
/// cost_price : 0
/// variations_count : 3
/// variations : {"variations":[{"id":3,"var_name":"color","var_name_ar":"لون","attributes":[{"id":1,"name_en":"red","name_ar":"أحمر"}]},{"id":4,"var_name":"size","var_name_ar":"مقاس","attributes":[{"id":3,"name_en":"small","name_ar":"صغير"},{"id":4,"name_en":"medium","name_ar":"واسطة"},{"id":5,"name_en":"large","name_ar":"كبير"}]},{"id":7,"var_name":"Condition","var_name_ar":"حالة","attributes":[{"id":8,"name_en":"Good","name_ar":"جيد"},{"id":9,"name_en":"Better","name_ar":"أحسن"}]}],"childProduct":[{"sno":1535,"p_code":"","p_tax_code":null,"sub_itemof":0,"item_group":"0","p_cat_id":16,"p_name":"WHELL CUP  red  small  Good ","p_name_ar":"TEST","slug":"WHELL-CUP","p_reg_date":"2024-02-23","p_type":4,"unit_measure":21,"if_purchased":0,"unit_sale":21,"unit_purchase":50,"unit_shipping":0,"vendor_number":null,"purchase_description":"","sales_description":"TEST","cost_price":0,"sale_price":0,"tax_type":0,"is_percentage":0,"taxable":1,"cogs_account":0,"income_account":6,"assets_account":0,"tax_account":0,"expense_account":0,"discount":null,"discount_start_at":null,"discount_end_at":null,"discount_account":0,"preferred_vendor":0,"reorder_point_min":0,"reorder_point_max":0,"assembly_specific":0,"client_sno":28,"company_sno":347,"user_sno":616,"product_photo":null,"gl_account":0,"bar_code":"","sku":"","default_discount":"0","default_discount2":"0","default_tax":"0","default_tax2":"0","assembly_item_id":"","assembly_item_qty":"","assembly_item_unit":"","assembly_net_cost":0,"assembly_item_waste":"","pay_method":0,"item_image":"","reporting_unit":50,"weight_unit":0,"p_status":1,"min_sale_price":0,"max_sale_price":0,"min_sale_qty":0,"max_sale_qty":0,"min_discount":"0","max_discount":"0","min_tax":"0","max_tax":"0","consumer_price":0,"is_bonus":0,"p_brand_id":0,"product_unit_label":0,"sellable":1,"p_branch_id":0,"opening_qty":0,"b_profile_id":1,"is_featured":0,"tax_inclusive":0,"product_tags":"","product_time":"0","available_online":1,"expiry_in_days":0,"short_description":"","long_description":"","shipping_weight":"0","product_volume":"0","admin_cost":0,"indirect_cost":0,"labor_cost":0,"machine_cost":0,"sales_cost":0,"other_cost":0,"bom_cost":0,"emp_id":1,"updated_at":"2024-03-03 10:30:08","variation_text":" red  small  Good ","variation_id":"","attribute_id":"1,3,8","parent_id":157,"lab_test_type":0,"hospital_type":0,"max_menu_items":"{\"1\":\"\",\"2\":\"\"}","out_of_stock":0,"unit_sales_quantity":0,"item_ordering":null,"salla_product_id":null,"salla_sale_price":0,"salla_cost_price":0,"salla_qty":0,"is_coupen_code_available":0},{"sno":1536,"p_code":"","p_tax_code":null,"sub_itemof":0,"item_group":"0","p_cat_id":16,"p_name":"WHELL CUP  red  medium  Better ","p_name_ar":"TEST","slug":"WHELL-CUP","p_reg_date":"2024-02-23","p_type":4,"unit_measure":21,"if_purchased":0,"unit_sale":21,"unit_purchase":50,"unit_shipping":0,"vendor_number":null,"purchase_description":"","sales_description":"TEST","cost_price":0,"sale_price":0,"tax_type":0,"is_percentage":0,"taxable":1,"cogs_account":0,"income_account":6,"assets_account":0,"tax_account":0,"expense_account":0,"discount":null,"discount_start_at":null,"discount_end_at":null,"discount_account":0,"preferred_vendor":0,"reorder_point_min":0,"reorder_point_max":0,"assembly_specific":0,"client_sno":28,"company_sno":347,"user_sno":616,"product_photo":null,"gl_account":0,"bar_code":"","sku":"","default_discount":"0","default_discount2":"0","default_tax":"0","default_tax2":"0","assembly_item_id":"","assembly_item_qty":"","assembly_item_unit":"","assembly_net_cost":0,"assembly_item_waste":"","pay_method":0,"item_image":"","reporting_unit":50,"weight_unit":0,"p_status":1,"min_sale_price":0,"max_sale_price":0,"min_sale_qty":0,"max_sale_qty":0,"min_discount":"0","max_discount":"0","min_tax":"0","max_tax":"0","consumer_price":0,"is_bonus":0,"p_brand_id":0,"product_unit_label":0,"sellable":1,"p_branch_id":0,"opening_qty":0,"b_profile_id":1,"is_featured":0,"tax_inclusive":0,"product_tags":"","product_time":"0","available_online":1,"expiry_in_days":0,"short_description":"","long_description":"","shipping_weight":"0","product_volume":"0","admin_cost":0,"indirect_cost":0,"labor_cost":0,"machine_cost":0,"sales_cost":0,"other_cost":0,"bom_cost":0,"emp_id":1,"updated_at":"2024-03-03 10:30:08","variation_text":" red  medium  Better ","variation_id":"","attribute_id":"1,4,9","parent_id":157,"lab_test_type":0,"hospital_type":0,"max_menu_items":"{\"1\":\"\",\"2\":\"\"}","out_of_stock":0,"unit_sales_quantity":0,"item_ordering":null,"salla_product_id":null,"salla_sale_price":0,"salla_cost_price":0,"salla_qty":0,"is_coupen_code_available":0},{"sno":1537,"p_code":"","p_tax_code":null,"sub_itemof":0,"item_group":"0","p_cat_id":16,"p_name":"WHELL CUP  red  large  Better ","p_name_ar":"TEST","slug":"WHELL-CUP","p_reg_date":"2024-02-23","p_type":4,"unit_measure":21,"if_purchased":0,"unit_sale":21,"unit_purchase":50,"unit_shipping":0,"vendor_number":null,"purchase_description":"","sales_description":"TEST","cost_price":0,"sale_price":0,"tax_type":0,"is_percentage":0,"taxable":1,"cogs_account":0,"income_account":6,"assets_account":0,"tax_account":0,"expense_account":0,"discount":null,"discount_start_at":null,"discount_end_at":null,"discount_account":0,"preferred_vendor":0,"reorder_point_min":0,"reorder_point_max":0,"assembly_specific":0,"client_sno":28,"company_sno":347,"user_sno":616,"product_photo":null,"gl_account":0,"bar_code":"","sku":"","default_discount":"0","default_discount2":"0","default_tax":"0","default_tax2":"0","assembly_item_id":"","assembly_item_qty":"","assembly_item_unit":"","assembly_net_cost":0,"assembly_item_waste":"","pay_method":0,"item_image":"","reporting_unit":50,"weight_unit":0,"p_status":1,"min_sale_price":0,"max_sale_price":0,"min_sale_qty":0,"max_sale_qty":0,"min_discount":"0","max_discount":"0","min_tax":"0","max_tax":"0","consumer_price":0,"is_bonus":0,"p_brand_id":0,"product_unit_label":0,"sellable":1,"p_branch_id":0,"opening_qty":0,"b_profile_id":1,"is_featured":0,"tax_inclusive":0,"product_tags":"","product_time":"0","available_online":1,"expiry_in_days":0,"short_description":"","long_description":"","shipping_weight":"0","product_volume":"0","admin_cost":0,"indirect_cost":0,"labor_cost":0,"machine_cost":0,"sales_cost":0,"other_cost":0,"bom_cost":0,"emp_id":1,"updated_at":"2024-03-03 10:30:08","variation_text":" red  large  Better ","variation_id":"","attribute_id":"1,5,9","parent_id":157,"lab_test_type":0,"hospital_type":0,"max_menu_items":"{\"1\":\"\",\"2\":\"\"}","out_of_stock":0,"unit_sales_quantity":0,"item_ordering":null,"salla_product_id":null,"salla_sale_price":0,"salla_cost_price":0,"salla_qty":0,"is_coupen_code_available":0}]}
/// menu_item : {"menu_variation":[{"sno":1,"variation_name":"single choice","variation_name_ar":"single choice","branch":0,"status":1,"is_multi_choice":0,"single_choice":1,"created_by":1,"created_at":"2023-11-06 06:42:41","updated_by":1,"updated_at":"2023-12-22 18:29:43","max_qty":"","menu_items":[{"product_menu_variation_id":515,"product_menu_list_id":1,"master_product_id":157,"item_id":7,"item_sale_price":2.5,"item_quantity":1,"item_unit_id":21,"item_total":2.5,"is_active":1,"is_default":1,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"White Meat","sales_description":"White Meat","item_image":"https://taqreri.com/sys_images/sv.png","sno":7},{"product_menu_variation_id":516,"product_menu_list_id":1,"master_product_id":157,"item_id":3,"item_sale_price":38,"item_quantity":1,"item_unit_id":21,"item_total":38,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"3","sales_description":"Broast","item_image":"https://taqreri-cdn.fra1.digitaloceanspaces.com/company_files/userdb_347_28385/images/broastuserdb240105025312pm6597eda8379c1.png","sno":3}]},{"sno":2,"variation_name":"Multi Option","variation_name_ar":"Multi Option","branch":0,"status":1,"is_multi_choice":1,"single_choice":0,"created_by":1,"created_at":"2023-11-10 08:49:12","updated_by":1,"updated_at":"2023-12-11 09:44:03","max_qty":"","menu_items":[{"product_menu_variation_id":517,"product_menu_list_id":2,"master_product_id":157,"item_id":5,"item_sale_price":50,"item_quantity":1,"item_unit_id":21,"item_total":50,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"5","sales_description":"شوارما عادي","item_image":"https://taqreri.com/sys_images/sv.png","sno":5},{"product_menu_variation_id":518,"product_menu_list_id":2,"master_product_id":157,"item_id":4,"item_sale_price":19,"item_quantity":4,"item_unit_id":21,"item_total":76,"is_active":1,"is_default":1,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"4","sales_description":"نص حبة حراق","item_image":"https://taqreri-cdn.fra1.digitaloceanspaces.com/company_files/userdb_347_28385/images/auserdb230611110432am1242userdb250530062956pm6839cef4f137d.jpg","sno":4}]}],"menu_exclusion":[],"main_product":{"max_menu_items":"{\"1\":\"\",\"2\":\"\"}","sno":157,"sale_price":100,"p_name":"WHELL CUP","sales_description":"TEST","item_image":""}}

class ProductModel extends Equatable {
  ProductModel({
      this.sno, 
      this.pType,
      this.catId,

      this.isTaxable,
      this.taxInclusive,
      this.pName,
      this.productTags,
      this.salesDescription,
      this.variationText, 
      this.unitSale,
      //this.productMenuExclusions,
      this.itemImage,
      this.unitId,
      this.sellable,
      this.barCode,
      this.defaultDiscount,
      this.salePrice,
      this.costPrice, 
      this.stock,
      this.variationsCount,
      this.variations,
      this.uomList,
      this.defaultBatchList,
    this.totalDiscount = 0.0,
    this.totalAmount = 0.0,

      this.menuItem,});

  ProductModel.fromJson(dynamic json) {
    sno = parseProductInt(json['sno']);
    pType = parseProductInt(json['p_type']);
    catId = parseProductInt(json['cat_id']);
    defaultDiscount = json['default_discount']??"0";
    stock = parseProductInt(json['stock']);
    sellable = parseProductInt(json['sellable']);


    salePrice = json['sale_price']??0.0;
    costPrice = json['cost_price']??0.0;
    isTaxable = json['taxable']??0;
    taxInclusive = json['tax_inclusive']??0;
    pName = json['p_name']??"";
    salesDescription = json['sales_description']??"";
     variationText = json['variation_text']??"";
     itemImage = json['item_image']??'';
     barCode = json['bar_code']??"";
     
    productTags = json['product_tags']??"";
    
    unitId = parseProductInt(json['unit_id'] ?? json['item_unit_id']);
    unitSale = parseProductInt(json['unit_sale']);

      variationsCount = json['variations_count']??0;
  variations =json['variations'] != null ? VariationsModel.fromJson(json['variations']) : null ;

    printerModel =json['printer'] != null ? PrinterModel.fromJson(json['printer']) : null ;
  menuItem = json['menu_item'] != null ? MenuItem.fromJson(json['menu_item']) : null;
    if (json['uom_list'] != null) {
      uomList = [];
      json['uom_list'].forEach((v) {
        uomList?.add(UomModel.fromJson(v));
      });
    }
    debugPrint("default batch data ${json['default_batch']}");
    defaultBatchList = parseDefaultBatchList(json['default_batch']);

  }
  int? sno;
  int? taxInclusive;
  int? isTaxable;
  int? unitSale;
  int? sellable;
  int? unitId;
  int? stock;
  int? catId;
  int? pType;
  String? pName;
  String? productTags;
  String? salesDescription;
  String? variationText;
  String? itemImage;
  String? barCode;
  String? defaultDiscount;
  List<UomModel>? uomList;
  List<DefaultBatch>? defaultBatchList;
  var salePrice;
  var costPrice;
  int? variationsCount;
  VariationsModel? variations;
  MenuItem? menuItem;
  PrinterModel? printerModel;
  double totalAmount = 0.0;
  double totalDiscount = 0.0;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['tax_inclusive'] = taxInclusive;
    map['taxable'] = isTaxable;
    map['stock'] = stock;
    map['sellable'] = sellable;
    map['unit_sale'] = unitSale;
    map['p_name'] = pName;
    map['unit_id'] = unitId;
    map['p_type'] = pType;
    map['sales_description'] = salesDescription;
    map['variation_text'] = variationText;
    map['item_image'] = itemImage;
    map['default_discount'] = defaultDiscount;
    map['bar_code'] = barCode;
    map['cat_id'] = catId;
    map['product_tags'] = productTags;
    map['sale_price'] = salePrice;
    map['cost_price'] = costPrice;
    map['variations_count'] = variationsCount;
    if (variations != null) {
      map['variations'] = variations?.toJson();
    }
    if (uomList != null) {
      map['uom_list'] = uomList?.map((v) => v.toJson()).toList();
    }  if (defaultBatchList != null) {
      map['default_batch'] = defaultBatchList?.map((v) => v.toJson()).toList();
    }

    if (menuItem != null) {
      map['menu_item'] = menuItem?.toJson();
    }
    return map;
  }

  ProductModel copyWith({
    double? totalAmount,
    double? totalDiscount,
    int? sno,
    int? taxInclusive,
    int? cat_id,
    int? isTaxable,
    int? unitSale,
    int? sellable,
    int? unitId,
    int? stock,
    int? pType,
    String? pName,
    String? productTags,
    String? salesDescription,
    String? variationText,
    String? itemImage,
    String? barCode,
    String? defaultDiscount,
    List<UomModel>? uomList,
    List<DefaultBatch>? defaultBatchList,
    dynamic salePrice,
    dynamic costPrice,
    int? variationsCount,
    VariationsModel? variations,
    MenuItem? menuItem,
    PrinterModel? printerModel,
  }) {
    return ProductModel(
      catId: cat_id ?? this.catId,
      totalAmount: totalAmount ?? this.totalAmount,
      //peo: productTags ?? this.productTags,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      sno: sno ?? this.sno,
      taxInclusive: taxInclusive ?? this.taxInclusive,
      isTaxable: isTaxable ?? this.isTaxable,
      unitSale: unitSale ?? this.unitSale,
      sellable: sellable ?? this.sellable,
      unitId: unitId ?? this.unitId,
      stock: stock ?? this.stock,
      pType: pType ?? this.pType,
      pName: pName ?? this.pName,
      productTags: productTags ?? this.productTags,
      salesDescription: salesDescription ?? this.salesDescription,
      variationText: variationText ?? this.variationText,
      itemImage: itemImage ?? this.itemImage,
      barCode: barCode ?? this.barCode,
      defaultDiscount: defaultDiscount ?? this.defaultDiscount,
      uomList: uomList ?? this.uomList,
      defaultBatchList: defaultBatchList ?? this.defaultBatchList,
      salePrice: salePrice ?? this.salePrice,
      costPrice: costPrice ?? this.costPrice,
      variationsCount: variationsCount ?? this.variationsCount,
      variations: variations ?? this.variations,
      menuItem: menuItem ?? this.menuItem,
    )..printerModel = printerModel ?? this.printerModel;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    totalDiscount,
    catId,
    totalAmount,
    pName,
    productTags,
  ];

}

