import 'dart:developer';

/// sno : 73
/// name : "POS80-Mobile"
/// branch_sno : 1
/// is_active : 1
/// available_printer : "any"
/// printer_type : "network"
/// product_id : "1234"
/// vendor_id : "1234"
/// ip_address : "192.168.1.20"
/// printer_port : "9100"
/// is_app : 1

class CounterPrinter {
  CounterPrinter({
      this.sno, 
      this.name, 
      this.branchSno, 
      this.isActive, 
      this.availablePrinter, 
      this.printerType, 
      this.productId, 
      this.vendorId, 
      this.ipAddress, 
      this.printerPort, 
      this.isApp,});

  CounterPrinter.fromJson(dynamic json) {
    sno = json['sno'];
        name = json['name'];
    branchSno = json['branch_sno'];
   isActive = json['is_active'];
    availablePrinter = json['available_printer'];
    printerType = json['printer_type'];
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    ipAddress = json['ip_address'];

    printerPort = json['printer_port'];
    isApp = json['is_app'];
  }
  int? sno;
  String? name;
  int? branchSno;
  int? isActive;
  String? availablePrinter;
  String? printerType;
  String? productId;
  String? vendorId;
  String? ipAddress;
  String? printerPort;
  int? isApp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['name'] = name;
    map['branch_sno'] = branchSno;
    map['is_active'] = isActive;
    map['available_printer'] = availablePrinter;
    map['printer_type'] = printerType;
    map['product_id'] = productId;
    map['vendor_id'] = vendorId;
    map['ip_address'] = ipAddress;
    map['printer_port'] = printerPort;
    map['is_app'] = isApp;
    return map;
  }

}