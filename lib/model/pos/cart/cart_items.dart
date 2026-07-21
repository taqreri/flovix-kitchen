class CartItem {
  final String id;
  final String productId;
  final String name;
  final String? imagePath;
  String? isPercentage;
  final int quantity;
  final double price;
  double discount;
  final double tax;
  final double? tax_inclusive_amount;
  final double? tax_exclusive_amount;
  final double? itemTaxRate;
  final double? itemTaxValue;
  final String? p_tax_code;
  final String? tax_type;
  final String? taxable;
  final String? tax_account;
  final String? default_tax;
  final String? default_tax2;
  final String? min_tax;
  final String? max_tax;
  final String? tax_inclusive;
  final String? taxSno;
  final int? itemBatch;

  final List<String>? variations;
  final List<String>? variationsIds;
  final List<String>? menuOptions;
  final List<String>? menuOptionsIds;
  final int? unitMeasure;

  CartItem({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.tax,
    this.tax_inclusive_amount,
    this.tax_exclusive_amount,
    this.itemTaxRate,
    this.isPercentage,
    required this.productId,
    this.itemTaxValue,
    this.variations,
    this.variationsIds,
    this.menuOptions,
    this.menuOptionsIds,
    this.unitMeasure,
    this.taxable,
    this.default_tax,
    this.default_tax2,
    this.max_tax,
    this.min_tax,
    this.p_tax_code,
    this.tax_account,
    this.tax_inclusive,
    this.tax_type,
    this.taxSno,
    this.itemBatch,
  });

  double get totalPrice => (price - discount) * quantity + tax;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'productId': productId,
      'imagePath': imagePath,
      'quantity': quantity,
      'is_percentage': isPercentage,
      'price': price,
      'discount': discount,
      'tax': tax,
      'tax_inclusive_amount': tax_inclusive_amount,
      'tax_exclusive_amount': tax_exclusive_amount,
      'itemTaxRate': itemTaxRate,
      'itemTaxValue': itemTaxValue,
      'variations': variations?.join(','),
      'variationsIds': variationsIds?.join(','),
      'menuOptions': menuOptions?.join(','),
      'menuOptionsIds': menuOptionsIds?.join(','),
      'unitMeasure': unitMeasure,
      'taxable': taxable,
      'default_tax': default_tax,
      'default_tax2': default_tax2,
      'max_tax': max_tax,
      'min_tax': min_tax,
      'p_tax_code': p_tax_code,
      'tax_account': tax_account,
      'tax_inclusive': tax_inclusive,
      'tax_type': tax_type,
      'taxSno': taxSno,
      'itemBatch': itemBatch, // Correctly stored as int
    };
  }

  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
        id: map['id']?.toString() ?? '',
        name: map['name']?.toString() ?? '',
        imagePath: map['imagePath']?.toString(),
        productId: map['productId']??"",
        quantity: (map['quantity'] is int)
            ? map['quantity']
            : int.tryParse(map['quantity']?.toString() ?? '') ?? 0,
        price: (map['price'] is double)
            ? map['price']
            : double.tryParse(map['price']?.toString() ?? '') ?? 0.0,

        discount: (map['discount'] is double)
            ? map['discount']
            : double.tryParse(map['discount']?.toString() ?? '') ?? 0.0,
        tax: (map['tax'] is double)
            ? map['tax']
            : double.tryParse(map['tax']?.toString() ?? '') ?? 0.0,
        tax_inclusive_amount: (map['tax_inclusive_amount'] is double)
            ? map['tax_inclusive_amount']
            : double.tryParse(map['tax_inclusive_amount']?.toString() ?? ''),
        tax_exclusive_amount: (map['tax_exclusive_amount'] is double)
            ? map['tax_exclusive_amount']
            : double.tryParse(map['tax_exclusive_amount']?.toString() ?? ''),
        itemTaxRate: (map['itemTaxRate'] is double)
            ? map['itemTaxRate']
            : double.tryParse(map['itemTaxRate']?.toString() ?? ''),
        itemTaxValue: (map['itemTaxValue'] is double)
            ? map['itemTaxValue']
            : double.tryParse(map['itemTaxValue']?.toString() ?? ''),
        variations: map['variations']?.toString().split(','),
        isPercentage: map['is_percentage']?.toString(),
        variationsIds: map['variationsIds']?.toString().split(','),
        menuOptions: map['menuOptions']?.toString().split(','),
        menuOptionsIds: map['menuOptionsIds']?.toString().split(','),
        unitMeasure: (map['unitMeasure'] is int)
            ? map['unitMeasure']
            : int.tryParse(map['unitMeasure']?.toString() ?? ''),
        taxable: map['taxable']?.toString(),
        default_tax: map['default_tax']?.toString(),
        default_tax2: map['default_tax2']?.toString(),
        max_tax: map['max_tax']?.toString(),
        min_tax: map['min_tax']?.toString(),
        p_tax_code: map['p_tax_code']?.toString(),
        tax_account: map['tax_account']?.toString(),
        tax_inclusive: map['tax_inclusive']?.toString(),
        tax_type: map['tax_type']?.toString(),
        taxSno: map['taxSno']?.toString(),
        // Fixed itemBatch parsing
        itemBatch: (map['itemBatch'] is int)
            ? map['itemBatch']
            : int.tryParse(map['itemBatch']?.toString() ?? '')
    );
  }
}