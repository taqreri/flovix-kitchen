class GetCustomersModel {
  bool? success;
  String? message;
  String? redirect;
  List<Data>? data;

  GetCustomersModel({this.success, this.message, this.redirect, this.data});

  GetCustomersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? customerId;
  String? customerName;
  String? customerEmail;
  bool? isDefault;
  String? customerImg;

  Data(
      {this.customerId,
      this.customerName,
      this.customerEmail,
      this.isDefault,
      this.customerImg});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    isDefault = json['is_default'];
    customerImg = json['customer_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    data['customer_email'] = customerEmail;
    data['is_default'] = isDefault;
    data['customer_img'] = customerImg;
    return data;
  }
}
