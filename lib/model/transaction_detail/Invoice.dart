import 'dart:convert';

import 'package:flovix_kitchen/model/pos/cart/category_model/customer_model.dart';

import 'Charges_transaction_detail_model.dart';
import 'InvoiceItems.dart';
import 'ItemUnit.dart';
import 'Loyalty_meta_data.dart';

/// invoice_id : 1143
/// inv_number : "150"
/// inv_date : "2025-10-17"
/// inv_warehouse : 1
/// class_id : 0
/// po_number : "0"
/// rep_id : 0
/// ship_via_id : 8
/// fob_number : "0"
/// main_inv_number : "150"
/// inv_shipto : ""
/// inv_cus_id : 7
/// inv_total : 10.35
/// inv_notes : ""
/// inv_round_value : -0.35
/// inv_discount_id : 1522
/// inv_disc_percent : "10.0000%"
/// inv_tax_id : 1586
/// inv_tax : 1.35
/// inv_payment_id : 13
/// inv_due : 10
/// counter_id : 4
/// invoiceItems : [{"item_id":2969,"item_reg_num":61,"item_description":"101 - ربع برست حراق","item_price":10,"item_qty":1,"discount_percent":"0","item_discount":0,"item_total":10,"batch_id":"","item_tax":1.35,"inv_total":null,"tax_inclusive":0,"item_tax_id":1586,"tax_percent":"15.0000%","item_inv_disc":1,"item_unit":{"uom_value":1,"uom_name":"piece"},"uom_pos":0,"price-taxable":0,"item-type":4,"subof_id":[]}]

class MultiPaymentMethodItem {
  String paymentMethod;
  var amount;

  MultiPaymentMethodItem({required this.paymentMethod, required this.amount});

  factory MultiPaymentMethodItem.fromJson(Map<String, dynamic> json) {
    return MultiPaymentMethodItem(
      paymentMethod: "${json['payment_method']}",
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_method': paymentMethod,
      'amount': amount,
    };
  }
}

class Invoice {
  Invoice(
      {this.invoiceId,
      this.invNumber,
      this.numberOfDiners,
      this.deliveryManID,
      this.invDate,
      this.invWarehouse,
      this.classId,
      this.poNumber,
      this.couponId,
      this.repId,
      this.eventId,
      this.order_tag,
      this.itemUnit,
      this.shipViaId,
      this.fobNumber,
      this.invPaid,
      this.mainInvNumber,
      this.multiPayment,
      this.invShipto,
      this.orderTag,
      this.invCusId,
      this.invTotal,
      this.invNotes,
      this.invRoundValue,
      this.floorId,
      this.invDiscountId,
      this.invDiscPercent,
      this.invTaxId,
      this.invTax,
      this.invPaymentId,
      this.invDue,
      this.counterId,
      this.tableId,
      this.empSno,
      this.invoiceItems,
      this.multiPaymentMethods,
      this.refNo,
      this.loyaltyScheme,
      this.loyaltyPoints,
      this.loyaltyMetaData,
      this.loyaltyDiscount,
      this.chargesTransactionDetailModel,
      this.dineInState,
      this.customer});

