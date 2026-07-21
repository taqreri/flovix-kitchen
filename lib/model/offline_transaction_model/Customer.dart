class Customer {
  Customer({
      this.cusName,});

  Customer.fromJson(dynamic json) {
    cusName = json['cus_name'];
  }
  String? cusName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cus_name'] = cusName;
    return map;
  }

}