
import 'package:flovix_kitchen/model/pdf_files/Printer_model.dart';

class CartLocalModel {
  int? id;
  int? isTaxable;
  int? pType;
  int? stock;
  int? productIndex;
  int? isExclusionItem;
  int? isMenuItem;
  bool? isTobaccoItem;
  int? invoiceReg;
  int? taxId;
  String? tobaccoChargeId;
  String? tobaccoChargeRate;
  var uomValue;
  var tobaccoCharge;
  var tobaccoChargeTax;
  bool? isCouponApplied;
  bool? isPromotionApplied;
  String? isPromotionValue;
  int quantity;
  int ?isRemove;
  int? isReturn;
  int? isTexInclusive;
  int? isTaxPercent;
  bool? isDiscountApplied;
  int? productId;
  int? customDiscountIsPercentage;
  String? defaultDiscount;
  String? couponDiscount;
  String? productTags;

  String? customDefaultDiscount;
  double? salePrice;
  double? taxValue;
  double? itemValueAfterTimedEvent;
  double? costPrice;
  int? unitMeasure;
  String? barCode;
  String? productImagePath;
  String? productNameEnglish;
  String? productNameArabic;
  String? productSalesDescription;
  int? employeeId;
  String? employeeName;
  String? timedEventName;
  bool? isTimedEventApplied;

  String? productNotes;
  PrinterModel? printerModel;
  var discountedPrice;
  int? courseId; // Course ID for grouping items
  int? originalQuantityForReturn;
  /// Units to return (completed-invoice flow); spinner value while editing.
  int? selectedReturnQuantity;

  //double? uomValue;
  String? uomListJson; // Store UOM list as JSON string

  // Constructor
  CartLocalModel({
    this.id,
    this.isCouponApplied=false,
    this.isPromotionApplied=false,
    this.isTaxable,
    this.tobaccoChargeId,
    this.tobaccoChargeRate,
    this.taxId,
    this.couponDiscount,
    this.discountedPrice,
   required this.quantity,
    this.pType,
    this.isPromotionValue,
    this.itemValueAfterTimedEvent,

    this.uomValue,
    this.printerModel,

    this.isDiscountApplied=false,
    this.isTimedEventApplied=false,
    this.isTobaccoItem=false,
    this.timedEventName="",
    this.isTexInclusive,
    this.tobaccoCharge,
    this.tobaccoChargeTax,
    this.customDefaultDiscount,
    this.isExclusionItem,
    this.invoiceReg,
    this.unitMeasure,
    this.customDiscountIsPercentage,
    this.stock,
    this.productNotes,
    this.productId,
    this.isTaxPercent,
    this.defaultDiscount,
    this.productTags,
    this.isMenuItem=0,
    this.salePrice,
    this.costPrice,
    this.barCode,
    this.productImagePath,
    this.taxValue,
    this.isRemove,
    this.isReturn,
    this.productIndex,
    this.productNameEnglish,

    this.productNameArabic,
    this.productSalesDescription,
    this.employeeId,
    this.employeeName,
    this.courseId,
    this.originalQuantityForReturn,
    this.selectedReturnQuantity,
   // this.uomValue,
    this.uomListJson,
  });

  // Factory method to create an instance from JSON
  factory CartLocalModel.fromJson(Map<String, dynamic> json) {
    return CartLocalModel(
      stock: json['stock']??0,
      id: json['id']??0,
      isPromotionValue: json['isCouponValue']??"",
      timedEventName: json['timedEventName']??"",
      itemValueAfterTimedEvent: json['itemValueAfterTimedEvent']??"",
      couponDiscount: json['couponDiscount']??"",
      tobaccoCharge: json['tobaccoCharge']??0.0,
      tobaccoChargeTax: json['tobaccoChargeTax']??0.0,
      uomValue: json['uom_value'],
      isTobaccoItem: json['isTobaccoItem']??false,
      isCouponApplied: json['isCouponApplied'],
      isPromotionApplied: json['isPromotionApplied'],
      invoiceReg: json['invoice_reg_num']??0,
      isRemove: json['is_remove']??0,
      isReturn: json['is_return'] ?? 0,
      taxId: json['tax_id']??0,
      tobaccoChargeId: json['tobaccoChargeId']??"0",
      tobaccoChargeRate: json['tobaccoChargeRate']??"0",
      isMenuItem: json['is_menu_product'] ?? json['is_menu_item'] ?? 0,
      isTaxable: json['taxable']??0,
      discountedPrice: json['discountedPrice']??0,
      customDiscountIsPercentage: json['custom_discount_percentage']??0,
      quantity: json['quantity']??0,
      isExclusionItem: json['is_exclusion_item']??0,
      pType: json['p_type']??0,
      productIndex: json['productIndex']??0,
      isTaxPercent: json['is_tax_percent']??0,
      isTexInclusive: json['tax_inclusive']??0,
      productId: json['product_id']??0,
      defaultDiscount: json['default_discount']??"",
      productTags: json['product_tags']??"n/a",
      salePrice: json['sale_price']??0.0,
      costPrice: json['cost_price']??0.0,
      unitMeasure: json['unit_measure']??0,
      barCode: json['bar_code']??"",
      customDefaultDiscount: json['custom_default_discount']??"",
      productImagePath: json['image_url']??"",
      isDiscountApplied: json['isDiscountApplied']??false,
      isTimedEventApplied: json['isTimedEventApplied']??false,
      productNameEnglish: json['name_en']??'',
      productNameArabic: json['name_ar']??"",
      taxValue: json['tax_value']??0.0,
      productSalesDescription: json['sales_description']??"",
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      courseId: json['course_id'],
      originalQuantityForReturn: json['original_quantity_for_return'],
      selectedReturnQuantity: json['selected_return_quantity'],

      uomListJson: json['uom_list_json'],
      productNotes: json['product_note']??"",
      printerModel: json['printer'] != null ? PrinterModel.fromJson(json['printer']) : null,

    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'stock': stock,
      'tobaccoCharge': tobaccoCharge,
      'tobaccoChargeTax': tobaccoChargeTax,
      'isTobaccoItem': isTobaccoItem,
      'uom_value': uomValue,
      'id': id,
      'itemValueAfterTimedEvent': itemValueAfterTimedEvent,
      'is_menu_product': isMenuItem,
      'is_menu_item': isMenuItem,
      'invoice_reg_num': invoiceReg,
      'tobaccoChargeRate': tobaccoChargeRate,
      'tobaccoChargeId': tobaccoChargeId,
      'tax_id': taxId,
      'is_exclusion_item': isExclusionItem,
      'productIndex': productIndex,
      'taxable': isTaxable,
      'is_remove': isRemove,
      'is_return': isReturn,
      'custom_discount_percentage': customDiscountIsPercentage,
      'p_type': pType,
      'custom_default_discount': customDefaultDiscount,
      'quantity': quantity,
      'is_tax_percent': isTaxPercent,
      'tax_inclusive': isTexInclusive,
      'unit_measure': unitMeasure,
      'product_id': productId,
      'default_discount': defaultDiscount,
      'product_tags': productTags,
      'sale_price': salePrice,
      'cost_price': costPrice,
      'bar_code': barCode,
      'image_url': productImagePath,
      'name_en': productNameEnglish,
      'name_ar': productNameArabic,
      'tax_value': taxValue,
      'sales_description': productSalesDescription,
      'employee_id': employeeId,
      'employee_name': employeeName,
      'product_note': productNotes,
      'course_id': courseId,
      'original_quantity_for_return': originalQuantityForReturn,
      'selected_return_quantity': selectedReturnQuantity,
      //'uom_value': uomValue,
      'uom_list_json': uomListJson,
    };
  }

