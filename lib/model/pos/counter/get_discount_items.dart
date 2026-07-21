class GetAllDiscountItemModel {
  bool? success;
  String? message;
  String? redirect;
  PaginationData? data;

  GetAllDiscountItemModel(
      {this.success, this.message, this.redirect, this.data});

  GetAllDiscountItemModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    data = json['data'] != null ? PaginationData.fromJson(json['data']) : null;
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

class PaginationData {
  int? currentPage;
  List<GetDiscountItems>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  PaginationData(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  PaginationData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <GetDiscountItems>[];
      json['data'].forEach((v) {
        data!.add(GetDiscountItems.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class GetDiscountItems {
  int? sno;
  int? pType;
  dynamic salePrice;
  int? isPercentage;
  int? taxable;
  int? discountAccount;
  int? taxAccount;
  String? pName;
  String? salesDescription;
  int? ifPurchased;
  int? isDefault;

  GetDiscountItems({
    this.sno,
    this.pType,
    this.salePrice,
    this.isPercentage,
    this.taxable,
    this.discountAccount,
    this.taxAccount,
    this.pName,
    this.salesDescription,
    this.ifPurchased,
    this.isDefault,
  });

  factory GetDiscountItems.fromJson(Map<String, dynamic> json) {
    return GetDiscountItems(
      sno: json['sno'],
      pType: json['p_type'],
      salePrice: json['sale_price'],
      isPercentage: json['is_percentage'],
      taxable: json['taxable'],
      discountAccount: json['discount_account'],
      taxAccount: json['tax_account'],
      pName: json['p_name'],
      salesDescription: json['sales_description'],
      ifPurchased: json['if_purchased'],
      isDefault: json['is_default'],
    );
  }

  // Add empty constructor for orElse
  GetDiscountItems.empty() : this();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sno'] = sno;
    data['p_type'] = pType;
    data['sale_price'] = salePrice;
    data['is_percentage'] = isPercentage;
    data['taxable'] = taxable;
    data['discount_account'] = discountAccount;
    data['tax_account'] = taxAccount;
    data['p_name'] = pName;
    data['sales_description'] = salesDescription;
    data['if_purchased'] = ifPurchased;
    data['is_default'] = isDefault;
    return data;
  }

  // Add equality check
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is GetDiscountItems &&
              runtimeType == other.runtimeType &&
              sno == other.sno;

  @override
  int get hashCode => sno.hashCode;
}
class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
