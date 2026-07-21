// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_category.freezed.dart';
part 'product_category.g.dart';

@freezed
class ProductCategory with _$ProductCategory {
  factory ProductCategory({
    @JsonKey(name: 'cat_id') int? catId,
    @JsonKey(name: 'cat_label') String? catLabel,
    @JsonKey(name: 'cat_label_ar') String? catLabelAr,
    @JsonKey(name: 'cat_image_link') String? catImageLink,
    @JsonKey(name: 'is_default') bool? isDefault,
    @JsonKey(name: 'branch_id') int? branchId,
  }) = _ProductCategory;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);
}
