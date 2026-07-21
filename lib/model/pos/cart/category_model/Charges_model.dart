import 'TaxDetails.dart';

/// id : 1
/// name : "One Charge"
/// name_ar : "One Charge"
/// is_percent : true
/// is_open : false
/// value : 50
/// order_types : ["1","3","4"]
/// account_id : 24
/// tax_ids : ["1534"]
/// branch_ids : ["0"]
/// auto_applied : true
/// is_tax_exclusive : false
/// created_by : 616
/// updated_by : 616
/// created_at : "2025-12-18T06:51:26.000000Z"
/// updated_at : "2025-12-27T03:03:16.000000Z"
/// status : true
/// deleted_at : null
/// tax_details : [{"sno":1534,"p_tax_code":"0","p_code":"0","p_name":"102","p_reg_date":"2025-09-17","p_type":10,"tax_type":1,"is_percentage":1,"sales_description":"VAT 10%","sale_price":10,"tax_account":21,"p_branch_id":1,"b_profile_id":0,"client_sno":28,"company_sno":347,"user_sno":616}]

class ChargesModel {
  ChargesModel({
      this.id, 
      this.name, 
      this.nameAr, 
      this.isPercent, 
      this.isOpen, 
      this.productPrice,
      this.minimumCharge,
      this.value,
      this.productTags,
      this.orderTypes,
      this.accountId, 
      this.taxIds, 
      this.branchIds, 
      this.autoApplied, 
      this.isTaxExclusive, 
      this.createdBy, 
      this.updatedBy, 
      this.createdAt, 
      this.updatedAt, 
      this.status, 
      this.deletedAt, 
      this.taxDetails,});

  ChargesModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    isPercent = json['is_percent'];
    isOpen = json['is_open'];
    value = json['value'];
    productPrice = json['product_price'];
    minimumCharge = json['minimum_charge'];
    orderTypes = json['order_types'] != null ? json['order_types'].cast<String>() : [];
    accountId = json['account_id'];
    taxIds = json['tax_ids'] != null ? json['tax_ids'].cast<String>() : [];
    branchIds = json['branch_ids'] != null ? json['branch_ids'].cast<String>() : [];
    productTags = json['product_tags'] != null ? json['product_tags'].cast<String>() : [];
    autoApplied = json['auto_applied'];
    isTaxExclusive = json['is_tax_exclusive'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    isTobacco = json['is_tobacco'];
    deletedAt = json['deleted_at'];
    if (json['tax_details'] != null) {
      taxDetails = [];
      json['tax_details'].forEach((v) {
        taxDetails?.add(TaxDetails.fromJson(v));
      });
    }
  }
  int? isTobacco;
  int? id;
  String? name;
  String? nameAr;

  bool? isPercent;
  bool? isOpen;

  var value;
  var productPrice;
  var minimumCharge;
  List<String>? orderTypes;
  int? accountId;
  List<String>? taxIds;
  List<String>? branchIds;
  bool? autoApplied;
  bool? isTaxExclusive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  List<String>? productTags;
  String? updatedAt;
  bool? status;
  dynamic deletedAt;
  List<TaxDetails>? taxDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['product_tags'] = productTags;
    map['name_ar'] = nameAr;
    map['is_percent'] = isPercent;
    map['is_open'] = isOpen;
    map['value'] = value;
    map['product_price'] = productPrice;
    map['minimum_charge'] = minimumCharge;
    map['is_tobacco'] = isTobacco;
    map['order_types'] = orderTypes;
    map['account_id'] = accountId;
    map['tax_ids'] = taxIds;
    map['branch_ids'] = branchIds;
    map['auto_applied'] = autoApplied;
    map['is_tax_exclusive'] = isTaxExclusive;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['status'] = status;
    map['deleted_at'] = deletedAt;
    if (taxDetails != null) {
      map['tax_details'] = taxDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}