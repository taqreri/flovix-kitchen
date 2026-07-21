// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductCategoryImpl _$$ProductCategoryImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductCategoryImpl(
      catId: (json['cat_id'] as num?)?.toInt(),
      catLabel: json['cat_label'] as String?,
      catLabelAr: json['cat_label_ar'] as String?,
      catImageLink: json['cat_image_link'] as String?,
      isDefault: json['is_default'] as bool?,
      branchId: (json['branch_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProductCategoryImplToJson(
        _$ProductCategoryImpl instance) =>
    <String, dynamic>{
      'cat_id': instance.catId,
      'cat_label': instance.catLabel,
      'cat_label_ar': instance.catLabelAr,
      'cat_image_link': instance.catImageLink,
      'is_default': instance.isDefault,
      'branch_id': instance.branchId,
    };
