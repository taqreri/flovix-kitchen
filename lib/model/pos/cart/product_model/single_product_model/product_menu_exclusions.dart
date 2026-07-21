/// product_menu_exclusion_id : 170
/// master_product_id : 1627
/// exclusion_name_en : "exclusion 1 dynamic"
/// exclusion_name_ar : "exclusion 1 dynamic ar"

class ProductMenuExclusions {
  ProductMenuExclusions({
      this.productMenuExclusionId, 
      this.isSelected=false,
      this.masterProductId,
      this.exclusionNameEn,
      this.exclusionNameAr,});

  ProductMenuExclusions.fromJson(dynamic json) {
    productMenuExclusionId = json['product_menu_exclusion_id']??int.parse(json['id'])??-2;
    masterProductId = json['master_product_id']??-2;
    exclusionNameEn = json['exclusion_name_en']??json['exclusion_name']??"n/a";
    exclusionNameAr = json['exclusion_name_ar']??json['exclusion_name_ar']??"n/a";

    // Parse isSelected: check isSelected first, then selected field
    // Handle both int (1/0) and bool (true/false) values
    if (json['isSelected'] != null) {
      if (json['isSelected'] is bool) {
        isSelected = json['isSelected'] as bool;
      } else if (json['isSelected'] is int) {
        isSelected = (json['isSelected'] as int) == 1;
      } else if (json['isSelected'] is String) {
        isSelected = json['isSelected'] == '1' || json['isSelected'].toString().toLowerCase() == 'true';
      } else {
        isSelected = false;
      }
    } else if (json['selected'] != null) {
      // Check the 'selected' field (from API response)
      if (json['selected'] is bool) {
        isSelected = json['selected'] as bool;
      } else if (json['selected'] is int) {
        isSelected = (json['selected'] as int) == 1;
      } else if (json['selected'] is String) {
        isSelected = json['selected'] == '1' || json['selected'].toString().toLowerCase() == 'true';
      } else {
        isSelected = false;
      }
    } else {
      isSelected = false;
    }
  }

  int? productMenuExclusionId;
  int? masterProductId;
  String? exclusionNameEn;
  bool? isSelected;
  String? exclusionNameAr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_menu_exclusion_id'] = productMenuExclusionId;
    map['master_product_id'] = masterProductId;
    map['exclusion_name_en'] = exclusionNameEn;
    map['exclusion_name_ar'] = exclusionNameAr;
    
    map['isSelected'] = isSelected;
    return map;
  }

  ProductMenuExclusions copyWith({
    int? productMenuExclusionId,
    int? masterProductId,
    String? exclusionNameEn,
    String? exclusionNameAr,
    bool? isSelected,
  }) {
    return ProductMenuExclusions(
      productMenuExclusionId: productMenuExclusionId ?? this.productMenuExclusionId,
      masterProductId: masterProductId ?? this.masterProductId,
      exclusionNameEn: exclusionNameEn ?? this.exclusionNameEn,
      exclusionNameAr: exclusionNameAr ?? this.exclusionNameAr,
      isSelected: isSelected ?? this.isSelected,
    );
  }

}