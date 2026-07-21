import 'dart:convert';

class GetAllCounterModel {
  bool? success;
  String? message;
  String? redirect;
  List<CounterData>? data;
  Pagination? pagination;

  GetAllCounterModel(
      {this.success, this.message, this.redirect, this.data, this.pagination});

  GetAllCounterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <CounterData>[];
      json['data'].forEach((v) {
        data!.add(CounterData.fromJson(v));
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

class CounterData {
  int? id;
  String? counterName;
  String? printerName;
  String? warehouse;

  CounterData({this.id, this.counterName, this.printerName, this.warehouse});

  CounterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    counterName = json['counter_name'];
    printerName = json['printer_name'];
    warehouse = json['warehouse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['counter_name'] = counterName;
    data['printer_name'] = printerName;
    data['warehouse'] = warehouse;
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

class GetAllShippingMethodModel {
  bool? success;
  String? message;
  String? redirect;
  List<ShippingMethodData>? data;
  PaginationA? pagination;

  GetAllShippingMethodModel({
    this.success,
    this.message,
    this.redirect,
    this.data,
    this.pagination,
  });

  GetAllShippingMethodModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <ShippingMethodData>[];
      json['data'].forEach((v) {
        data!.add(ShippingMethodData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? PaginationA.fromJson(json['pagination'])
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

class ShippingMethodData {
  int? sno;
  String? shippingName;
  ShippingDescription? shippingDescription;
  int? isEcommerce;
  int? posStatus;
  int? accountId;
  String? icon;
  bool? isDefault;

  ShippingMethodData({
    this.sno,
    this.shippingName,
    this.shippingDescription,
    this.isEcommerce,
    this.posStatus,
    this.accountId,
    this.icon,
    this.isDefault,
  });

  ShippingMethodData.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    shippingName = json['shipping_name'];
    shippingDescription = json['shipping_description'] != null
        ? ShippingDescription.fromJson(jsonDecode(json['shipping_description']))
        : null;
    isEcommerce = json['is_ecommerce'];
    posStatus = json['pos_status'];
    accountId = json['account_id'];
    icon = json['icon'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sno'] = sno;
    data['shipping_name'] = shippingName;
    data['shipping_description'] = jsonEncode(shippingDescription?.toJson());
    data['is_ecommerce'] = isEcommerce;
    data['pos_status'] = posStatus;
    data['account_id'] = accountId;
    data['icon'] = icon;
    data['is_default'] = isDefault;
    return data;
  }
}

class ShippingDescription {
  String? descriptionAr;
  String? descriptionEn;

  ShippingDescription({
    this.descriptionAr,
    this.descriptionEn,
  });

  ShippingDescription.fromJson(Map<String, dynamic> json) {
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description_ar'] = descriptionAr;
    data['description_en'] = descriptionEn;
    return data;
  }
}

class PaginationA {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;

  PaginationA({
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  });

  PaginationA.fromJson(Map<String, dynamic> json) {
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

