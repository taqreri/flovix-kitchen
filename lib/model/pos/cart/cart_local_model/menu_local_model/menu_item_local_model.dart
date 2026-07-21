import 'dart:convert';

class MenuItemLocalModelNew {
  int? parentProductId;
  int? menuVariationId;
  int? parentProductPType;
  String? parentProductName;
  String? parentProductArabic;
  String? parentProductImage;
  int? parentProductTaxable;
  int? productItemId;
  int? productMenuVariationID;
  int? childProductIndex;
  int? parentProductTaxInclusive;
  dynamic parentProductUnitMeasure;
  String? productVariationName;
  String? productVariationArabic;
  String? productNameEnglish;
  String? productNameArabic;
  String? productSalesDescription;
  String? productImage;
  dynamic productUnitMeasure;
  dynamic productSalePrice;
  dynamic productCostPrice;
  String? productBarCode;
  String? productDefaultDiscount;
  dynamic productQuantity;
  dynamic productCalculatedDiscount;
  dynamic productCalculatedTax;
  dynamic productCounterDiscount;
  int? productStock;

  int? productIsPercentage;
  int? productIsTaxable;
  int? productIsTaxInclusive;
  int? productPType;
  int? isMultiChoice;
  int? isSingleChoice;
  int? isNoPrint;
  int? variationId;
  dynamic maxAllowQuantity;

  MenuItemLocalModelNew({
    this.parentProductId,
    this.menuVariationId,
    this.parentProductPType,
    this.productItemId,
    this.parentProductName,
    this.parentProductArabic,
    this.parentProductImage,
    this.parentProductTaxable,
    this.childProductIndex,
    this.parentProductTaxInclusive,
    this.parentProductUnitMeasure,
    this.productMenuVariationID,
    this.productVariationName,
    this.productVariationArabic,
    this.productNameEnglish,
    this.productNameArabic,
    this.productSalesDescription,
    this.productImage,
    this.productUnitMeasure,
    this.productSalePrice,
    this.productCostPrice,
    this.productBarCode,
    this.productDefaultDiscount,
    this.productQuantity,
    this.productCalculatedDiscount,
    this.productCalculatedTax,
    this.productCounterDiscount,
    this.productStock,
    this.productIsPercentage,
    this.productIsTaxable,
    this.productIsTaxInclusive,
    this.productPType,
    this.isMultiChoice,

    this.isSingleChoice,
    this.isNoPrint,
    this.variationId,
    this.maxAllowQuantity,
  });

  /// ---- toMap / fromMap ----
  Map<String, dynamic> toMap() {
    return {
      'parentProductId': parentProductId,
      'menuVariationId': menuVariationId,
      'parentProductPType': parentProductPType,
      'parentProductName': parentProductName,
      'parentProductArabic': parentProductArabic,
      'productItemId': productItemId,
      'childProductIndex': childProductIndex,
      'product_menu_variation_id': productMenuVariationID,
      'parentProductImage': parentProductImage,
      'parentProductTaxable': parentProductTaxable,
      'parentProductTaxInclusive': parentProductTaxInclusive,
      'parentProductUnitMeasure': parentProductUnitMeasure,
      'productVariationName': productVariationName,
      'productVariationArabic': productVariationArabic,
      'productNameEnglishMenu': productNameEnglish,
      'productNameArabicMenu': productNameArabic,
      'productSalesDescription': productSalesDescription,
      'productImageMenu': productImage,
      'productUnitMeasure': productUnitMeasure,
      'productSalePrice': productSalePrice,
      'productCostPrice': productCostPrice,
      'productBarCode': productBarCode,
      'productDefaultDiscount': productDefaultDiscount,
      'productQuantity': productQuantity,
      'productCalculatedDiscount': productCalculatedDiscount,
      'productCounterTax': productCalculatedTax,
      'productCounterDiscount': productCounterDiscount,
      'productStock': productStock,
      'productIsPercentage': productIsPercentage,
      'productIsTaxable': productIsTaxable,
      'productIsTaxInclusive': productIsTaxInclusive,
      'productPType': productPType,
      'isMultiChoice': isMultiChoice,
      'isSingleChoice': isSingleChoice,
      'isNoPrint': isNoPrint,
      'variationId': variationId,
      'maxAllowQuantity': maxAllowQuantity,
    };
  }

