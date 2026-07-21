class CreateCounterResponseModel {
  bool? success;
  String? message;
  String? redirect;
  Data? data;

  CreateCounterResponseModel(
      {this.success, this.message, this.redirect, this.data});

  CreateCounterResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['redirect'] = redirect;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? counterName;
  int? counterCustomer;
  int? counterItemCat;
  int? counterWarehouseId;
  int? branchId;
  String? counterIp;
  int? counterDelivery;
  int? counterPrinter;
  int? printerName;
  String? printerPort;
  String? receiptLang;
  int? taxItem;
  int? discountItem;
  int? cashPaymentMethod;
  int? counterVendor;
  int? posMachine;
  int? posUom;
  int? logoStatus;
  int? invoiceCounting;
  int? isMainOrSingleEmployeePrinting;
  int? groupPrint;
  int? employeeGroupPrinting;
  int? enableEmployee;
  int? id;

  Data({
    this.counterName,
    this.counterCustomer,
    this.counterItemCat,
    this.counterWarehouseId,
    this.branchId,
    this.counterIp,
    this.counterDelivery,
    this.counterPrinter,
    this.printerName,
    this.printerPort,
    this.receiptLang,
    this.taxItem,
    this.discountItem,
    this.cashPaymentMethod,
    this.counterVendor,
    this.posMachine,
    this.posUom,
    this.logoStatus,
    this.invoiceCounting,
    this.isMainOrSingleEmployeePrinting,
    this.groupPrint,
    this.employeeGroupPrinting,
    this.enableEmployee,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    counterName = json['counter_name'];
    counterCustomer = _toInt(json['counter_customer']);
    counterItemCat = _toInt(json['counter_item_cat']);
    counterWarehouseId = _toInt(json['counter_warehouse_id']);
    branchId = _toInt(json['branch_id']);
    counterIp = json['counter_ip']?.toString();
    counterDelivery = _toInt(json['counter_delivery']);
    counterPrinter = _toInt(json['counter_printer']);
    printerName = _toInt(json['printer_name']); // 👈 safe parse
    printerPort = json['printer_port']?.toString();
    receiptLang = json['receipt_lang']?.toString();
    taxItem = _toInt(json['tax_item']);
    discountItem = _toInt(json['discount_item']);
    cashPaymentMethod = _toInt(json['cash_payment_method']);
    counterVendor = _toInt(json['counter_vendor']);
    posMachine = _toInt(json['pos_machine']);
    posUom = _toInt(json['pos_uom']);
    logoStatus = _toInt(json['logo_status']);
    invoiceCounting = _toInt(json['invoice_counting']);
    isMainOrSingleEmployeePrinting =
        _toInt(json['is_main_or_single_employee_printing']);
    groupPrint = _toInt(json['group_print']);
    employeeGroupPrinting = _toInt(json['employee_group_printing']);
    enableEmployee = _toInt(json['enable_employee']);
    id = _toInt(json['id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['counter_name'] = counterName;
    data['counter_customer'] = counterCustomer;
    data['counter_item_cat'] = counterItemCat;
    data['counter_warehouse_id'] = counterWarehouseId;
    data['branch_id'] = branchId;
    data['counter_ip'] = counterIp;
    data['counter_delivery'] = counterDelivery;
    data['counter_printer'] = counterPrinter;
    data['printer_name'] = printerName;
    data['printer_port'] = printerPort;
    data['receipt_lang'] = receiptLang;
    data['tax_item'] = taxItem;
    data['discount_item'] = discountItem;
    data['cash_payment_method'] = cashPaymentMethod;
    data['counter_vendor'] = counterVendor;
    data['pos_machine'] = posMachine;
    data['pos_uom'] = posUom;
    data['logo_status'] = logoStatus;
    data['invoice_counting'] = invoiceCounting;
    data['is_main_or_single_employee_printing'] =
        isMainOrSingleEmployeePrinting;
    data['group_print'] = groupPrint;
    data['employee_group_printing'] = employeeGroupPrinting;
    data['enable_employee'] = enableEmployee;
    data['id'] = id;
    return data;
  }

  /// 👇 helper inside Data
  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