  // Method to map from JSON to this class and create a list of instances (if necessary)
  static List<CartLocalModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CartLocalModel.fromJson(json)).toList();
  }

  // Method to convert a list of CartLocalModel instances to a JSON list (if necessary)
  static List<Map<String, dynamic>> toJsonList(List<CartLocalModel> modelList) {
    return modelList.map((model) => model.toJson()).toList();
  }

  // fromMap method to create an instance from a Map
  factory CartLocalModel.fromMap(Map<String, dynamic> map) {
    return CartLocalModel(
      id: map['id']??0,
      stock: map['stock']??0,
      uomValue: map['uom_value'],
      quantity: map['quantity']??0,
      productIndex: map['productIndex']??0,
      isTaxable: map['taxable']??0,
      tobaccoCharge: map['tobaccoCharge']??0.0,
      itemValueAfterTimedEvent: map['itemValueAfterTimedEvent']??0.0,
      tobaccoChargeTax: map['tobaccoChargeTax']??0.0,
      isExclusionItem: map['is_exclusion_item']??0,
      isRemove: map['is_remove']??0,
      isReturn: map['is_return'] ?? 0,
      customDiscountIsPercentage: map['custom_discount_percentage']??0,
      isMenuItem: map['is_menu_item']??0,
      isTaxPercent: map['is_tax_percent']??0,
      invoiceReg: map['invoice_reg_num']??0,
      pType: map['p_type']??0,
      isTexInclusive: map['tax_inclusive']??0,
      tobaccoChargeId: map['tobaccoChargeId']??"0",
      tobaccoChargeRate: map['tobaccoChargeRate']??"0",
      taxId: map['tax_id']??0,
      productId: map['product_id']??0,
      discountedPrice: map['discountedPrice']??0,
      defaultDiscount: map['default_discount']??"",
      productTags: map['product_tags']??"n/a",
      customDefaultDiscount: map['custom_default_discount']??"",
      productNotes: map['product_note']??"",
      salePrice: map['sale_price']??0.0,
      unitMeasure: map['unit_measure']??0,
      costPrice: map['cost_price']??0.0,
      barCode: map['bar_code']??"",
      isTobaccoItem: map['isTobaccoItem']??false,
      productImagePath: map['image_url']??"",
      productNameEnglish: map['name_en']??"",
      productNameArabic: map['name_ar']??"",
      productSalesDescription: map['sales_description']??"",
      taxValue: map['tax_value']??0.0,
      employeeId: map['employee_id'],
      employeeName: map['employee_name'],
      courseId: map['course_id'],
      originalQuantityForReturn: map['original_quantity_for_return'],
    //  uomValue: map['uom_value']??0.0,
      uomListJson: map['uom_list_json'],
      printerModel: map['ip_address'] != null
          ? PrinterModel(
        sno: map['printer_sno'],
        productId: map['printer_product_id'],
        name: map['name'],
        isActive: map['is_active'],
        availablePrinter: map['available_printer'],
        printerType: map['printer_type'],
        vendorId: map['vendor_id'],
        ipAddress: map['ip_address'],
        printerPort: map['printer_port'],
      )
          : null,

    );
  }

  // Override toString method to get a string representation of the object
  @override
  String toString() {
    return 'CartLocalModel(id: $id,uom data ${uomListJson} stock :$stock,product_tag :${productTags} isTaxPercent ${isTaxPercent} ,quantity: $quantity,isTaxable: $isTaxable, pType: $pType, isTexInclusive: $isTexInclusive, productId: $productId, defaultDiscount: $defaultDiscount, salePrice: $salePrice, costPrice: $costPrice, barCode: $barCode, productImagePath: $productImagePath, productNameEnglish: $productNameEnglish, productNameArabic: $productNameArabic, productSalesDescription: $productSalesDescription)';
  }
}
