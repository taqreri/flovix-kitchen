/// sno : 8
/// shipping_name : "Dine In"
/// shipping_description : "{\"description_ar\": null, \"description_en\": \"\"}"
/// is_ecommerce : 1
/// pos_status : 1
/// account_id : 29
/// icon : "https://taqreri.com/sys_images/sv.png"
/// is_default : true

class ShippingModel {
  ShippingModel({
      this.sno, 
      this.shippingName, 
      this.shippingDescription, 
      this.isEcommerce, 
      this.posStatus, 
      this.accountId, 
      this.icon, 
      this.isDefault,});

  ShippingModel.fromJson(dynamic json) {
    sno = json['sno'];
    shippingName = json['shipping_name'];
    shippingDescription = json['shipping_description'];
    isEcommerce = json['is_ecommerce'];
    posStatus = json['pos_status'];
    accountId = json['account_id'];
    icon = json['icon'];
    isDefault = json['is_default'];
  }
  int? sno;
  String? shippingName;
  String? shippingDescription;
  int? isEcommerce;
  int? posStatus;
  int? accountId;
  String? icon;
  bool? isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['shipping_name'] = shippingName;
    map['shipping_description'] = shippingDescription;
    map['is_ecommerce'] = isEcommerce;
    map['pos_status'] = posStatus;
    map['account_id'] = accountId;
    map['icon'] = icon;
    map['is_default'] = isDefault;
    return map;
  }

}