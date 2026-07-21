import 'menu_variation_types_local_model.dart';

class MenuLocalModel {
  int? id;
  int? isTaxable;
  int? pType;
  String? productNameEnglish;
  String? productNameArabic;
  String? productSalesDescription;
  String? productImagePath;
  String? barCode;
  String? defaultDiscount;
  String? itemImage;
 List< MenuVariationTypesLocalModel>? menuVariationTypesLocalModel;

  // Constructor
  MenuLocalModel({
    this.id,
    this.isTaxable,
    this.pType,
    this.productNameEnglish,
    this.productNameArabic,
    this.productSalesDescription,
    this.productImagePath,
    this.barCode,
    this.defaultDiscount,
    this.itemImage,
    this.menuVariationTypesLocalModel,
  });

  // fromJson method: Converts JSON to a MenuLocalModel object
  factory MenuLocalModel.fromJson(Map<String, dynamic> json) {
    return MenuLocalModel(
      id: json['id'],
      isTaxable: json['taxable'],
      pType: json['p_type'],
      productNameEnglish: json['p_name'],
      productNameArabic: json['p_name_ar'],
      productSalesDescription: json['sales_description'],
      productImagePath: json['item_image'],
      barCode: json['bar_code'],
      defaultDiscount: json['default_discount'],
      itemImage: json['item_image'],
      menuVariationTypesLocalModel: json['menuVariationTypesLocalModel'] != null
          ? List<MenuVariationTypesLocalModel>.from(json['menuVariationTypesLocalModel']
          .map((v) => MenuVariationTypesLocalModel.fromJson(v)))
          : [],
     /* menuVariationTypesLocalModel: json['menuVariationTypesLocalModel'] != null
          ? MenuVariationTypesLocalModel.fromJson(json['menuVariationTypesLocalModel'])
          : null,**/
    );
  }

  // toJson method: Converts the MenuLocalModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taxable': isTaxable,
      'p_type': pType,
      'p_name': productNameEnglish,
      'p_name_ar': productNameArabic,
      'sales_description': productSalesDescription,
      'item_image': productImagePath,
      'bar_code': barCode,
      'default_discount': defaultDiscount,
     // 'item_image': itemImage,
      'menuVariationTypesLocalModel': menuVariationTypesLocalModel?.map((v) => v.toJson()).toList(),
      //'menuVariationTypesLocalModel': menuVariationTypesLocalModel?.toJson(),
    };
  }

  // fromMap method: Converts a Map to a MenuLocalModel object
  factory MenuLocalModel.fromMap(Map<String, dynamic> map) {
    return MenuLocalModel(
      id: map['id'],  menuVariationTypesLocalModel: map['menuVariationTypesLocalModel'] != null
        ? List<MenuVariationTypesLocalModel>.from(map['menuVariationTypesLocalModel']
        .map((v) => MenuVariationTypesLocalModel.fromJson(v)))
        : [],
      isTaxable: map['taxable'],
    /*  menuVariationTypesLocalModel: map['menuVariationTypesLocalModel'] != null
          ? MenuVariationTypesLocalModel.fromJson(map['menuVariationTypesLocalModel'])
          : null,**/
      pType: map['p_type'],
      productNameEnglish: map['p_name'],
      productNameArabic: map['p_name_ar'],
      productSalesDescription: map['sales_description'],
      productImagePath: map['item_image'],
      barCode: map['bar_code'],
      defaultDiscount: map['default_discount'],
      itemImage: map['item_image'],
    );
  }

  // toString method: Converts the object to a string
  @override
  String toString() {
    return 'MenuLocalModel(id: $id, isTaxable: $isTaxable, pType: $pType, '
        'productNameEnglish: $productNameEnglish, productNameArabic: $productNameArabic, '
        'productSalesDescription: $productSalesDescription, productImagePath: $productImagePath, '
        'barCode: $barCode, defaultDiscount: $defaultDiscount, itemImage: $itemImage, '
        'menuVariationTypesLocalModel: $menuVariationTypesLocalModel)';
  }
}
