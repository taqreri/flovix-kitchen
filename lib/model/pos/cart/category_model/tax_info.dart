/// sno : 1586
/// p_tax_code : "0"
/// p_code : "0"
/// p_name : "standerd tax"
/// p_reg_date : "2024-10-05"
/// p_type : 10
/// tax_type : 1
/// is_percentage : 1
/// sales_description : ""
/// sale_price : 15
/// tax_account : 9
/// p_branch_id : 0
/// b_profile_id : 0
/// client_sno : 28
/// company_sno : 347
/// user_sno : 616

class TaxInfo {
  TaxInfo({
      this.sno, 
      this.pTaxCode, 
      this.pCode, 
      this.pName, 
      this.pRegDate, 
      this.pType, 
      this.taxType, 
      this.isPercentage, 
      this.salesDescription, 
      this.salePrice, 
      this.taxAccount, 
      this.pBranchId, 
      this.bProfileId, 
      this.clientSno, 
      this.companySno, 
      this.userSno,});

  TaxInfo.fromJson(dynamic json) {
    sno = json['sno'];
    pTaxCode = json['p_tax_code'];
    pCode = json['p_code'];
    pName = json['p_name'];
    pRegDate = json['p_reg_date'];
    pType = json['p_type'];
    taxType = json['tax_type'];
    isPercentage = json['is_percentage'];
    salesDescription = json['sales_description'];
    salePrice = json['sale_price'];
    taxAccount = json['tax_account'];
    pBranchId = json['p_branch_id'];
    bProfileId = json['b_profile_id'];
    clientSno = json['client_sno'];
    companySno = json['company_sno'];
    userSno = json['user_sno'];
  }
  int? sno;
  String? pTaxCode;
  String? pCode;
  String? pName;
  String? pRegDate;
  int? pType;
  int? taxType;
  int? isPercentage;
  String? salesDescription;
  var salePrice;
  int? taxAccount;
  int? pBranchId;
  int? bProfileId;
  int? clientSno;
  int? companySno;
  int? userSno;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['p_tax_code'] = pTaxCode;
    map['p_code'] = pCode;
    map['p_name'] = pName;
    map['p_reg_date'] = pRegDate;
    map['p_type'] = pType;
    map['tax_type'] = taxType;
    map['is_percentage'] = isPercentage;
    map['sales_description'] = salesDescription;
    map['sale_price'] = salePrice;
    map['tax_account'] = taxAccount;
    map['p_branch_id'] = pBranchId;
    map['b_profile_id'] = bProfileId;
    map['client_sno'] = clientSno;
    map['company_sno'] = companySno;
    map['user_sno'] = userSno;
    return map;
  }

}