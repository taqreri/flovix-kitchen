class CartItems {
  CartItems({
      this.stock, 
      this.tobaccoCharge, 
      this.isTobaccoItem, 
      this.uomValue, 
      this.id, 
      this.isMenuItem, 
      this.invoiceRegNum, 
      this.tobaccoChargeRate, 
      this.tobaccoChargeId, 
      this.taxId, 
      this.isExclusionItem, 
      this.productIndex, 
      this.taxable, 
      this.isRemove, 
      this.customDiscountPercentage, 
      this.pType, 
      this.customDefaultDiscount, 
      this.quantity, 
      this.isTaxPercent, 
      this.taxInclusive, 
      this.unitMeasure, 
      this.productId, 
      this.defaultDiscount, 
      this.productTags,
      this.salePrice, 
      this.costPrice, 
      this.barCode, 
      this.imageUrl, 
      this.nameEn, 
      this.nameAr, 
      this.taxValue, 
      this.salesDescription, 
      this.employeeId, 
      this.employeeName, 
      this.productNote, 
      this.courseId, 
      this.uomListJson,});

  CartItems.fromJson(dynamic json) {
    stock = json['stock'];
    tobaccoCharge = json['tobaccoCharge'];
    isTobaccoItem = json['isTobaccoItem'];
    uomValue = json['uom_value'];
    id = json['id'];
    isMenuItem = json['is_menu_item'];
    invoiceRegNum = json['invoice_reg_num'];
    tobaccoChargeRate = json['tobaccoChargeRate'];
    tobaccoChargeId = json['tobaccoChargeId'];
    taxId = json['tax_id'];
    isExclusionItem = json['is_exclusion_item'];
    productIndex = json['productIndex'];
    taxable = json['taxable'];
    isRemove = json['is_remove'];
    customDiscountPercentage = json['custom_discount_percentage'];
    pType = json['p_type'];
    customDefaultDiscount = json['custom_default_discount'];
    quantity = json['quantity'];
    isTaxPercent = json['is_tax_percent'];
    taxInclusive = json['tax_inclusive'];
    unitMeasure = json['unit_measure'];
    productId = json['product_id'];
    defaultDiscount = json['default_discount'];
    productTags = json['product_tags']?.toString();
    salePrice = json['sale_price'];
    costPrice = json['cost_price'];
    barCode = json['bar_code'];
    imageUrl = json['image_url'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    taxValue = json['tax_value'];
    salesDescription = json['sales_description'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    productNote = json['product_note'];
    courseId = json['course_id'];
    uomListJson = json['uom_list_json'];
  }
  int? stock;
  double? tobaccoCharge;
  bool? isTobaccoItem;
  double? uomValue;
  int? id;
  int? isMenuItem;
  int? invoiceRegNum;
  String? tobaccoChargeRate;
  String? tobaccoChargeId;
  int? taxId;
  int? isExclusionItem;
  int? productIndex;
  int? taxable;
  int? isRemove;
  int? customDiscountPercentage;
  int? pType;
  String? customDefaultDiscount;
  int? quantity;
  int? isTaxPercent;
  int? taxInclusive;
  int? unitMeasure;
  int? productId;
  String? defaultDiscount;
  String? productTags;
  double? salePrice;
  double? costPrice;
  String? barCode;
  String? imageUrl;
  String? nameEn;
  String? nameAr;
  double? taxValue;
  String? salesDescription;
  int? employeeId;
  dynamic employeeName;
  String? productNote;
  dynamic courseId;
  String? uomListJson;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stock'] = stock;
    map['tobaccoCharge'] = tobaccoCharge;
    map['isTobaccoItem'] = isTobaccoItem;
    map['uom_value'] = uomValue;
    map['id'] = id;
    map['is_menu_item'] = isMenuItem;
    map['invoice_reg_num'] = invoiceRegNum;
    map['tobaccoChargeRate'] = tobaccoChargeRate;
    map['tobaccoChargeId'] = tobaccoChargeId;
    map['tax_id'] = taxId;
    map['is_exclusion_item'] = isExclusionItem;
    map['productIndex'] = productIndex;
    map['taxable'] = taxable;
    map['is_remove'] = isRemove;
    map['custom_discount_percentage'] = customDiscountPercentage;
    map['p_type'] = pType;
    map['custom_default_discount'] = customDefaultDiscount;
    map['quantity'] = quantity;
    map['is_tax_percent'] = isTaxPercent;
    map['tax_inclusive'] = taxInclusive;
    map['unit_measure'] = unitMeasure;
    map['product_id'] = productId;
    map['default_discount'] = defaultDiscount;
    map['product_tags'] = productTags;
    map['sale_price'] = salePrice;
    map['cost_price'] = costPrice;
    map['bar_code'] = barCode;
    map['image_url'] = imageUrl;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['tax_value'] = taxValue;
    map['sales_description'] = salesDescription;
    map['employee_id'] = employeeId;
    map['employee_name'] = employeeName;
    map['product_note'] = productNote;
    map['course_id'] = courseId;
    map['uom_list_json'] = uomListJson;
    return map;
  }

}