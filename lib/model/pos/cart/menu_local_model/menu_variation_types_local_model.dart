import 'menu_item_local_model.dart';

class MenuVariationTypesLocalModel {
  int? id;
  String? variationNameEnglish;
  String? variationNameArabic;
  int? isMultiChoice;
  int? isSingleChoice;
  int? isNoPrint;
  List<MenuItemLocalModel>? menuItemLocalModel;

  // Constructor
  MenuVariationTypesLocalModel({
    this.id,
    this.variationNameEnglish,
    this.variationNameArabic,
    this.menuItemLocalModel,
    this.isMultiChoice,
    this.isSingleChoice,
    this.isNoPrint,
  });

  // fromJson method: Converts JSON to a MenuVariationTypesLocalModel object
  factory MenuVariationTypesLocalModel.fromJson(Map<String, dynamic> json) {
    return MenuVariationTypesLocalModel(
      id: json['id'],
      menuItemLocalModel: json['menuItemLocalModel'] != null
          ? List<MenuItemLocalModel>.from(json['menuItemLocalModel']
          .map((v) => MenuItemLocalModel.fromJson(v)))
          : [],
      variationNameEnglish: json['variation_name'],
      variationNameArabic: json['variation_name_ar'],
      isMultiChoice: json['is_multi_choice'],
      isSingleChoice: json['single_choice'],
      isNoPrint: json['is_no_print'],
    );
  }

  // toJson method: Converts the MenuVariationTypesLocalModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'variation_name': variationNameEnglish,
      'variation_name_ar': variationNameArabic,
      'is_multi_choice': isMultiChoice,
      'single_choice': isSingleChoice,
      'is_no_print': isNoPrint,
      // Convert menuItemLocalModel list to JSON if not null
      'menuItemLocalModel': menuItemLocalModel?.map((v) => v.toJson()).toList(),
    };
  }

  // fromMap method: Converts a Map to a MenuVariationTypesLocalModel object
  factory MenuVariationTypesLocalModel.fromMap(Map<String, dynamic> map) {
    return MenuVariationTypesLocalModel(
      id: map['id'],
      menuItemLocalModel: map['menuItemLocalModel'] != null
          ? List<MenuItemLocalModel>.from(map['menuItemLocalModel']
          .map((v) => MenuItemLocalModel.fromJson(v)))
          : [],
      variationNameEnglish: map['variation_name'],
      variationNameArabic: map['variation_name_ar'],
      isMultiChoice: map['is_multi_choice'],
      isSingleChoice: map['single_choice'],
      isNoPrint: map['is_no_print'],
    );
  }
}
