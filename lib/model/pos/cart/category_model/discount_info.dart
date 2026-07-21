/// sno : 432
/// p_type : 8
/// p_branch_id : 0
/// b_profile_id : 0
/// sale_price : 30
/// sales_description : "Testing Testing Testing"
/// is_percentage : 0

  class DiscountInfo {
  DiscountInfo({
      this.sno, 
      this.pType, 
      this.pBranchId, 
      this.bProfileId, 
      this.salePrice, 
      this.salesDescription, 
      this.isPercentage,});

  DiscountInfo.fromJson(dynamic json) {
    sno = json['sno'];
    pType = json['p_type'];
    pBranchId = json['p_branch_id'];
    bProfileId = json['b_profile_id'];
    salePrice = json['sale_price'];
    salesDescription = json['sales_description'];
    isPercentage = json['is_percentage'];
  }
  int? sno;
  int? pType;
  int? pBranchId;
  int? bProfileId;
  var salePrice;
  String? salesDescription;
  int? isPercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['p_type'] = pType;
    map['p_branch_id'] = pBranchId;
    map['b_profile_id'] = bProfileId;
    map['sale_price'] = salePrice;
    map['sales_description'] = salesDescription;
    map['is_percentage'] = isPercentage;
    return map;
  }

}