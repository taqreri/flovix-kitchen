
import 'package:flovix_kitchen/model/pos/cart/product_model/single_product_model/menu_variation_types.dart';
import 'package:flovix_kitchen/model/pos/cart/product_model/single_product_model/product_menu_exclusions.dart';

/// menu_variation : [{"sno":2,"variation_name":"Multi Option","variation_name_ar":"Multi Option","branch":0,"status":1,"is_multi_choice":1,"single_choice":0,"created_by":1,"created_at":"2023-11-10 08:49:12","updated_by":1,"updated_at":"2023-12-11 09:44:03","max_qty":"2","menu_items":[{"product_menu_variation_id":641,"product_menu_list_id":2,"master_product_id":1593,"item_id":4,"item_sale_price":19,"item_quantity":1,"item_unit_id":21,"item_total":19,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"4","sales_description":"نص حبة حراق","item_image":"https://taqreri-cdn.fra1.digitaloceanspaces.com/company_files/userdb_347_28385/images/auserdb230611110432am1242userdb250530062956pm6839cef4f137d.jpg","sno":4},{"product_menu_variation_id":642,"product_menu_list_id":2,"master_product_id":1593,"item_id":8,"item_sale_price":2.5,"item_quantity":1,"item_unit_id":21,"item_total":2.5,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"8","sales_description":"حمضيات","item_image":"https://taqreri.com/sys_images/sv.png","sno":8},{"product_menu_variation_id":643,"product_menu_list_id":2,"master_product_id":1593,"item_id":9,"item_sale_price":2.5,"item_quantity":1,"item_unit_id":21,"item_total":2.5,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"9","sales_description":"سفن","item_image":"https://taqreri.com/sys_images/sv.png","sno":9}]},{"sno":1,"variation_name":"single choice","variation_name_ar":"single choice","branch":0,"status":1,"is_multi_choice":0,"single_choice":1,"created_by":1,"created_at":"2023-11-06 06:42:41","updated_by":1,"updated_at":"2023-12-22 18:29:43","max_qty":"2","menu_items":[{"product_menu_variation_id":644,"product_menu_list_id":1,"master_product_id":1593,"item_id":20,"item_sale_price":1,"item_quantity":1,"item_unit_id":21,"item_total":1,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"22","sales_description":"كوكتيل","item_image":"https://taqreri.com/sys_images/sv.png","sno":20},{"product_menu_variation_id":645,"product_menu_list_id":1,"master_product_id":1593,"item_id":23,"item_sale_price":6.5,"item_quantity":1,"item_unit_id":21,"item_total":6.5,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"25","sales_description":" شاورما ساده","item_image":"https://taqreri.com/sys_images/sv.png","sno":23},{"product_menu_variation_id":646,"product_menu_list_id":1,"master_product_id":1593,"item_id":24,"item_sale_price":6.5,"item_quantity":1,"item_unit_id":21,"item_total":6.5,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"26","sales_description":"شاورما جبن","item_image":"https://taqreri.com/sys_images/sv.png","sno":24}]}]
/// menu_exclusion : [{"exclusion_name_ar":"some thing","exclusion_name_en":"soem thing","product_menu_exclusion_id":174,"master_product_id":1593}]
/// main_product : {"max_menu_items":"{\"2\":\"2\",\"1\":\"2\"}","sno":1593,"sale_price":0,"p_name":"fizza hot ","sales_description":"fizza hot ","item_image":"cuserdb230611101044pm3227userdb250909075424pm68c05bc0c8d68.jpg"}

class MenuItem {
  MenuItem({
      this.menuVariationTypes,
      this.productMenuExclusions,
      this.mainProduct,});

  MenuItem.fromJson(dynamic json) {
    if (json['menu_variation'] != null) {
      menuVariationTypes = [];
      json['menu_variation'].forEach((v) {
        menuVariationTypes?.add(MenuVariationTypes.fromJson(v));
      });
    }
    if (json['menu_exclusion'] != null) {
      productMenuExclusions = [];
      json['menu_exclusion'].forEach((v) {
        productMenuExclusions?.add(ProductMenuExclusions.fromJson(v));
      });
    }
 //   mainProduct = json['main_product'] != null ? MainProduct.fromJson(json['main_product']) : null;
  }
  List<MenuVariationTypes>? menuVariationTypes;
 // List<MenuExclusion>? menuExclusion;
  MainProduct? mainProduct;
  List<ProductMenuExclusions>? productMenuExclusions;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (menuVariationTypes != null) {
      map['menu_variation'] = menuVariationTypes?.map((v) => v.toJson()).toList();
    }

