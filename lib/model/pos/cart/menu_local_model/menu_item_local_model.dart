
import 'package:flovix_kitchen/model/pos/cart/cart_local_model/cart_local_model.dart';

class MenuItemLocalModel {
  int? masterProductId;
  int? productMenuListId;
  int? quantity;
  int? itemId;
  var itemSalePrice;
  CartLocalModel? cartLocalModel;

  // Constructor
  MenuItemLocalModel({
    this.masterProductId,
    this.cartLocalModel,
    this.productMenuListId,
    this.itemId,
    this.quantity,
    this.itemSalePrice,
  });

  // fromJson method: Converts JSON to a MenuItemLocalModel object
  factory MenuItemLocalModel.fromJson(Map<String, dynamic> json) {
    return MenuItemLocalModel(
      masterProductId: json['master_product_id'],
      cartLocalModel: json['cartLocalModel'] != null
          ? CartLocalModel.fromJson(json['cartLocalModel'])
          : null,
      productMenuListId: json['product_menu_list_id'],
      quantity: json['quantity'],
      itemId: json['item_id'],
      itemSalePrice: json['item_sale_price'],
    );
  }

  // toJson method: Converts the MenuItemLocalModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'cartLocalModel': cartLocalModel?.toJson(), // Convert cartLocalModel to JSON if not null
      'master_product_id': masterProductId,
      'item_id': itemId,
      'product_menu_list_id': productMenuListId,
      'quantity': quantity,
      'item_sale_price': itemSalePrice,
    };
  }

  // fromMap method: Converts a Map to a MenuItemLocalModel object
  factory MenuItemLocalModel.fromMap(Map<String, dynamic> map) {
    return MenuItemLocalModel(
      cartLocalModel: map['cartLocalModel'] != null
          ? CartLocalModel.fromJson(map['cartLocalModel'])
          : null,
      masterProductId: map['master_product_id'],
      productMenuListId: map['product_menu_list_id'],
      itemId: map['item_id'],
      quantity: map['quantity'],
      itemSalePrice: map['item_sale_price'],
    );
  }
}
