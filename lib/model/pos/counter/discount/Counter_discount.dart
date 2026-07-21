/// sno : 1573
/// p_type : 8
/// sale_price : 14
/// is_percentage : 1
/// taxable : 1
/// discount_account : 6
/// tax_account : 0
/// p_name : "discount 14"
/// sales_description : "14"
/// if_purchased : 0
/// is_default : 1

class CounterDiscount {
  CounterDiscount({
      this.sno, 
      this.pType, 
      this.salePrice, 
      this.isPercentage, 
      this.taxable, 
      this.discountAccount, 
      this.taxAccount, 
      this.pName, 
      this.salesDescription, 
      this.ifPurchased, 
      this.isDefault,});

  CounterDiscount.fromJson(dynamic json) {
    sno = json['sno'];
   // pType = json['p_type'];
    salePrice = json['sale_price'];
    isPercentage = json['is_percentage'];
   // taxable = json['taxable'];
    discountAccount = json['discount_account'];
   // taxAccount = json['tax_account'];
   pName = json['p_name'];
   // salesDescription = json['sales_description'];
   // ifPurchased = json['if_purchased'];
   // isDefault = json['is_default'];
  }
  int? sno;
  int? pType;
  var salePrice;
  int? isPercentage;
  int? taxable;
  int? discountAccount;
  int? taxAccount;
  String? pName;
  String? salesDescription;
  int? ifPurchased;
  int? isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['p_type'] = pType;
    map['sale_price'] = salePrice;
    map['is_percentage'] = isPercentage;
    map['taxable'] = taxable;
    map['discount_account'] = discountAccount;
    map['tax_account'] = taxAccount;
    map['p_name'] = pName;
    map['sales_description'] = salesDescription;
    map['if_purchased'] = ifPurchased;
    map['is_default'] = isDefault;
    return map;
  }

  // Add equality check based on sno (unique identifier)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterDiscount &&
          runtimeType == other.runtimeType &&
          sno == other.sno;

  @override
  int get hashCode => sno.hashCode;
}