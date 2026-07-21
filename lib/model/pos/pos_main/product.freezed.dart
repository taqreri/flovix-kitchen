// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  int? get sno => throw _privateConstructorUsedError;
  @JsonKey(name: 'sales_description')
  String? get salesDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'variation_text')
  dynamic get variationText => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_image')
  String? get itemImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'bar_code')
  String? get barCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_price')
  int? get salePrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'cost_price')
  int? get costPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'variations_count')
  int? get variationsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'menu_item')
  List<dynamic>? get menuItem => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {int? sno,
      @JsonKey(name: 'sales_description') String? salesDescription,
      @JsonKey(name: 'variation_text') dynamic variationText,
      @JsonKey(name: 'item_image') String? itemImage,
      @JsonKey(name: 'bar_code') String? barCode,
      @JsonKey(name: 'sale_price') int? salePrice,
      @JsonKey(name: 'cost_price') int? costPrice,
      @JsonKey(name: 'variations_count') int? variationsCount,
      @JsonKey(name: 'menu_item') List<dynamic>? menuItem});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sno = freezed,
    Object? salesDescription = freezed,
    Object? variationText = freezed,
    Object? itemImage = freezed,
    Object? barCode = freezed,
    Object? salePrice = freezed,
    Object? costPrice = freezed,
    Object? variationsCount = freezed,
    Object? menuItem = freezed,
  }) {
    return _then(_value.copyWith(
      sno: freezed == sno
          ? _value.sno
          : sno // ignore: cast_nullable_to_non_nullable
              as int?,
      salesDescription: freezed == salesDescription
          ? _value.salesDescription
          : salesDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      variationText: freezed == variationText
          ? _value.variationText
          : variationText // ignore: cast_nullable_to_non_nullable
              as dynamic,
      itemImage: freezed == itemImage
          ? _value.itemImage
          : itemImage // ignore: cast_nullable_to_non_nullable
              as String?,
      barCode: freezed == barCode
          ? _value.barCode
          : barCode // ignore: cast_nullable_to_non_nullable
              as String?,
      salePrice: freezed == salePrice
          ? _value.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as int?,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      variationsCount: freezed == variationsCount
          ? _value.variationsCount
          : variationsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      menuItem: freezed == menuItem
          ? _value.menuItem
          : menuItem // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? sno,
      @JsonKey(name: 'sales_description') String? salesDescription,
      @JsonKey(name: 'variation_text') dynamic variationText,
      @JsonKey(name: 'item_image') String? itemImage,
      @JsonKey(name: 'bar_code') String? barCode,
      @JsonKey(name: 'sale_price') int? salePrice,
      @JsonKey(name: 'cost_price') int? costPrice,
      @JsonKey(name: 'variations_count') int? variationsCount,
      @JsonKey(name: 'menu_item') List<dynamic>? menuItem});
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sno = freezed,
    Object? salesDescription = freezed,
    Object? variationText = freezed,
    Object? itemImage = freezed,
    Object? barCode = freezed,
    Object? salePrice = freezed,
    Object? costPrice = freezed,
    Object? variationsCount = freezed,
    Object? menuItem = freezed,
  }) {
    return _then(_$ProductImpl(
      sno: freezed == sno
          ? _value.sno
          : sno // ignore: cast_nullable_to_non_nullable
              as int?,
      salesDescription: freezed == salesDescription
          ? _value.salesDescription
          : salesDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      variationText: freezed == variationText
          ? _value.variationText
          : variationText // ignore: cast_nullable_to_non_nullable
              as dynamic,
      itemImage: freezed == itemImage
          ? _value.itemImage
          : itemImage // ignore: cast_nullable_to_non_nullable
              as String?,
      barCode: freezed == barCode
          ? _value.barCode
          : barCode // ignore: cast_nullable_to_non_nullable
              as String?,
      salePrice: freezed == salePrice
          ? _value.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as int?,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      variationsCount: freezed == variationsCount
          ? _value.variationsCount
          : variationsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      menuItem: freezed == menuItem
          ? _value._menuItem
          : menuItem // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  _$ProductImpl(
      {this.sno,
      @JsonKey(name: 'sales_description') this.salesDescription,
      @JsonKey(name: 'variation_text') this.variationText,
      @JsonKey(name: 'item_image') this.itemImage,
      @JsonKey(name: 'bar_code') this.barCode,
      @JsonKey(name: 'sale_price') this.salePrice,
      @JsonKey(name: 'cost_price') this.costPrice,
      @JsonKey(name: 'variations_count') this.variationsCount,
      @JsonKey(name: 'menu_item') final List<dynamic>? menuItem})
      : _menuItem = menuItem;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final int? sno;
  @override
  @JsonKey(name: 'sales_description')
  final String? salesDescription;
  @override
  @JsonKey(name: 'variation_text')
  final dynamic variationText;
  @override
  @JsonKey(name: 'item_image')
  final String? itemImage;
  @override
  @JsonKey(name: 'bar_code')
  final String? barCode;
  @override
  @JsonKey(name: 'sale_price')
  final int? salePrice;
  @override
  @JsonKey(name: 'cost_price')
  final int? costPrice;
  @override
  @JsonKey(name: 'variations_count')
  final int? variationsCount;
  final List<dynamic>? _menuItem;
  @override
  @JsonKey(name: 'menu_item')
  List<dynamic>? get menuItem {
    final value = _menuItem;
    if (value == null) return null;
    if (_menuItem is EqualUnmodifiableListView) return _menuItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Product(sno: $sno, salesDescription: $salesDescription, variationText: $variationText, itemImage: $itemImage, barCode: $barCode, salePrice: $salePrice, costPrice: $costPrice, variationsCount: $variationsCount, menuItem: $menuItem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.sno, sno) || other.sno == sno) &&
            (identical(other.salesDescription, salesDescription) ||
                other.salesDescription == salesDescription) &&
            const DeepCollectionEquality()
                .equals(other.variationText, variationText) &&
            (identical(other.itemImage, itemImage) ||
                other.itemImage == itemImage) &&
            (identical(other.barCode, barCode) || other.barCode == barCode) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.variationsCount, variationsCount) ||
                other.variationsCount == variationsCount) &&
            const DeepCollectionEquality().equals(other._menuItem, _menuItem));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sno,
      salesDescription,
      const DeepCollectionEquality().hash(variationText),
      itemImage,
      barCode,
      salePrice,
      costPrice,
      variationsCount,
      const DeepCollectionEquality().hash(_menuItem));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  factory _Product(
          {final int? sno,
          @JsonKey(name: 'sales_description') final String? salesDescription,
          @JsonKey(name: 'variation_text') final dynamic variationText,
          @JsonKey(name: 'item_image') final String? itemImage,
          @JsonKey(name: 'bar_code') final String? barCode,
          @JsonKey(name: 'sale_price') final int? salePrice,
          @JsonKey(name: 'cost_price') final int? costPrice,
          @JsonKey(name: 'variations_count') final int? variationsCount,
          @JsonKey(name: 'menu_item') final List<dynamic>? menuItem}) =
      _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  int? get sno;
  @override
  @JsonKey(name: 'sales_description')
  String? get salesDescription;
  @override
  @JsonKey(name: 'variation_text')
  dynamic get variationText;
  @override
  @JsonKey(name: 'item_image')
  String? get itemImage;
  @override
  @JsonKey(name: 'bar_code')
  String? get barCode;
  @override
  @JsonKey(name: 'sale_price')
  int? get salePrice;
  @override
  @JsonKey(name: 'cost_price')
  int? get costPrice;
  @override
  @JsonKey(name: 'variations_count')
  int? get variationsCount;
  @override
  @JsonKey(name: 'menu_item')
  List<dynamic>? get menuItem;
  @override
  @JsonKey(ignore: true)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
