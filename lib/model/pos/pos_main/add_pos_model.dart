class CreatePOSModel {
  final String counterName;
  final int? counterCustomer;
  final int? counterItemCat;
  final int? counterWarehouseId;
  final int? branchId;
  final String? counterIp;
  final int? counterDelivery;
  final int? counterPrinter;
  final String? printerName;
  final String? printerPort;
  final String receiptLang;
  final int? taxItem;
  final int? discountItem;
  final int? cashPaymentMethod;
  final int? counterVendor;
  final int kot;
  final int posMachine;
  final int posUom;
  final int logoStatus;
  final int invoiceCounting;
  final int isMainOrSingleEmployeePrinting;
  final int groupPrint;
  final int employeeGroupPrinting;
  final int enableOrderKotPrint;
  final int enableOrderPrint;
  final int numberOfPrintInvoices;
  final int enableInvoiceCounting;
  final int enableKotEmployeeGroupPrinting;
  final int enableEmployeeInPosInvoiceItem;
  final int? enableOnDevicePrinting;
  // final int enableKotProductGroupPrinting;

  /// ✅ Newly added field
  final int? numberOfPrints;

  CreatePOSModel({
    this.enableOnDevicePrinting,
    required this.counterName,
    this.counterCustomer,
    this.counterItemCat,
    this.counterWarehouseId,
    this.branchId,
    this.counterIp,
    this.counterDelivery,
    this.counterPrinter,
    this.printerName,
    this.printerPort,
    required this.receiptLang,
    this.taxItem,
    this.discountItem,
    this.cashPaymentMethod,
    this.counterVendor,
    required this.kot,
    required this.posMachine,
    required this.posUom,
    required this.logoStatus,
    required this.invoiceCounting,
    required this.isMainOrSingleEmployeePrinting,
    required this.groupPrint,
    required this.employeeGroupPrinting,
    required this.enableOrderKotPrint,
    required this.enableOrderPrint,
    required this.numberOfPrintInvoices,
    required this.enableInvoiceCounting,
    required this.enableKotEmployeeGroupPrinting,
    required this.enableEmployeeInPosInvoiceItem,
    // required this.enableKotProductGroupPrinting,
    this.numberOfPrints, // ✅ added in constructor
  });

  factory CreatePOSModel.fromJson(Map<String, dynamic> json) {
    return CreatePOSModel(
      enableOnDevicePrinting: json['ondevice_print'] as int,
      counterName: json['counter_name'] as String,
      counterCustomer: json['counter_customer'] as int?,
      counterItemCat: json['counter_item_cat'] as int?,
      counterWarehouseId: json['counter_warehouse_id'] as int?,
      branchId: json['branch_id'] as int?,
      counterIp: json['counter_ip'] as String?,
      counterDelivery: json['counter_delivery'] as int?,
      counterPrinter: json['counter_printer'] as int?,
      printerName: json['printer_name'] as String?,
      printerPort: json['printer_port'] as String?,
      receiptLang: json['receipt_lang'] as String? ?? 'en',
      taxItem: json['tax_item'] as int?,
      discountItem: json['discount_item'] as int?,
      cashPaymentMethod: json['cash_payment_method'] as int?,
      counterVendor: json['counter_vendor'] as int?,
      kot: json['pos_kot'] as int? ?? 0,
      posMachine: json['pos_machine'] as int? ?? 1,
      posUom: json['pos_uom'] as int? ?? 0,
      logoStatus: json['logo_status'] as int? ?? 0,
      invoiceCounting: json['invoice_counting'] as int? ?? 0,
      isMainOrSingleEmployeePrinting: json['is_main_or_single_employee_printing'] as int? ?? 1,
      groupPrint: json['group_print'] as int? ?? 0,
      employeeGroupPrinting: json['employee_group_printing'] as int? ?? 0,
      enableOrderKotPrint: json['enable_order_kot_print'] as int? ?? 0,
      enableOrderPrint: json['enable_order_print'] as int? ?? 0,
      numberOfPrintInvoices: json['number_of_print_invoices'] as int? ?? 0,
      enableInvoiceCounting: json['enable_invoice_counting'] as int? ?? 0,
      enableKotEmployeeGroupPrinting: json['enable_kot_employee_group_printing'] as int? ?? 0,
      enableEmployeeInPosInvoiceItem: json['enable_employee_in_pos_invoice_item'] as int? ?? 0,
      // enableKotProductGroupPrinting: json['enable_kot_product_group_printing'] as int? ?? 0,
      numberOfPrints: json['number_of_prints'] as int?, // ✅ new field in fromJson
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['counter_name'] = counterName;
    data['ondevice_print']=enableOnDevicePrinting;
    if (counterCustomer != null) data['counter_customer'] = counterCustomer;
    if (counterItemCat != null) data['counter_item_cat'] = counterItemCat;
    if (counterWarehouseId != null) data['counter_warehouse_id'] = counterWarehouseId;
    if (branchId != null) data['branch_id'] = branchId;
    if (counterIp != null) data['counter_ip'] = counterIp;
    if (counterDelivery != null) data['counter_delivery'] = counterDelivery;
    if (counterPrinter != null) data['counter_printer'] = counterPrinter;
    if (printerName != null) data['printer_name'] = printerName;
    if (printerPort != null) data['printer_port'] = printerPort;
    data['receipt_lang'] = receiptLang;
    if (taxItem != null) data['tax_item'] = taxItem;
    if (discountItem != null) data['discount_item'] = discountItem;
    if (cashPaymentMethod != null) data['cash_payment_method'] = cashPaymentMethod;
    if (counterVendor != null) data['counter_vendor'] = counterVendor;
    data['pos_kot'] = kot;
    data['pos_machine'] = posMachine;
    data['pos_uom'] = posUom;
    data['logo_status'] = logoStatus;
    data['invoice_counting'] = invoiceCounting;
    data['is_main_or_single_employee_printing'] = isMainOrSingleEmployeePrinting;
    data['group_print'] = groupPrint;
    data['employee_group_printing'] = employeeGroupPrinting;
    data['enable_order_kot_print'] = enableOrderKotPrint;
    data['enable_order_print'] = enableOrderPrint;
    data['no_of_print'] = numberOfPrintInvoices;
    data['enable_invoice_counting'] = enableInvoiceCounting;
    data['enable_kot_employee_group_printing'] = enableKotEmployeeGroupPrinting;
    data['enable_employee_in_pos_invoice_item'] = enableEmployeeInPosInvoiceItem;
    // data['enable_kot_product_group_printing'] = enableKotProductGroupPrinting;

    if (numberOfPrints != null) data['number_of_prints'] = numberOfPrints; // ✅ added in toJson

    return data;
  }

  @override
  String toString() {
    return 'CreatePOSModel(${toJson()})';
  }
}
