class CouponCounterModel {
  CouponCounterModel({
      this.id, 
      this.coupenCode, 
      this.discountValue, 
      this.validCycle, 
      this.fromDate, 
      this.toDate, 
      this.status, 
      this.coupenQty, 
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.discountType, 
      this.maxDiscountAllowed, 
      this.minimumOrderAmount, 
      this.products, 
      this.productTags, 
      this.customerTags, 
      this.branches,});

  CouponCounterModel.fromJson(dynamic json) {
    id = json['id'];
    coupenCode = json['coupen_code'];
    discountValue = json['discount_value'];
    validCycle = json['valid_cycle'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    status = json['status'];
    coupenQty = json['coupen_qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    discountType = json['discount_type'];
    maxDiscountAllowed = json['max_discount_allowed'];
    minimumOrderAmount = json['minimum_order_amount'];

    products=  json['products'] != null ? json['products'].cast<String>() : [];
   // productTags = json['product_tags'] != null ? json['product_tags'].cast<String>() : [];
    customerTags = json['customer_tags'] != null ? json['customer_tags'].cast<String>() : [];
    branches = json['branches'] != null ? json['branches'].cast<String>() : [];
  }
  int? id;
  String? coupenCode;
  String? discountValue;
  int? validCycle;
  String? fromDate;
  String? toDate;
  int? status;
  int? coupenQty;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  String? discountType;
  String? maxDiscountAllowed;
  String? minimumOrderAmount;
  List<String>? products;
  List<int>? productTags;
  List<String>? customerTags;
  List<String>? branches;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['coupen_code'] = coupenCode;
    map['discount_value'] = discountValue;
    map['valid_cycle'] = validCycle;
    map['from_date'] = fromDate;
    map['to_date'] = toDate;
    map['status'] = status;
    map['coupen_qty'] = coupenQty;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['discount_type'] = discountType;
    map['max_discount_allowed'] = maxDiscountAllowed;
    map['minimum_order_amount'] = minimumOrderAmount;
    /*if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }**/
    map['product_tags'] = productTags;
    map['customer_tags'] = customerTags;
    map['branches'] = branches;
    return map;
  }

}