  Invoice.fromJson(dynamic json) {
    invoiceId = json['invoice_id'];
    order_tag = json['order_tag'];
    loyaltyScheme = json['loyalty_scheme'];
    loyaltyPoints = json['loyalty_points'];
    couponId = json['coupon_id']??0;

    loyaltyMetaData = (json['meta_data'] != null && 
                      !(json['meta_data'] is List && (json['meta_data'] as List).isEmpty))
        ? LoyaltyMetaData.fromJson(json['meta_data'])
        : null;
    multiPayment = json['multi_payment'];
    invNumber = json['inv_number'];
    numberOfDiners = json['number_of_diners'] ?? 0;
    deliveryManID = json['delivery_man_id'] ?? 0;
    tableId = json['table_id'];
    dineInState = json['dine_state'];
    floorId = json['floor_id'];
    invDate = json['inv_date'];
    eventId = json['event_id']??0;
 //   invWarehouse = json['inv_warehouse'];
    invPaid = json['inv_paid'];
  //  classId = json['class_id'];
    poNumber = json['po_number'];
    repId = json['rep_id'];

    empSno = json['emp_sno'];
    shipViaId = json['ship_via_id'];
    refNo = json['ref_no'];
    fobNumber = json['fob_number'];
    orderTag = json['order_tag'];
    mainInvNumber = json['main_inv_number'];
    invShipto = json['inv_shipto'];
    invCusId = json['inv_cus_id'];
    invTotal = json['inv_total'];
    invNotes = json['inv_notes'];
    invRoundValue = json['inv_round_value'];
    invDiscountId = json['inv_discount_id'];
    invDiscPercent = json['inv_disc_percent'];
    invTaxId = json['inv_tax_id'];
    invTax = json['inv_tax'];
    invPaymentId = json['inv_payment_id'];
    invDue = json['inv_due'];
    counterId = json['counter_id'];

    itemUnit =
        json['item_unit'] != null ? ItemUnit.fromJson(json['item_unit']) : null;
    customer = json['customer'] != null
        ? CustomerModel.fromJson(json['customer'])
        : null;
    if (json['charges'] != null) {
      chargesTransactionDetailModel = [];
      json['charges'].forEach((v) {
        chargesTransactionDetailModel
            ?.add(ChargesTransactionDetailModel.fromJson(v));
      });
    }
    if (json['invoiceItems'] != null) {
      invoiceItems = [];
      json['invoiceItems'].forEach((v) {
        invoiceItems?.add(InvoiceItems.fromJson(v));
      });
    }
    if (json['multi_payment_methods'] != null) {
      multiPaymentMethods = [];
      json['multi_payment_methods'].forEach((v) {
        multiPaymentMethods?.add(MultiPaymentMethodItem.fromJson(v));
      });
    }
  }

  int? invoiceId;
  String? invNumber;
  List<MultiPaymentMethodItem>? multiPaymentMethods;
  String? invDate;
  int? order_tag;
  int? multiPayment;
  int? empSno;
  int? orderTag;
  int? eventId;
  int? tableId;
  int? invWarehouse;
  CustomerModel? customer;
  int? deliveryManID;
  int? loyaltyScheme;
  var loyaltyDiscount;
  var loyaltyPoints;
  LoyaltyMetaData? loyaltyMetaData;
  ItemUnit? itemUnit;
  int? couponId;
  int? classId;
  String? refNo;
  String? poNumber;
  int? repId;
  int? numberOfDiners;
  int? floorId;
  var invPaid;
  int? dineInState;
  int? shipViaId;
  String? fobNumber;
  String? mainInvNumber;
  String? invShipto;
  int? invCusId;
  var invTotal;
  String? invNotes;
  var invRoundValue;
  int? invDiscountId;
  String? invDiscPercent;
  int? invTaxId;
  var invTax;
  int? invPaymentId;
  var invDue;
  int? counterId;
  List<InvoiceItems>? invoiceItems;
  List<ChargesTransactionDetailModel>? chargesTransactionDetailModel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoice_id'] = invoiceId;
    map['inv_number'] = invNumber;
    map['emp_sno'] = empSno;
    map['order_tag'] = order_tag;
    map['inv_date'] = invDate;
    map['delivery_man_id'] = deliveryManID;
    map['inv_warehouse'] = invWarehouse;
    map['class_id'] = classId;
    map['po_number'] = poNumber;
    map['rep_id'] = repId;
    map['inv_paid'] = invPaid;
    map['dine_state'] = dineInState;
    map['ship_via_id'] = shipViaId;
    map['event_id'] = eventId;
    map['fob_number'] = fobNumber;
    map['main_inv_number'] = mainInvNumber;
    map['inv_shipto'] = invShipto;
    map['inv_cus_id'] = invCusId;
    map['floor_id'] = floorId;
    map['inv_total'] = invTotal;
    map['inv_notes'] = invNotes;
    map['loyalty_scheme'] = loyaltyScheme;
    map['loyalty_discount'] = loyaltyDiscount;
    map['loyalty_points'] = loyaltyPoints;
    map['order_tag'] = orderTag;
    map['inv_round_value'] = invRoundValue;
    map['inv_discount_id'] = invDiscountId;
    map['inv_disc_percent'] = invDiscPercent;
    map['inv_tax_id'] = invTaxId;
    map['inv_tax'] = invTax;
    map['number_of_diners'] = numberOfDiners;
    map['inv_payment_id'] = invPaymentId;
    map['inv_due'] = invDue;
    map['counter_id'] = counterId;
    if (multiPaymentMethods != null) {
      map['multi_payment_methods'] =
          jsonEncode(multiPaymentMethods?.map((v) => v.toJson()).toList());
    }
    if (invoiceItems != null) {
      map['invoiceItems'] = invoiceItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
