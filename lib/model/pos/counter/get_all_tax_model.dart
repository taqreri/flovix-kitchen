class GetAllTaxModel {
  bool? success;
  String? message;
  String? redirect;
  List<TaxData>? data;

  GetAllTaxModel({
    this.success,
    this.message,
    this.redirect,
    this.data,
  });

  GetAllTaxModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <TaxData>[];
      json['data'].forEach((v) {
        data!.add(TaxData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['redirect'] = redirect;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaxData {
  int? sno;
  String? pTaxCode;
  String? pCode;
  String? pName;
  String? pRegDate;
  int? pType;
  int? taxType;
  int? isPercentage;
  String? salesDescription;
  int? salePrice;
  int? taxAccount;
  int? pBranchId;
  int? bProfileId;
  int? clientSno;
  int? companySno;
  int? userSno;

  TaxData({
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
    this.userSno,
  });

  factory TaxData.fromJson(Map<String, dynamic> json) {
    return TaxData(
      sno: json['sno'],
      pTaxCode: json['p_tax_code'],
      pCode: json['p_code'],
      pName: json['p_name'],
      pRegDate: json['p_reg_date'],
      pType: json['p_type'],
      taxType: json['tax_type'],
      isPercentage: json['is_percentage'],
      salesDescription: json['sales_description'],
      salePrice: json['sale_price'],
      taxAccount: json['tax_account'],
      pBranchId: json['p_branch_id'],
      bProfileId: json['b_profile_id'],
      clientSno: json['client_sno'],
      companySno: json['company_sno'],
      userSno: json['user_sno'],
    );
  }

  // Add empty constructor for orElse
  TaxData.empty() : this();

  Map<String, dynamic> toJson() {
    return {
      'sno': sno,
      'p_tax_code': pTaxCode,
      'p_code': pCode,
      'p_name': pName,
      'p_reg_date': pRegDate,
      'p_type': pType,
      'tax_type': taxType,
      'is_percentage': isPercentage,
      'sales_description': salesDescription,
      'sale_price': salePrice,
      'tax_account': taxAccount,
      'p_branch_id': pBranchId,
      'b_profile_id': bProfileId,
      'client_sno': clientSno,
      'company_sno': companySno,
      'user_sno': userSno,
    };
  }

  // Add equality check
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaxData &&
              runtimeType == other.runtimeType &&
              sno == other.sno;

  @override
  int get hashCode => sno.hashCode;
}
