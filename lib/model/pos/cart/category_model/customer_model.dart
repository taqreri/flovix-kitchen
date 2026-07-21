/// customer_id : 56
/// customer_name : "ASIF KHAN"
/// customer_email : ""
/// is_default : true
/// customer_img : "https://taqreri.com/sys_images/sv.png"

class CustomerModel {
  CustomerModel({
      this.customerId, 
      this.customerName, 
      this.customerEmail, 
      this.address,
      this.latitude,
      this.longitude,
      this.isDefault,
      this.mobile,
      this.customerImg,});

  CustomerModel.fromJson(dynamic json) {
    customerId = json['customer_id']??json["sno"]??0;
    customerName = json['customer_name']??json['cus_name']??"n/a";
    address = json['cus_shipping_address']??"n/a";
    customerEmail = json['customer_email']??json['cus_email']??"n/a";
    mobile = json['mobile']??"n/a";
    longitude = json['longitude']??"0.0";
    latitude = json['latitude']??"0.0";
    isDefault = json['is_default'];
    customerImg = json['cus_img']??json['customer_img']??"n/a";
  }
  int? customerId;
  String? customerName;
  String? customerEmail;
  String? address;
  String? longitude;
  String? latitude;
  String? mobile;
  bool? isDefault;
  String? customerImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = mobile;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['customer_id'] = customerId;
    map['customer_name'] = customerName;
    map['customer_email'] = customerEmail;
    map['is_default'] = isDefault;
    map['cus_img'] = customerImg;
    return map;
  }

}