class TimedEvents {
  TimedEvents({
      this.id, 
      this.name, 
      this.type, 
      this.amount, 
      this.branchIds, 
      this.productIds, 
      this.tagIds, 
      this.startDate, 
      this.endDate, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.startTime, 
      this.endTime, 
      this.priority,});

  TimedEvents.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    amount = json['amount'];
    branchIds = json['branch_ids'] != null ? json['branch_ids'].cast<String>() : [];
    productIds = json['product_ids'] != null ? json['product_ids'].cast<String>() : [];
    tagIds = json['tag_ids'] != null ? json['tag_ids'].cast<String>() : [];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    priority = json['priority'];
  }
  int? id;
  String? name;
  int? type;
  String? amount;
  List<String>? branchIds;
  List<String>? productIds;
  List<String>? tagIds;
  String? startDate;
  String? endDate;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? startTime;
  String? endTime;
  int? priority;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['amount'] = amount;
    map['branch_ids'] = branchIds;
    map['product_ids'] = productIds;
    map['tag_ids'] = tagIds;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['priority'] = priority;
    return map;
  }

}