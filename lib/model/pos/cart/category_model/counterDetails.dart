

import 'package:flovix_kitchen/model/pos/cart/category_model/tax_info.dart';
import 'package:flovix_kitchen/model/pos/counter/discount/Counter_discount.dart';

import 'Charges_model.dart';
import 'discount_info.dart';

/// id : 80
/// counter_name : "PC-Counter"
/// counter_status : 1
/// counter_ip : ""
/// counter_printer : "1"
/// printer_name : 73
/// printer_port : ""
/// receipt_lang : "1"
/// counter_warehouse_id : 4
/// counter_item_cat : 35
/// counter_customer : 56
/// counter_vendor : 11
/// tax_item : 1586
/// discount_item : 430
/// cash_payment_method : 12
/// counter_delivery : 8
/// pos_machine : 0
/// kot : 1
/// branch_id : 1
/// group_print : 1
/// pos_uom : 0
/// logo_status : 1
/// business_profile : 0
/// invoice_counting : 0
/// enable_employee : 0
/// employee_group_printing : 0
/// is_main_or_single_employee_printing : 0
/// no_of_print : 0
/// enable_order_print : 1
/// enable_order_kot_print : 1

class CounterDetails {
  CounterDetails({
    this.id,
    this.counterName,
    this.counterStatus,
    this.counterIp,
    this.counterPrinter,
    this.roundOff,
    this.roundOffAccount,
    this.printerName,
    this.printerPort,
    this.receiptLang,
    this.taxInfo,
    this.counterWarehouseId,
    this.counterItemCat,
    this.counterCustomer,
    this.counterVendor,
    this.taxItem,
    this.discountItem,
    this.cashPaymentMethod,
    this.counterDelivery,
    this.posMachine,
    this.kot,
    this.branchId,
    this.groupPrint,
    this.posUom,
    this.logoStatus,
    this.businessProfile,
    this.invoiceCounting,
    this.enableEmployee,
    this.employeeGroupPrinting,
    this.chargesList,
    this.isMainOrSingleEmployeePrinting,
    this.noOfPrint,
    this.orderType,
    this.discountInfo,
    this.enableOrderPrint,
    this.isRestaurant,
    this.enableOrderKotPrint,
  this.onDevicePrint,
  });

  CounterDetails.fromJson(dynamic json) {
    id = json['id'];
    onDevicePrint = json['ondevice_print'];
    counterName = json['counter_name'];
    counterStatus = json['counter_status'];
    counterIp = json['counter_ip'];
    counterPrinter = json['counter_printer'];
    printerName = json['printer_name'];
    roundOffAccount = json['round_off_account'];
    roundOff = json['round_off'];
    printerPort = json['printer_port'];
    receiptLang = json['receipt_lang'];
    counterWarehouseId = json['counter_warehouse_id'];
    counterItemCat = json['counter_item_cat'];
    counterCustomer = json['counter_customer'];
    counterVendor = json['counter_vendor'];
    taxItem = json['tax_item'];
    orderType = json['order_type'];
    discountItem = json['discount_item'];
    cashPaymentMethod = json['cash_payment_method'];
    counterDelivery = json['counter_delivery'];
    posMachine = json['pos_machine'];
    kot = json['kot'];
    branchId = json['branch_id'];
    groupPrint = json['group_print'];
    posUom = json['pos_uom'];
    logoStatus = json['logo_status'];
    businessProfile = json['business_profile'];
    invoiceCounting = json['invoice_counting'];
    enableEmployee = json['enable_employee'];
    employeeGroupPrinting = json['employee_group_printing'];
    isMainOrSingleEmployeePrinting =
        json['is_main_or_single_employee_printing'];
    noOfPrint = json['no_of_print'];
    enableOrderPrint = json['enable_order_print'];
    enableOrderKotPrint = json['enable_order_kot_print'];
    isRestaurant = json['is_restaurant'];
    taxInfo =
        json['tax_info'] != null ? TaxInfo.fromJson(json['tax_info']) : null;
    discountInfo =
        json['discount_info'] != null ? CounterDiscount.fromJson(json['discount_info']) : null;
    if (json['charges'] != null) {
      chargesList = [];
      json['charges'].forEach((v) {
        chargesList?.add(ChargesModel.fromJson(v));
      });
    }
  }

  int? id;
  String? counterName;
  int? counterStatus;
  int? orderType;
  String? counterIp;
  String? counterPrinter;
  int? printerName;
  int? roundOff;
  int? roundOffAccount;
  String? printerPort;
  String? receiptLang;
  int? counterWarehouseId;
  int? onDevicePrint;
  int? counterItemCat;
  int? counterCustomer;
  int? counterVendor;
  int? taxItem;
  int? discountItem;
  int? cashPaymentMethod;
  int? counterDelivery;
  int? posMachine;
  int? kot;
  int? branchId;
  int? groupPrint;
  int? posUom;
  int? logoStatus;
  int? businessProfile;
  int? invoiceCounting;
  int? enableEmployee;
  int? employeeGroupPrinting;
  int? isMainOrSingleEmployeePrinting;
  int? noOfPrint;
  int? isRestaurant;
  int? enableOrderPrint;
  int? enableOrderKotPrint;
  TaxInfo? taxInfo;
  CounterDiscount? discountInfo;
  List<ChargesModel>? chargesList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['counter_name'] = counterName;
    map['round_off'] = roundOff;
    map['round_off_account'] = roundOffAccount;
    map['is_restaurant'] = isRestaurant;
    map['counter_status'] = counterStatus;
    map['counter_ip'] = counterIp;
    map['counter_printer'] = counterPrinter;
    map['order_type'] = orderType;
    map['printer_name'] = printerName;
    map['printer_port'] = printerPort;
    map['receipt_lang'] = receiptLang;
    map['counter_warehouse_id'] = counterWarehouseId;
    map['ondevice_print'] = onDevicePrint;
    map['counter_item_cat'] = counterItemCat;
    map['counter_customer'] = counterCustomer;
    map['counter_vendor'] = counterVendor;
    map['tax_item'] = taxItem;
    map['discount_item'] = discountItem;
    map['cash_payment_method'] = cashPaymentMethod;
    map['counter_delivery'] = counterDelivery;
    map['pos_machine'] = posMachine;
    map['kot'] = kot;
    map['branch_id'] = branchId;
    map['group_print'] = groupPrint;
    map['pos_uom'] = posUom;
    map['logo_status'] = logoStatus;
    map['business_profile'] = businessProfile;
    map['invoice_counting'] = invoiceCounting;
    map['enable_employee'] = enableEmployee;
    map['employee_group_printing'] = employeeGroupPrinting;
    map['is_main_or_single_employee_printing'] = isMainOrSingleEmployeePrinting;
    map['no_of_print'] = noOfPrint;
    map['enable_order_print'] = enableOrderPrint;
    map['enable_order_kot_print'] = enableOrderKotPrint;
    return map;
  }
}