  factory MenuItemLocalModelNew.fromMap(Map<String, dynamic> map) {
    int? _asInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is double) return v.toInt();
      if (v is String) return int.tryParse(v);
      return null;
    }
    return MenuItemLocalModelNew(
      productItemId: _asInt(map['productItemId']),
      menuVariationId: _asInt(map['menuVariationId']),
      parentProductId: _asInt(map['parentProductId']),
      childProductIndex: _asInt(map['childProductIndex']),
      productMenuVariationID: _asInt(map['product_menu_variation_id']),
      parentProductPType: _asInt(map['parentProductPType']),
      parentProductName: map['parentProductName'] as String?,
      parentProductArabic: map['parentProductArabic'] as String?,
      parentProductImage: map['parentProductImage'] as String?,
      parentProductTaxable: _asInt(map['parentProductTaxable']),
      parentProductTaxInclusive: _asInt(map['parentProductTaxInclusive']),
      parentProductUnitMeasure: map['parentProductUnitMeasure'],
      productVariationName: map['productVariationName'] as String?,
      productVariationArabic: map['productVariationArabic'] as String?,
      productNameEnglish: map['productNameEnglishMenu'] as String?,
      productNameArabic: map['productNameArabicMenu'] as String?,
      productSalesDescription: map['productSalesDescription'] as String?,
      productImage: map['productImageMenu'] as String?,
      productUnitMeasure: map['productUnitMeasure'],
      productSalePrice: map['productSalePrice'],
      productCostPrice: map['productCostPrice'],
      productBarCode: map['productBarCode'] as String?,
      productDefaultDiscount: map['productDefaultDiscount'] as String?,
      productQuantity: map['productQuantity'],
      productCalculatedDiscount: map['productCalculatedDiscount'],
      productCalculatedTax: map['productCounterTax'],
      productCounterDiscount: map['productCounterDiscount'],
      productStock: _asInt(map['productStock']),
      productIsPercentage: _asInt(map['productIsPercentage']),
      productIsTaxable: _asInt(map['productIsTaxable']),
      productIsTaxInclusive: _asInt(map['productIsTaxInclusive']),
      productPType: _asInt(map['productPType']),
      isMultiChoice: _asInt(map['isMultiChoice']),
      isSingleChoice: _asInt(map['isSingleChoice']),

      isNoPrint: _asInt(map['isNoPrint']),
      variationId: _asInt(map['variationId']),
      maxAllowQuantity: map['maxAllowQuantity'],
    );

  }

  /// ---- toJson / fromJson ----
  String toJson() => json.encode(toMap());

  factory MenuItemLocalModelNew.fromJson(String source) =>
      MenuItemLocalModelNew.fromMap(json.decode(source) as Map<String, dynamic>);

  /// ---- toString ----
  @override
  String toString() {
    return 'MenuItemLocalModel('
        'parentProductId: $parentProductId, '
        'menuVariationId: $menuVariationId, '
        'parentProductPType: $parentProductPType, '
        'parentProductName: $parentProductName, '
        'parentProductArabic: $parentProductArabic, '
        'parentProductImage: $parentProductImage, '
        'parentProductTaxable: $parentProductTaxable, '
        'parentProductTaxInclusive: $parentProductTaxInclusive, '
        'parentProductUnitMeasure: $parentProductUnitMeasure, '
        'productVariationName: $productVariationName, '
        'productVariationArabic: $productVariationArabic, '
        'productNameEnglishMenu: $productNameEnglish, '
        'productNameArabicMenu: $productNameArabic, '
        'productImageMenu: $productImage, '
        'productUnitMeasure: $productUnitMeasure, '
        'productItemId: $productItemId, '
        'productSalePrice: $productSalePrice, '
        'productCostPrice: $productCostPrice, '
        'productBarCode: $productBarCode, '
        'productDefaultDiscount: $productDefaultDiscount, '
        'productQuantity: $productQuantity, '
        'productCalculatedDiscount: $productCalculatedDiscount, '
        'productCounterTax: $productCalculatedTax, '
        'productCounterDiscount: $productCounterDiscount, '
        'productStock: $productStock, '
        'productIsPercentage: $productIsPercentage, '
        'productIsTaxable: $productIsTaxable, '
        'productIsTaxInclusive: $productIsTaxInclusive, '
        'productPType: $productPType, '
        'product_menu_variation_id: $productMenuVariationID, '
        'isMultiChoice: $isMultiChoice, '
        'isSingleChoice: $isSingleChoice, '
        'isNoPrint: $isNoPrint, '
        'variationId: $variationId, '
        'childProductIndex: $childProductIndex, '
        'maxAllowQuantity: $maxAllowQuantity'
        ')';
  }
}
