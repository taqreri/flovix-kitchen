// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  factory Product({
    int? sno,
    @JsonKey(name: 'sales_description') String? salesDescription,
    @JsonKey(name: 'variation_text') dynamic variationText,
    @JsonKey(name: 'item_image') String? itemImage,
    @JsonKey(name: 'bar_code') String? barCode,
    @JsonKey(name: 'sale_price') int? salePrice,
    @JsonKey(name: 'cost_price') int? costPrice,
    @JsonKey(name: 'variations_count') int? variationsCount,
    @JsonKey(name: 'menu_item') List<dynamic>? menuItem,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
