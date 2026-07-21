class LoyaltyPointDetailModel {
  LoyaltyPointDetailModel({
      this.points, 
      this.pointsRate, 
      this.value, 
      this.minimumSpent,});

  LoyaltyPointDetailModel.fromJson(dynamic json) {
    points = json['points'];
    pointsRate = json['points_rate'];
    value = json['value'];
    minimumSpent = json['minimum_spent'];
  }
  var points;
  var pointsRate;
  var value;
  var minimumSpent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['points'] = points;
    map['points_rate'] = pointsRate;
    map['value'] = value;
    map['minimum_spent'] = minimumSpent;
    return map;
  }

}