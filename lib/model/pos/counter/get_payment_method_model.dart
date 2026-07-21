class GetAllPayMethodModel {
  bool? success;
  String? message;
  String? redirect;
  List<PaymetMethodData>? data;
  Pagination? pagination;

  GetAllPayMethodModel(
      {this.success, this.message, this.redirect, this.data, this.pagination});

  GetAllPayMethodModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <PaymetMethodData>[];
      json['data'].forEach((v) {
        data!.add(PaymetMethodData.fromJson(v));
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

class PaymetMethodData {
  int? id;
  int? counter;
  String? payName;
  String? accountName;
  String? posStatus;
  bool? isDefault;

  PaymetMethodData(
      {this.id,
      this.counter,
      this.payName,
      this.accountName,
      this.posStatus,
      this.isDefault});

  PaymetMethodData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    counter = json['counter'];
    payName = json['pay_name'];
    accountName = json['account_name'];
    posStatus = json['pos_status'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['counter'] = counter;
    data['pay_name'] = payName;
    data['account_name'] = accountName;
    data['pos_status'] = posStatus;
    data['is_default'] = isDefault;
    return data;
  }
}

class Pagination {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  Null nextPageUrl;
  String? path;
  int? perPage;
  Null prevPageUrl;
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