    if (mainProduct != null) {
      map['main_product'] = mainProduct?.toJson();
    }
    if (productMenuExclusions != null) {
      map['menu_exclusion'] =
          productMenuExclusions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// max_menu_items : "{\"2\":\"2\",\"1\":\"2\"}"
/// sno : 1593
/// sale_price : 0
/// p_name : "fizza hot "
/// sales_description : "fizza hot "
/// item_image : "cuserdb230611101044pm3227userdb250909075424pm68c05bc0c8d68.jpg"

class MainProduct {
  MainProduct({
      this.maxMenuItems, 
      this.sno, 
      this.salePrice, 
      this.pName, 
      this.salesDescription, 
      this.itemImage,});

  MainProduct.fromJson(dynamic json) {
    maxMenuItems = json['max_menu_items'];
    sno = json['sno'];
    salePrice = json['sale_price'];
    pName = json['p_name'];
    salesDescription = json['sales_description'];
    itemImage = json['item_image'];
  }
  String? maxMenuItems;
  int? sno;
  var salePrice;
  String? pName;
  String? salesDescription;
  String? itemImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['max_menu_items'] = maxMenuItems;
    map['sno'] = sno;
    map['sale_price'] = salePrice;
    map['p_name'] = pName;
    map['sales_description'] = salesDescription;
    map['item_image'] = itemImage;
    return map;
  }

}

/// exclusion_name_ar : "some thing"
/// exclusion_name_en : "soem thing"
/// product_menu_exclusion_id : 174
/// master_product_id : 1593

class MenuExclusion {
  MenuExclusion({
      this.exclusionNameAr, 
      this.exclusionNameEn, 
      this.productMenuExclusionId, 
      this.masterProductId,});

  MenuExclusion.fromJson(dynamic json) {
    exclusionNameAr = json['exclusion_name_ar'];
    exclusionNameEn = json['exclusion_name_en'];
    productMenuExclusionId = json['product_menu_exclusion_id'];
    masterProductId = json['master_product_id'];
  }
  String? exclusionNameAr;
  String? exclusionNameEn;
  int? productMenuExclusionId;
  int? masterProductId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['exclusion_name_ar'] = exclusionNameAr;
    map['exclusion_name_en'] = exclusionNameEn;
    map['product_menu_exclusion_id'] = productMenuExclusionId;
    map['master_product_id'] = masterProductId;
    return map;
  }

}

/// sno : 2
/// variation_name : "Multi Option"
/// variation_name_ar : "Multi Option"
/// branch : 0
/// status : 1
/// is_multi_choice : 1
/// single_choice : 0
/// created_by : 1
/// created_at : "2023-11-10 08:49:12"
/// updated_by : 1
/// updated_at : "2023-12-11 09:44:03"
/// max_qty : "2"
/// menu_items : [{"product_menu_variation_id":641,"product_menu_list_id":2,"master_product_id":1593,"item_id":4,"item_sale_price":19,"item_quantity":1,"item_unit_id":21,"item_total":19,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"4","sales_description":"نص حبة حراق","item_image":"https://taqreri-cdn.fra1.digitaloceanspaces.com/company_files/userdb_347_28385/images/auserdb230611110432am1242userdb250530062956pm6839cef4f137d.jpg","sno":4},{"product_menu_variation_id":642,"product_menu_list_id":2,"master_product_id":1593,"item_id":8,"item_sale_price":2.5,"item_quantity":1,"item_unit_id":21,"item_total":2.5,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"8","sales_description":"حمضيات","item_image":"https://taqreri.com/sys_images/sv.png","sno":8},{"product_menu_variation_id":643,"product_menu_list_id":2,"master_product_id":1593,"item_id":9,"item_sale_price":2.5,"item_quantity":1,"item_unit_id":21,"item_total":2.5,"is_active":1,"is_default":0,"is_delete":0,"created_at":null,"created_by":null,"updated_at":null,"updated_by":null,"p_name":"9","sales_description":"سفن","item_image":"https://taqreri.com/sys_images/sv.png","sno":9}]

class MenuVariation {
  MenuVariation({
      this.sno, 
      this.variationName, 
      this.variationNameAr, 
      this.isLocked,
      this.branch,
      this.status,
      this.isMultiChoice, 
      this.singleChoice, 
      this.isNoPrint,
      this.createdBy,
      this.createdAt, 
      this.updatedBy, 
      this.updatedAt, 
      this.maxQty, 
      this.menuItems,});

