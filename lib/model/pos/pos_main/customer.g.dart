// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      customerId: (json['customer_id'] as num?)?.toInt(),
      customerName: json['customer_name'] as String?,
      customerEmail: json['customer_email'] as String?,
      isDefault: json['is_default'] as bool?,
      customerImg: json['customer_img'] as String?,
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'customer_name': instance.customerName,
      'customer_email': instance.customerEmail,
      'is_default': instance.isDefault,
      'customer_img': instance.customerImg,
    };
