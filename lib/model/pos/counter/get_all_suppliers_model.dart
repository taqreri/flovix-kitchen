class GetAllSupplierModel {
  bool? success;
  String? message;
  String? redirect;
  List<SupplierData>? data;
  Pagination? pagination;

  GetAllSupplierModel(
      {this.success, this.message, this.redirect, this.data, this.pagination});

  GetAllSupplierModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <SupplierData>[];
      json['data'].forEach((v) {
        data!.add(SupplierData.fromJson(v));
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

class SupplierData {
  int? sno;
  String? supName;
  String? supAddress;
  String? mobile;
  int? openingBalance;
  dynamic branch;

  SupplierData(
      {this.sno,
      this.supName,
      this.supAddress,
      this.mobile,
      this.openingBalance,
      this.branch});

  SupplierData.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    supName = json['sup_name'];
    supAddress = json['sup_address'];
    mobile = json['mobile'];
    openingBalance = json['opening_balance'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sno'] = sno;
    data['sup_name'] = supName;
    data['sup_address'] = supAddress;
    data['mobile'] = mobile;
    data['opening_balance'] = openingBalance;
    data['branch'] = branch;
    return data;
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
