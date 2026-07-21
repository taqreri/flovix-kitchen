// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) {
  return _ProductCategory.fromJson(json);
}

/// @nodoc
mixin _$ProductCategory {
  @JsonKey(name: 'cat_id')
  int? get catId => throw _privateConstructorUsedError;
  @JsonKey(name: 'cat_label')
  String? get catLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'cat_label_ar')
  String? get catLabelAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'cat_image_link')
  String? get catImageLink => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  bool? get isDefault => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_id')
  int? get branchId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCategoryCopyWith<ProductCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCategoryCopyWith<$Res> {
  factory $ProductCategoryCopyWith(
          ProductCategory value, $Res Function(ProductCategory) then) =
      _$ProductCategoryCopyWithImpl<$Res, ProductCategory>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cat_id') int? catId,
      @JsonKey(name: 'cat_label') String? catLabel,
      @JsonKey(name: 'cat_label_ar') String? catLabelAr,
      @JsonKey(name: 'cat_image_link') String? catImageLink,
      @JsonKey(name: 'is_default') bool? isDefault,
      @JsonKey(name: 'branch_id') int? branchId});
}

/// @nodoc
class _$ProductCategoryCopyWithImpl<$Res, $Val extends ProductCategory>
    implements $ProductCategoryCopyWith<$Res> {
  _$ProductCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? catId = freezed,
    Object? catLabel = freezed,
    Object? catLabelAr = freezed,
    Object? catImageLink = freezed,
    Object? isDefault = freezed,
    Object? branchId = freezed,
  }) {
    return _then(_value.copyWith(
      catId: freezed == catId
          ? _value.catId
          : catId // ignore: cast_nullable_to_non_nullable
              as int?,
      catLabel: freezed == catLabel
          ? _value.catLabel
          : catLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      catLabelAr: freezed == catLabelAr
          ? _value.catLabelAr
          : catLabelAr // ignore: cast_nullable_to_non_nullable
              as String?,
      catImageLink: freezed == catImageLink
          ? _value.catImageLink
          : catImageLink // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductCategoryImplCopyWith<$Res>
    implements $ProductCategoryCopyWith<$Res> {
  factory _$$ProductCategoryImplCopyWith(_$ProductCategoryImpl value,
          $Res Function(_$ProductCategoryImpl) then) =
      __$$ProductCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cat_id') int? catId,
      @JsonKey(name: 'cat_label') String? catLabel,
      @JsonKey(name: 'cat_label_ar') String? catLabelAr,
      @JsonKey(name: 'cat_image_link') String? catImageLink,
      @JsonKey(name: 'is_default') bool? isDefault,
      @JsonKey(name: 'branch_id') int? branchId});
}

/// @nodoc
class __$$ProductCategoryImplCopyWithImpl<$Res>
    extends _$ProductCategoryCopyWithImpl<$Res, _$ProductCategoryImpl>
    implements _$$ProductCategoryImplCopyWith<$Res> {
  __$$ProductCategoryImplCopyWithImpl(
      _$ProductCategoryImpl _value, $Res Function(_$ProductCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? catId = freezed,
    Object? catLabel = freezed,
    Object? catLabelAr = freezed,
    Object? catImageLink = freezed,
    Object? isDefault = freezed,
    Object? branchId = freezed,
  }) {
    return _then(_$ProductCategoryImpl(
      catId: freezed == catId
          ? _value.catId
          : catId // ignore: cast_nullable_to_non_nullable
              as int?,
      catLabel: freezed == catLabel
          ? _value.catLabel
          : catLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      catLabelAr: freezed == catLabelAr
          ? _value.catLabelAr
          : catLabelAr // ignore: cast_nullable_to_non_nullable
              as String?,
      catImageLink: freezed == catImageLink
          ? _value.catImageLink
          : catImageLink // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductCategoryImpl implements _ProductCategory {
  _$ProductCategoryImpl(
      {@JsonKey(name: 'cat_id') this.catId,
      @JsonKey(name: 'cat_label') this.catLabel,
      @JsonKey(name: 'cat_label_ar') this.catLabelAr,
      @JsonKey(name: 'cat_image_link') this.catImageLink,
      @JsonKey(name: 'is_default') this.isDefault,
      @JsonKey(name: 'branch_id') this.branchId});

  factory _$ProductCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductCategoryImplFromJson(json);

  @override
  @JsonKey(name: 'cat_id')
  final int? catId;
  @override
  @JsonKey(name: 'cat_label')
  final String? catLabel;
  @override
  @JsonKey(name: 'cat_label_ar')
  final String? catLabelAr;
  @override
  @JsonKey(name: 'cat_image_link')
  final String? catImageLink;
  @override
  @JsonKey(name: 'is_default')
  final bool? isDefault;
  @override
  @JsonKey(name: 'branch_id')
  final int? branchId;

  @override
  String toString() {
    return 'ProductCategory(catId: $catId, catLabel: $catLabel, catLabelAr: $catLabelAr, catImageLink: $catImageLink, isDefault: $isDefault, branchId: $branchId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductCategoryImpl &&
            (identical(other.catId, catId) || other.catId == catId) &&
            (identical(other.catLabel, catLabel) ||
                other.catLabel == catLabel) &&
            (identical(other.catLabelAr, catLabelAr) ||
                other.catLabelAr == catLabelAr) &&
            (identical(other.catImageLink, catImageLink) ||
                other.catImageLink == catImageLink) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, catId, catLabel, catLabelAr,
      catImageLink, isDefault, branchId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductCategoryImplCopyWith<_$ProductCategoryImpl> get copyWith =>
      __$$ProductCategoryImplCopyWithImpl<_$ProductCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductCategoryImplToJson(
      this,
    );
  }
}

abstract class _ProductCategory implements ProductCategory {
  factory _ProductCategory(
      {@JsonKey(name: 'cat_id') final int? catId,
      @JsonKey(name: 'cat_label') final String? catLabel,
      @JsonKey(name: 'cat_label_ar') final String? catLabelAr,
      @JsonKey(name: 'cat_image_link') final String? catImageLink,
      @JsonKey(name: 'is_default') final bool? isDefault,
      @JsonKey(name: 'branch_id') final int? branchId}) = _$ProductCategoryImpl;

  factory _ProductCategory.fromJson(Map<String, dynamic> json) =
      _$ProductCategoryImpl.fromJson;

  @override
  @JsonKey(name: 'cat_id')
  int? get catId;
  @override
  @JsonKey(name: 'cat_label')
  String? get catLabel;
  @override
  @JsonKey(name: 'cat_label_ar')
  String? get catLabelAr;
  @override
  @JsonKey(name: 'cat_image_link')
  String? get catImageLink;
  @override
  @JsonKey(name: 'is_default')
  bool? get isDefault;
  @override
  @JsonKey(name: 'branch_id')
  int? get branchId;
  @override
  @JsonKey(ignore: true)
  _$$ProductCategoryImplCopyWith<_$ProductCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
