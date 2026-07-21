
import 'package:flovix_kitchen/model/pos/cart/product_model/single_product_model/product_menu_exclusions.dart';
import 'package:flovix_kitchen/model/pos/cart/product_model/single_product_model/single_product_model.dart';

import 'ItemUnit.dart';

/// item_id : 2969
/// item_reg_num : 61
/// item_description : "101 - ربع برست حراق"
/// item_price : 10
/// item_qty : 1
/// discount_percent : "0"
/// item_discount : 0
/// item_total : 10
/// batch_id : ""
/// item_tax : 1.35
/// inv_total : null
/// tax_inclusive : 0
/// item_tax_id : 1586
/// tax_percent : "15.0000%"
/// item_inv_disc : 1
/// item_unit : {"uom_value":1,"uom_name":"piece"}
/// uom_pos : 0
/// price-taxable : 0
/// item-type : 4
/// subof_id : []

class InvoiceItems {
  InvoiceItems({
      this.itemId, 
      this.itemRegNum, 
      this.itemDescription, 
      this.itemPrice, 
      this.itemQty, 
      this.discountPercent, 
      this.itemDiscount, 
      this.itemTotal, 
      this.batchId, 
      this.itemTax, 
      this.invTotal, 

      this.taxInclusive,
      this.itemTaxId, 
      this.itemNote,
      this.product,
      this.taxPercent,
      this.itemInvDisc,
      this.itemUnit, 
      this.uomPos, 

      this.pricetaxable,
      this.productMenuExclusions,
      this.itemtype,
      this.employeeId,
      this.subofId,});

  InvoiceItems.fromJson(dynamic json) {
    itemId = json['item_id'];
    itemNote = json['resturant_notes']??"";
    itemRegNum = json['item_reg_num']??0.0;
    itemDescription = json['item_description'];
    itemPrice = json['item_price']??0.0;
    itemQty = json['item_qty']??0;
    discountPercent = json['discount_percent']??"0";
    itemDiscount = json['item_discount']??"0";
    itemTotal = json['item_total']??0.0;
    batchId = json['batch_id']??0;
    itemTax = json['item_tax']??0.0;
   // invTotal = json['inv_total']??0.0;
    taxInclusive = json['tax_inclusive'];
    itemTaxId = json['item_tax_id'];
   // taxPercent = json['tax_percent']??"0.0";
    itemInvDisc = json['item_inv_disc']??0.0;
    itemUnit = json['item_unit'] != null ? ItemUnit.fromJson(json['item_unit']) : null;
   product = json['product'] != null ? SingleProductModel.fromJson(json['product']) : null;
    uomPos = json['uom_pos'];
    pricetaxable = json['price-taxable'];
    itemtype = json['item-type'];
    employeeId = json['emp_sno']??-1;

    if (product?.productMenuExclusions != null && product!.productMenuExclusions!.isNotEmpty) {
      // Product already has exclusions parsed - use them directly (no need to parse again)
      productMenuExclusions = product?.productMenuExclusions;
      
    } else if (json['product_exclusions'] != null) {
      // Product doesn't have exclusions, parse from product_exclusions field
      productMenuExclusions = [];
      json['product_exclusions'].forEach((v) {
        productMenuExclusions?.add(ProductMenuExclusions.fromJson(v));
      });
      
    }

  }
  int? itemId;
  int? employeeId;
  var itemRegNum;
  String? itemDescription;
  var itemPrice;
  int? itemQty;
  String? discountPercent;
  String? itemNote;
var itemDiscount;
  var itemTotal;
  String? batchId;  List<ProductMenuExclusions>? productMenuExclusions;
  var itemTax;
  dynamic invTotal;
  int? taxInclusive;
  int? itemTaxId;
  String? taxPercent;

  var itemInvDisc;
  ItemUnit? itemUnit;
  int? uomPos;
  int? pricetaxable;
  int? itemtype;
  SingleProductModel? product;
  List<dynamic>? subofId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_id'] = itemId;
    map['item_reg_num'] = itemRegNum;
    map['item_description'] = itemDescription;
    map['item_price'] = itemPrice;
    map['item_qty'] = itemQty;
    map['discount_percent'] = discountPercent;
    map['item_discount'] = itemDiscount;
    map['item_total'] = itemTotal;
    map['batch_id'] = batchId;
    map['resturant_notes'] = itemNote;
    map['item_tax'] = itemTax;
    map['inv_total'] = invTotal;
    map['tax_inclusive'] = taxInclusive;
    map['item_tax_id'] = itemTaxId;
    map['tax_percent'] = taxPercent;
    map['emp_sno'] = employeeId;
    map['item_inv_disc'] = itemInvDisc;
    if (itemUnit != null) {
      map['item_unit'] = itemUnit?.toJson();
    } if (product != null) {
      map['product'] = product?.toJson();
    }
    map['uom_pos'] = uomPos;
    map['price-taxable'] = pricetaxable;
    map['item-type'] = itemtype;
    if (subofId != null) {
      map['subof_id'] = subofId?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}