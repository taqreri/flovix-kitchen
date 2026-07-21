// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      sno: (json['sno'] as num?)?.toInt(),
      salesDescription: json['sales_description'] as String?,
      variationText: json['variation_text'],
      itemImage: json['item_image'] as String?,
      barCode: json['bar_code'] as String?,
      salePrice: (json['sale_price'] as num?)?.toInt(),
      costPrice: (json['cost_price'] as num?)?.toInt(),
      variationsCount: (json['variations_count'] as num?)?.toInt(),
      menuItem: json['menu_item'] as List<dynamic>?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'sno': instance.sno,
      'sales_description': instance.salesDescription,
      'variation_text': instance.variationText,
      'item_image': instance.itemImage,
      'bar_code': instance.barCode,
      'sale_price': instance.salePrice,
      'cost_price': instance.costPrice,
      'variations_count': instance.variationsCount,
      'menu_item': instance.menuItem,
    };
