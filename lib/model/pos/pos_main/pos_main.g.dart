// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PosMainImpl _$$PosMainImplFromJson(Map<String, dynamic> json) =>
    _$PosMainImpl(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PosMainImplToJson(_$PosMainImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
