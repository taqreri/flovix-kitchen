import 'dart:convert';

class ProductMenuExclusionLocal {
  int? id;
  int? masterProductId;
  int? productMenuExclusionId;
  int? exclusionIndex;
  int? exclusionSelected;
  String? exclusionNameAr;
  String? exclusionNameEn;

  ProductMenuExclusionLocal({
    this.id,
    this.masterProductId,
    this.productMenuExclusionId,
    this.exclusionNameAr,
    this.exclusionSelected,
    this.exclusionIndex,
    this.exclusionNameEn,
  });

  /// Convert this object to a Map (good for databases / manual JSON work)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'master_product_id': masterProductId,
      'exclusion_selected': exclusionSelected,
      'product_menu_exclusion_id': productMenuExclusionId,
      'exclusion_name_en': exclusionNameEn,
      'exclusion_index': exclusionIndex,
      'exclusion_name_ar': exclusionNameAr,
    };
  }

  /// Create an object from a Map
  factory ProductMenuExclusionLocal.fromMap(Map<String, dynamic> map) {
    return ProductMenuExclusionLocal(
      id: map['id'] is String ? int.tryParse(map['id']) : map['id'] as int?,
      exclusionSelected: map['exclusion_selected'] is String
          ? int.tryParse(map['exclusion_selected'])
          : map['exclusion_selected'] as int?,
      exclusionIndex: map['exclusion_index'] is String
          ? int.tryParse(map['exclusion_index'])
          : map['exclusion_index'] as int?,
      masterProductId: map['master_product_id'] is String
          ? int.tryParse(map['master_product_id'])
          : map['master_product_id'] as int?,
      productMenuExclusionId: map['product_menu_exclusion_id'] is String
          ? int.tryParse(map['product_menu_exclusion_id'])
          : map['product_menu_exclusion_id'] as int?,
      exclusionNameEn: map['exclusion_name_en'] as String?,
      exclusionNameAr: map['exclusion_name_ar'] as String?,
    );
  }

  /// Convert this object to a JSON string
  String toJson() => json.encode(toMap());

  /// Create an object from a JSON string
  factory ProductMenuExclusionLocal.fromJson(String source) =>
      ProductMenuExclusionLocal.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
