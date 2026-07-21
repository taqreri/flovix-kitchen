class PromotionModel {
  PromotionModel({
      this.id, 
      this.name, 
      this.startDate, 
      this.endDate, 
      this.startTime, 
      this.endTime, 
      this.priority, 
      this.priorityRule, 
      this.promotionType, 
      this.customerCondition, 
      this.conditionValue, 

      this.actionType,
      this.branchIds,
      this.discountType,
      this.discountAmount, 
      this.maxDiscountAllowed, 
      this.numberOfProducts, 
      this.fixedAmount, 
      this.productsIds, 
      this.productTagsIds, 
      this.customerTagsIds, 
      this.appliesOnDays, 
      this.appliesOnOrderTypes,});

  PromotionModel.fromJson(dynamic json) {
    id = json['id']??-1;
    name = json['name']??"";
    startDate = json['start_date']??"";
    endDate = json['end_date']??"";
    startTime = json['start_time']??"";
    endTime = json['end_time']??"";
    priority = json['priority']??-2;
    priorityRule = json['priority_rule']??"";
    promotionType = json['promotion_type']??"";
    customerCondition = json['customer_condition']??"";
  conditionValue = json['condition_value']??-1;
    actionType = json['action_type']??"";
    discountType = json['discount_type']??"";
    discountAmount = json['discount_amount'];
    maxDiscountAllowed = json['max_discount_allowed'];
    numberOfProducts = json['number_of_products'];
    fixedAmount = json['fixed_amount'];
    productsIds = json['products_ids'] != null ? json['products_ids'].cast<String>() : [];
    branchIds = json['branch_ids'] != null ? json['branch_ids'].cast<String>() : [];
    productTagsIds = json['product_tags_ids'] != null ? json['product_tags_ids'].cast<String>() : [];
    customerTagsIds = json['customer_tags_ids'] != null ? json['customer_tags_ids'].cast<String>() : [];
    appliesOnDays = json['applies_on_days'] != null ? json['applies_on_days'].cast<String>() : [];
    appliesOnOrderTypes = json['applies_on_order_types'] != null ? json['applies_on_order_types'].cast<String>() : [];
  }
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  int? priority;
  String? priorityRule;
  String? promotionType;
  String? customerCondition;
var conditionValue;
  String? actionType;
  String? discountType;
  var discountAmount;
  var maxDiscountAllowed;
  int? numberOfProducts;
  var fixedAmount;
  List<String>? productsIds;
  List<String>? productTagsIds;
  List<String>? branchIds;
  List<String>? customerTagsIds;
  List<String>? appliesOnDays;
  List<String>? appliesOnOrderTypes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['priority'] = priority;
    map['priority_rule'] = priorityRule;
    map['promotion_type'] = promotionType;
    map['customer_condition'] = customerCondition;
    map['condition_value'] = conditionValue;
    map['action_type'] = actionType;
    map['discount_type'] = discountType;
    map['discount_amount'] = discountAmount;
    map['max_discount_allowed'] = maxDiscountAllowed;
    map['number_of_products'] = numberOfProducts;
    map['fixed_amount'] = fixedAmount;
    map['products_ids'] = productsIds;
    map['product_tags_ids'] = productTagsIds;
    map['branch_ids'] = branchIds;
    map['customer_tags_ids'] = customerTagsIds;
    map['applies_on_days'] = appliesOnDays;
    map['applies_on_order_types'] = appliesOnOrderTypes;
    return map;
  }

}