  MenuVariation.fromJson(dynamic json) {
    sno = json['sno']??'';
    isLocked = json['is_locked']??0;
    variationName = json['variation_name']??"";
    variationNameAr = json['variation_name_ar']??"";
    branch = json['branch']??0;
    status = json['status']??0;
    isMultiChoice = json['is_multi_choice']??0;
    singleChoice = json['single_choice']??0;
    
    isNoPrint = json['is_no_print']??0;
 //   createdBy = json['created_by'];
 //   createdAt = json['created_at'];
//    updatedBy = json['updated_by'];
 //   updatedAt = json['updated_at'];
    maxQty = json['max_qty']??"";
    if (json['menu_items'] != null) {
      menuItems = [];
      json['menu_items'].forEach((v) {
        menuItems?.add(MenuItems.fromJson(v));
      });
    }
  }
  int? sno;
  String? variationName;
  String? variationNameAr;
  int? branch;
  int? isLocked;
  int? status;
  int? isMultiChoice;
  int? singleChoice;
  int? isNoPrint;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? maxQty;
  List<MenuItems>? menuItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['variation_name'] = variationName;
    map['variation_name_ar'] = variationNameAr;
    map['branch'] = branch;
    map['status'] = status;
    map['is_locked'] = isLocked;
    map['is_no_print'] = isNoPrint;
    map['is_multi_choice'] = isMultiChoice;
    map['single_choice'] = singleChoice;
    map['created_by'] = createdBy;
    map['created_at'] = createdAt;
    map['updated_by'] = updatedBy;
    map['updated_at'] = updatedAt;
    map['max_qty'] = maxQty;
    if (menuItems != null) {
      map['menu_items'] = menuItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// product_menu_variation_id : 641
/// product_menu_list_id : 2
/// master_product_id : 1593
/// item_id : 4
/// item_sale_price : 19
/// item_quantity : 1
/// item_unit_id : 21
/// item_total : 19
/// is_active : 1
/// is_default : 0
/// is_delete : 0
/// created_at : null
/// created_by : null
/// updated_at : null
/// updated_by : null
/// p_name : "4"
/// sales_description : "نص حبة حراق"
/// item_image : "https://taqreri-cdn.fra1.digitaloceanspaces.com/company_files/userdb_347_28385/images/auserdb230611110432am1242userdb250530062956pm6839cef4f137d.jpg"
/// sno : 4

class MenuItems {
  MenuItems({
      this.productMenuVariationId, 
      this.productMenuListId, 
      this.masterProductId, 
      this.itemId, 
      this.itemSalePrice, 
      this.itemQuantity, 
      this.itemUnitId, 
      this.itemTotal, 
      this.isActive, 
      this.isDefault, 
      this.isDelete, 
      this.createdAt, 
      this.createdBy, 
      this.updatedAt, 
      this.updatedBy, 
      this.pName, 
      this.salesDescription, 
      this.itemImage, 
      this.sno,});

  MenuItems.fromJson(dynamic json) {
    productMenuVariationId = json['product_menu_variation_id']??0;
    productMenuListId = json['product_menu_list_id']??0;
    masterProductId = json['master_product_id']??0;
    itemId = json['item_id']??0;
    itemSalePrice = json['item_sale_price'];
    
    itemQuantity = json['item_quantity']??22;
    itemUnitId = json['item_unit_id']??0;
    itemTotal = json['item_total']??0;
    isActive = json['is_active']??0;
    isDefault = json['is_default']??0;
    isDelete = json['is_delete']??0;
    //  createdAt = json['created_at'];
    //createdBy = json['created_by'];
    //updatedAt = json['updated_at'];
   // updatedBy = json['updated_by'];
    pName = json['p_name']??"";
    salesDescription = json['sales_description']??"";
    itemImage = json['item_image']??"";
    sno = json['sno'];
  }
  int? productMenuVariationId;
  int? productMenuListId;
  int? masterProductId;
  int? itemId;
  var itemSalePrice;
  var itemQuantity;
  var itemUnitId;
  var itemTotal;
  int? isActive;
  int? isDefault;
  int? isDelete;
  dynamic createdAt;
  dynamic createdBy;
  dynamic updatedAt;
  dynamic updatedBy;
  String? pName;
  String? salesDescription;
  String? itemImage;
  int? sno;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_menu_variation_id'] = productMenuVariationId;
    map['product_menu_list_id'] = productMenuListId;
    map['master_product_id'] = masterProductId;
    map['item_id'] = itemId;
    map['item_sale_price'] = itemSalePrice;
    map['item_quantity'] = itemQuantity;
    map['item_unit_id'] = itemUnitId;
    map['item_total'] = itemTotal;
    map['is_active'] = isActive;
    map['is_default'] = isDefault;
    map['is_delete'] = isDelete;
    map['created_at'] = createdAt;
    map['created_by'] = createdBy;
    map['updated_at'] = updatedAt;
    map['updated_by'] = updatedBy;
    map['p_name'] = pName;
    map['sales_description'] = salesDescription;
    map['item_image'] = itemImage;
    map['sno'] = sno;
    return map;
  }

}