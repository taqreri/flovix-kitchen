// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  factory Customer({
    @JsonKey(name: 'customer_id') int? customerId,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'customer_email') String? customerEmail,
    @JsonKey(name: 'is_default') bool? isDefault,
    @JsonKey(name: 'customer_img') String? customerImg,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
