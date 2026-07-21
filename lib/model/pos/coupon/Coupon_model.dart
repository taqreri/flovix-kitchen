class CouponModel {
  CouponModel({
      this.id, 
      this.coupenCode, 
      this.discountType, 
      this.discountValue, 
      this.maxDiscountAllowed, 
      this.minimumOrderAmount, 
      this.branchIds,
      this.productIds,
      this.productTags, 
      this.customerTags,});

  CouponModel.fromJson(dynamic json) {
    id = json['id'];
    coupenCode = json['coupen_code'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    maxDiscountAllowed = json['max_discount_allowed'];
    minimumOrderAmount = json['minimum_order_amount'];

    productIds = json['product_ids'] != null ? json['product_ids'].cast<String>() : [];
    branchIds = json['branch'] != null ? json['branch'].cast<String>() : [];
    productTags = json['product_tags'] != null ? json['product_tags'].cast<String>() : [];
    customerTags = json['customer_tags'] != null ? json['customer_tags'].cast<String>() : [];
  }
  int? id;
  String? coupenCode;
  String? discountType;
 var discountValue;
  var maxDiscountAllowed;
var minimumOrderAmount;
  List<String>? branchIds;
  List<String>? productIds;
  List<String>? productTags;
  List<String>? customerTags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['coupen_code'] = coupenCode;
    map['discount_type'] = discountType;
    map['discount_value'] = discountValue;
    map['max_discount_allowed'] = maxDiscountAllowed;
    map['minimum_order_amount'] = minimumOrderAmount;

    map['customer_tags'] = customerTags;
    return map;
  }

}