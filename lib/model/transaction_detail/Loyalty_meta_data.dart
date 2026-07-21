class LoyaltyMetaData {
  LoyaltyMetaData({
      this.loyaltyRate, 
      this.loyaltyDiscount,});

  LoyaltyMetaData.fromJson(dynamic json) {
    loyaltyRate = json['loyalty_rate']??"";
    loyaltyDiscount = json['loyalty_discount']??"";
  }
  var loyaltyRate;
  var loyaltyDiscount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['loyalty_rate'] = loyaltyRate;
    map['loyalty_discount'] = loyaltyDiscount;
    return map;
  }

}