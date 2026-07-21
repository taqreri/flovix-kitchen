class GetPrintersModel {
  bool? success;
  String? message;
  String? redirect;
  List<PrinterData>? data;
  Pagination? pagination;

  GetPrintersModel(
      {this.success, this.message, this.redirect, this.data, this.pagination});

  GetPrintersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <PrinterData>[];
      json['data'].forEach((v) {
        data!.add(PrinterData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['redirect'] = redirect;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class PrinterData {
  int? sno;
  String? name;
  int? branchSno;
  int? isActive;
  String? availablePrinter;
  String? printerType;
  String? productId;
  String? vendorId;
  String? ipAddress;
  int? printerPort;
  int? isApp;

  PrinterData({
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
    this.isApp,
  });

  factory PrinterData.fromJson(Map<String, dynamic> json) {
    return PrinterData(
      sno: json['sno'] is int ? json['sno'] : int.tryParse(json['sno'].toString()) ?? 0,
      name: json['name']?.toString(),
      branchSno: json['branch_sno'] is int ? json['branch_sno'] : int.tryParse(json['branch_sno'].toString()) ?? 0,
      isActive: json['is_active'] is int ? json['is_active'] : int.tryParse(json['is_active'].toString()) ?? 0,
      availablePrinter: json['available_printer']?.toString(),
      printerType: json['printer_type']?.toString(),
      productId: json['product_id'] ??"",
      vendorId: json['vendor_id'] ??"",
      ipAddress: json['ip_address']?.toString(),
      printerPort: json['printer_port'] is int ? json['printer_port'] : int.tryParse(json['printer_port'].toString()) ?? 0,
      isApp: json['is_app'] is int ? json['is_app'] : int.tryParse(json['is_app'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sno': sno,
      'name': name,
      'branch_sno': branchSno,
      'is_active': isActive,
      'available_printer': availablePrinter,
      'printer_type': printerType,
      'product_id': productId,
      'vendor_id': vendorId,
      'ip_address': ipAddress,
      'printer_port': printerPort,
      'is_app': isApp,
    };
  }

  @override
  String toString() {
    return '''
PrinterData:
  sno: $sno
  name: $name
  branchSno: $branchSno
  isActive: $isActive
  availablePrinter: $availablePrinter
  printerType: $printerType
  productId: $productId
  vendorId: $vendorId
  ipAddress: $ipAddress
  printerPort: $printerPort
  isApp: $isApp
''';
  }
}

class Pagination {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;

  Pagination(
      {this.currentPage,
      this.firstPageUrl,
      this.from,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    return data;
  }
}
