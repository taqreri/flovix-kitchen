// session_status_model.dart
class SessionStatusResponse {
  final int status;
  final ActiveSession activeSession;
  final Counter counter;

  SessionStatusResponse({
    required this.status,
    required this.activeSession,
    required this.counter,
  });

  factory SessionStatusResponse.fromJson(Map<String, dynamic> json) {
    return SessionStatusResponse(
      status: json['status'],
      activeSession: ActiveSession.fromJson(json['active_session']),
      counter: Counter.fromJson(json['counter']),
    );
  }
}

/// Data returned by newSessionModal API for the new terminal session dialog.
class NewSessionModalData {
  final String sessionId;
  final String user;
  final List<Counter> counters;

  NewSessionModalData({
    required this.sessionId,
    required this.user,
    required this.counters,
  });
}

class ActiveSession {
  final int sId;
  final String sLabel;
  final int sCounterId;
  final int sUserId;
  final int sStatus;
  final double expectedCash;
  final double countedCash;
  final double cashDiff;
  final int staffId;
  final int accountId;
  final String startTime;
  final String? endTime;

  ActiveSession({
    required this.sId,
    required this.sLabel,
    required this.sCounterId,
    required this.sUserId,
    required this.sStatus,
    required this.expectedCash,
    required this.countedCash,
    required this.cashDiff,
    required this.staffId,
    required this.accountId,
    required this.startTime,
    this.endTime,
  });

  factory ActiveSession.fromJson(Map<String, dynamic> json) {
    return ActiveSession(
      sId: json['s_id'],
      sLabel: json['s_label'],
      sCounterId: json['s_counter_id'],
      sUserId: json['s_user_id'],
      sStatus: json['s_status'],
      expectedCash: (json['expected_cash'] as num).toDouble(),
      countedCash: (json['counted_cash'] as num).toDouble(),
      cashDiff: (json['cash_diff'] as num).toDouble(),
      staffId: json['staff_id'],
      accountId: json['account_id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}

class Counter {
  final int id;
  final String counterName;
  final int counterStatus;
  final String counterIp;
  final String counterPrinter;
  final int printerName;
  final String printerPort;
  final String receiptLang;
  final int counterWarehouseId;
  final int counterItemCat;
  final int counterCustomer;
  final int counterVendor;
  final int taxItem;
  final int discountItem;
  final int cashPaymentMethod;
  final int counterDelivery;
  final int posMachine;
  final int kot;
  final int branchId;
  final int groupPrint;
  final int posUom;
  final int logoStatus;
  final int businessProfile;
  final int invoiceCounting;
  final int enableEmployee;
  final int employeeGroupPrinting;
  final int isMainOrSingleEmployeePrinting;
  final int noOfPrint;
  final int enableOrderPrint;
  final int enableOrderKotPrint;

  Counter({
    required this.id,
    required this.counterName,
    required this.counterStatus,
    required this.counterIp,
    required this.counterPrinter,
    required this.printerName,
    required this.printerPort,
    required this.receiptLang,
    required this.counterWarehouseId,
    required this.counterItemCat,
    required this.counterCustomer,
    required this.counterVendor,
    required this.taxItem,
    required this.discountItem,
    required this.cashPaymentMethod,
    required this.counterDelivery,
    required this.posMachine,
    required this.kot,
    required this.branchId,
    required this.groupPrint,
    required this.posUom,
    required this.logoStatus,
    required this.businessProfile,
    required this.invoiceCounting,
    required this.enableEmployee,
    required this.employeeGroupPrinting,
    required this.isMainOrSingleEmployeePrinting,
    required this.noOfPrint,
    required this.enableOrderPrint,
    required this.enableOrderKotPrint,
  });

  factory Counter.fromJson(Map<String, dynamic> json) {
    return Counter(
      id: json['id'],
      counterName: json['counter_name'],
      counterStatus: json['counter_status'],
      counterIp: json['counter_ip'],
      counterPrinter: json['counter_printer'],
      printerName: json['printer_name'],
      printerPort: json['printer_port'],
      receiptLang: json['receipt_lang'],
      counterWarehouseId: json['counter_warehouse_id'],
      counterItemCat: json['counter_item_cat'],
      counterCustomer: json['counter_customer'],
      counterVendor: json['counter_vendor'],
      taxItem: json['tax_item'],
      discountItem: json['discount_item'],
      cashPaymentMethod: json['cash_payment_method'],
      counterDelivery: json['counter_delivery'],
      posMachine: json['pos_machine'],
      kot: json['kot'],
      branchId: json['branch_id'],
      groupPrint: json['group_print'],
      posUom: json['pos_uom'],
      logoStatus: json['logo_status'],
      businessProfile: json['business_profile'],
      invoiceCounting: json['invoice_counting'],
      enableEmployee: json['enable_employee'],
      employeeGroupPrinting: json['employee_group_printing'],
      isMainOrSingleEmployeePrinting: json['is_main_or_single_employee_printing'],
      noOfPrint: json['no_of_print'],
      enableOrderPrint: json['enable_order_print'],
      enableOrderKotPrint: json['enable_order_kot_print'],
    );
  }

  /// For API responses that only include id and counter_name (e.g. newSessionModal counter list).
  factory Counter.fromJsonMinimal(Map<String, dynamic> json) {
    return Counter(
      id: json['id'],
      counterName: json['counter_name'] ?? '',
      counterStatus: 0,
      counterIp: '',
      counterPrinter: '',
      printerName: 0,
      printerPort: '',
      receiptLang: '',
      counterWarehouseId: 0,
      counterItemCat: 0,
      counterCustomer: 0,
      counterVendor: 0,
      taxItem: 0,
      discountItem: 0,
      cashPaymentMethod: 0,
      counterDelivery: 0,
      posMachine: 0,
      kot: 0,
      branchId: 0,
      groupPrint: 0,
      posUom: 0,
      logoStatus: 0,
      businessProfile: 0,
      invoiceCounting: 0,
      enableEmployee: 0,
      employeeGroupPrinting: 0,
      isMainOrSingleEmployeePrinting: 0,
      noOfPrint: 0,
      enableOrderPrint: 0,
      enableOrderKotPrint: 0,
    );
  }
}