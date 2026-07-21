
import 'package:flovix_kitchen/model/pos/cart/product_model/single_product_model/single_product_model.dart';

/// variations : [{"id":3,"var_name":"color","var_name_ar":"لون","attributes":[]},{"id":4,"var_name":"size","var_name_ar":"مقاس","attributes":[]}]
/// childProduct : []

class VariationsModel {
  VariationsModel({
      this.singleProductVariations,
      this.childProduct,});

  VariationsModel.fromJson(dynamic json) {
    if (json['childProduct'] != null) {
      singleProductVariations = [];
      json['childProduct'].forEach((v) {
        singleProductVariations?.add(SingleProductVariations.fromJson(v));
      });
    }
 /*   if (json['childProduct'] != null) {
      childProduct = [];
      json['childProduct'].forEach((v) {
        childProduct?.add(Dynamic.fromJson(v));
      });
    }**/
  }
  List<SingleProductVariations>? singleProductVariations;
  List<dynamic>? childProduct;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (singleProductVariations != null) {
      map['childProduct'] = singleProductVariations?.map((v) => v.toJson()).toList();
    }
    if (childProduct != null) {
      map['childProduct'] = childProduct?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 3
/// var_name : "color"
/// var_name_ar : "لون"
/// attributes : []

