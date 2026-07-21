/// id : 3
/// name : "offers"
/// cus_tags : "1"
/// account_id : 11
/// expiry_number : 30
/// expiry_type : "month"
/// collection_fector : 10
/// minimum_total_spent : 100
/// priority : 1
/// status : 1
/// created_at : "2025-05-14 17:39:38"
/// created_by : 1
/// updated_at : null
/// updated_by : 0
/// points_rate : 0
/// minimum_points_usage : 0
/// points_availability_minutes : 0

class LoyaltyPointsModel {
  LoyaltyPointsModel({
      this.id, 
      this.name, 
      this.cusTags, 
      this.accountId, 
      this.expiryNumber, 
      this.expiryType, 
      this.collectionFector, 
      this.minimumTotalSpent, 
      this.priority, 
      this.status, 
      this.createdAt, 
      this.createdBy, 
      this.updatedAt, 
      this.updatedBy, 
      this.pointsRate, 
      this.minimumPointsUsage, 
      this.pointsAvailabilityMinutes,});

  LoyaltyPointsModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    cusTags = json['cus_tags'];
    accountId = json['account_id'];
    expiryNumber = json['expiry_number'];
    expiryType = json['expiry_type'];
    collectionFector = json['collection_fector'];
    minimumTotalSpent = json['minimum_total_spent'];
    priority = json['priority'];
    status = json['status'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    pointsRate = json['points_rate'];
    minimumPointsUsage = json['minimum_points_usage'];
    pointsAvailabilityMinutes = json['points_availability_minutes'];
  }
  int? id;
  String? name;
  String? cusTags;
  int? accountId;
  int? expiryNumber;
  String? expiryType;
  int? collectionFector;
  int? minimumTotalSpent;
  int? priority;
  int? status;
  String? createdAt;
  int? createdBy;
  dynamic updatedAt;
  int? updatedBy;
  int? pointsRate;
  int? minimumPointsUsage;
  int? pointsAvailabilityMinutes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['cus_tags'] = cusTags;
    map['account_id'] = accountId;
    map['expiry_number'] = expiryNumber;
    map['expiry_type'] = expiryType;
    map['collection_fector'] = collectionFector;
    map['minimum_total_spent'] = minimumTotalSpent;
    map['priority'] = priority;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['created_by'] = createdBy;
    map['updated_at'] = updatedAt;
    map['updated_by'] = updatedBy;
    map['points_rate'] = pointsRate;
    map['minimum_points_usage'] = minimumPointsUsage;
    map['points_availability_minutes'] = pointsAvailabilityMinutes;
    return map;
  }

}