import 'dart:convert';

import 'Customer.dart';
import 'CartItems.dart';

class OfflineTransactionModel {
  OfflineTransactionModel({
      this.orderTab, 
      this.action, 
      this.posSession, 
      this.counterCustomer, 
      this.invoiceSubtotalWithDiscount,
      this.invWarehouse,
      this.totalItemQuantity,
      this.cusId,
      this.employeeArray,
      this.isChargesApplied,
      this.unitArray,
      this.unitValueArray, 
      this.taxInclusive, 
      this.taxable, 
      this.itemTaxSno, 
      this.itemTaxRate, 
      this.itemTaxValue, 
      this.newOld, 
      this.deliveryDate, 
      this.tobaccoChargeId, 
      this.tobaccoRate, 
      this.itemTobaccoCharge, 
      this.isTobacco, 
      this.itemPromotions, 
      this.itemPromotionsMeta, 
      this.itemCoupons, 
      this.itemCouponMeta, 
      this.invCouponId, 
      this.couponCode, 
      this.itemEvents, 
      this.itemEventMeta, 
      this.isLoyaltyPoints, 
      this.loyaltyScheme, 
      this.loyaltyPoints, 
      this.loyaltyDiscount, 
      this.chargesIds, 
      this.chargeRate, 
      this.chargeValue, 
      this.chargesTaxIds, 
      this.chargesTaxRate, 
      this.chargesTaxValue, 
      this.posFloor, 
      this.posTable, 
      this.repId, 
      this.batchArray, 
      this.discountAccount, 
      this.taxAccount, 
      this.tax, 
      this.invRound, 
      this.paymentMethodArray, 
      this.paymentMethodNameArray, 
      this.paidGiftcodes, 
      this.paidArray,
      this.multiplePayment,
      this.shippingMethod, 
      this.customerEmail, 
      this.recipientEmail,
      this.btnradio, 
      this.counterId, 
      this.dineState, 
      this.tag, 
      this.courseArray, 
      this.customerAddressLatitude, 
      this.customerAddressLongitude, 
      this.cusShippingAddress, 
      this.deliveryManId, 
      this.numberOfDiners, 
      this.invNotes, 
      this.language, 
      this.refNo, 
      this.due, 
      this.priceArray, 
      this.qtyArray, 
      this.discArray, 
      this.totalArray, 
      this.descArray, 
      this.itemDiscountValue, 
      this.invoiceItemDiscount, 
      this.menuChildSelectionId, 
      this.menuChildVariationTableId, 
      this.menuChildSelectionQty, 
      this.menuExclusions, 
      this.subTotal, 
      this.invoiceDiscount, 
      this.customDiscount, 
      this.customTax, 
      this.discount, 
      this.total, 
      this.noteArray, 
      this.branchId, 
      this.reload, 
      this.invNum, 
      this.invDate, 
      this.invClass, 
      this.poNum, 
      this.term, 
      this.shipVia, 
      this.fobNum, 
      this.mainInvNumber, 
      this.itemArray, 
      this.isPayByCredit,
      this.taxArray,
      this.actualTotal, 
      this.menuChildParentId, 
      this.invAddress, 
      this.customerFileAttach0mobile, 
      this.localTransactionId,
      this.invId, 
      this.couponId,
      this.invNumber,
      this.invTime, 
      this.invTotal, 
      this.invPaid, 
      this.invDue, 
      this.invType, 
      this.orderStatus, 
      this.customer, 
      this.actualInvoicePayload,
      this.invTax, 
      this.invRoundValue, 
      this.cartItems, 
      this.hold, 
      this.localSynced, 
      this.localUpdatedAt,});

  OfflineTransactionModel.fromJson(dynamic json) {
    int? asInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      return int.tryParse(v.toString());
    }

    double? asDouble(dynamic v) {
      if (v == null) return null;
      if (v is double) return v;
      if (v is int) return v.toDouble();
      return double.tryParse(v.toString());
    }

    bool? asBool(dynamic v) {
      if (v == null) return null;
      if (v is bool) return v;
      if (v is num) return v != 0;
      final s = v.toString().toLowerCase();
      if (s == 'true' || s == '1') return true;
      if (s == 'false' || s == '0') return false;
      return null;
    }

    List<int> asIntList(dynamic v) {
      if (v is! List) return [];
      return v
          .map((e) => asInt(e))
          .whereType<int>()
          .toList();
    }

    List<double> asDoubleList(dynamic v) {
      if (v is! List) return [];
      return v
          .map((e) => asDouble(e))
          .whereType<double>()
          .toList();
    }

    List<String> asStringList(dynamic v) {
      if (v is! List) return [];
      return v.where((e) => e != null).map((e) => e.toString()).toList();
    }

    orderTab = json['order_tab']?.toString();
    action = json['action']?.toString();
    posSession = asInt(json['pos_session']);
    counterCustomer = asInt(json['counter_customer']);
    invoiceSubtotalWithDiscount =
        json['invoice_subtotal_with_discount']?.toString() ??
            json['sub_total']?.toString();
    invWarehouse = asInt(json['inv_warehouse']);
    cusId = asInt(json['cus_id']);
    totalItemQuantity = asInt(json['total_item_quantity']);
    couponId = asInt(json['coupon_id']) ?? 0;
    employeeArray = asStringList(json['employee_array']);
    isChargesApplied = asBool(json['is_charges_applied']);
    unitArray = asIntList(json['unit_array']);
    unitValueArray = asDoubleList(json['unit_value_array']);
    taxInclusive = asIntList(json['tax_inclusive']);
    taxable = asIntList(json['taxable']);
    itemTaxSno = asIntList(json['item_tax_sno']);
    itemTaxRate = asStringList(json['item_tax_rate']);
    itemTaxValue = asDoubleList(json['item_tax_value']);
    newOld = asIntList(json['new_old']);
    deliveryDate = json['delivery_date'];
    tobaccoChargeId = json['tobacco_charge_id'];
    tobaccoRate = json['tobacco_rate'];
   /* if (json['item_tobacco_charge'] != null) {
      itemTobaccoCharge = [];
      json['item_tobacco_charge'].forEach((v) {
        itemTobaccoCharge?.add(Dynamic.fromJson(v));
      });
    }**/
   /* if (json['is_tobacco'] != null) {
      isTobacco = [];
      json['is_tobacco'].forEach((v) {
        isTobacco?.add(Dynamic.fromJson(v));
      });
    }**/
    itemPromotions = json['item_promotions'];
    itemPromotionsMeta = json['item_promotions_meta'];
    itemCoupons = json['item_coupons'];
    itemCouponMeta = json['item_coupon_meta'];
    invCouponId = asInt(json['inv_coupon_id']);
    couponCode = json['coupon_code']?.toString();
    itemEvents = json['item_events'];
    itemEventMeta = json['item_event_meta'];
    isLoyaltyPoints = json['is_loyalty_points']==1?true:false;
    loyaltyScheme = asInt(json['loyalty_scheme']);
    loyaltyPoints = json['loyalty_points']?.toString();
    loyaltyDiscount = asDouble(json['loyalty_discount']);
    if (json['charges_ids'] is List) {
      chargesIds = List<dynamic>.from(json['charges_ids'] as List);
    }
    if (json['charge_rate'] is List) {
      chargeRate = List<dynamic>.from(json['charge_rate'] as List);
    }
    if (json['charge_value'] is List) {
      chargeValue = List<dynamic>.from(json['charge_value'] as List);
    }
    // Older offline rows only store charges_ids / charge_value (no flag).
    if (isChargesApplied != true) {
      final hasChargeIds = chargesIds?.isNotEmpty ?? false;
      final hasChargeValues = chargeValue?.isNotEmpty ?? false;
      if (hasChargeIds || hasChargeValues) {
        isChargesApplied = true;
      }
    }
    chargesTaxIds = json['charges_tax_ids'];
    chargesTaxRate = json['charges_tax_rate'];
    chargesTaxValue = json['charges_tax_value'];
    posFloor = json['pos_floor'];
    posTable = json['pos_table'];
    repId = json['rep_id'];
    batchArray = asStringList(json['batch_array']);
    discountAccount = asInt(json['discount_account']);
    taxAccount = asInt(json['tax_account']);
    tax = asDouble(json['tax']);
    invRound = asDouble(json['inv_round']);
    paymentMethodArray = asIntList(json['payment_method_array']);
    paymentMethodNameArray = asStringList(json['payment_method_name_array']);
    paidGiftcodes = json['paid_giftcodes'];
    paidArray = asDoubleList(json['paid_array']);
    multiplePayment = asInt(json['multiple_payment']);
    shippingMethod = asInt(json['shipping_method']);
    customerEmail = json['customer_email']?.toString();
    recipientEmail =
        json['recipientEmail']?.toString() ?? json['customer_email']?.toString();
    btnradio = json['btnradio']?.toString();
    counterId = asInt(json['counter_id']);
    dineState = asInt(json['dine_state']);
    if (json['tag'] is List) {
      tag = List<String>.from(json['tag'] as List);
    } else if (json['tag'] != null) {
      tag = [json['tag']];
    } else {
      tag = null;
    }
    tag = json['tag'] != null
        ? List<String>.from(
            (json['tag'] as List).where((e) => e != null).map((e) => e.toString()),
          )
        : [];
    courseArray = asStringList(json['course_array']);
    customerAddressLatitude = json['customer_address_latitude']?.toString();
    customerAddressLongitude = json['customer_address_longitude']?.toString();
    cusShippingAddress = json['cus_shipping_address']?.toString();
    deliveryManId = json['delivery_man_id'];
    numberOfDiners = asInt(json['number_of_diners']);
    invNotes = json['inv_notes']?.toString();
    language = json['language']?.toString();
    refNo = json['ref_no'];
    due = asDouble(json['due']);
    priceArray = asDoubleList(json['price_array']);
    qtyArray = asIntList(json['qty_array']);
    discArray = asStringList(json['disc_array']);
    totalArray = asStringList(json['total_array']);
    descArray = asStringList(json['desc_array']);
    itemDiscountValue = asDoubleList(json['item_discount_value']);
    invoiceItemDiscount = asDoubleList(json['invoice_item_discount']);
    menuChildSelectionId = json['menuChildSelectionId'];
    menuChildVariationTableId = json['menuChildVariationTableId'];
    menuChildSelectionQty = json['menuChildSelectionQty'];
    menuExclusions = json['menuExclusions'];
    subTotal = asDouble(json['sub_total']);
    invoiceDiscount = asDouble(json['invoiceDiscount']);
    customDiscount = json['custom_discount']?.toString();
    customTax = json['custom_tax']?.toString();
    discount = asDouble(json['discount']);
    total = asDouble(json['total']);
    noteArray = asStringList(json['note_array']);
    branchId = asInt(json['branch_id']);
    reload = asInt(json['reload']);
    invNum = json['inv_num']?.toString();
    invDate = json['inv_date']?.toString();
    invClass = asInt(json['inv_class']);
    poNum = asInt(json['po_num']);
    term = asInt(json['term']);
    shipVia = asInt(json['ship_via']);
    fobNum = asInt(json['fob_num']);
    isPayByCredit = asBool(json['is_paid_by_credit']);
    mainInvNumber = json['main_inv_number']?.toString();
    itemArray = asIntList(json['item_array']);
    taxArray = asDoubleList(json['tax_array']);
    actualTotal = asDouble(json['actual_total']);
    menuChildParentId = json['menuChildParentId']?.toString();
    invAddress = json['inv_address']?.toString();
    customerFileAttach0mobile = json['customer_file_attach_0mobile']?.toString();
    localTransactionId =
        (json['local_transaction_id'] ?? json['local_invoice_id'])?.toString();
    invId = asInt(json['inv_id']);
    invNumber = json['inv_number']?.toString();
    invTime = json['inv_time']?.toString();
    invTotal = asDouble(json['inv_total']);
    invPaid = asDouble(json['inv_paid']);
    invDue = asDouble(json['inv_due']);
    invType = asInt(json['inv_type']);
    orderStatus = json['order_status']?.toString();
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    final actualPayloadRaw = json['actual_invoice_payload'];
    if (actualPayloadRaw is Map) {
      actualInvoicePayload = Map<String, dynamic>.from(actualPayloadRaw);
    } else if (actualPayloadRaw is String && actualPayloadRaw.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(actualPayloadRaw);
        if (decoded is Map) {
          actualInvoicePayload = Map<String, dynamic>.from(decoded);
        }
      } catch (_) {}
    }
    invTax = asDouble(json['inv_tax']);
    invRoundValue = asDouble(json['inv_round_value']);
    if (json['cart_items'] != null) {
      cartItems = [];
      json['cart_items'].forEach((v) {
        cartItems?.add(CartItems.fromJson(v));
      });
    }
    hold = asBool(json['hold']);
    localSynced = asBool(json['_local_synced']);
    localUpdatedAt = asInt(json['_local_updated_at']);
  }
  String? orderTab;
  String? action;
  int? posSession;
  int? counterCustomer;
  String? invoiceSubtotalWithDiscount;
  int? invWarehouse;
  int? cusId;
  int? totalItemQuantity;
  int? couponId;
  bool? isChargesApplied;
  List<String>? employeeArray;
  List<int>? unitArray;
  List<double>? unitValueArray;
  List<int>? taxInclusive;
  List<int>? taxable;
  List<int>? itemTaxSno;
  List<String>? itemTaxRate;
  List<double>? itemTaxValue;
  List<int>? newOld;
  String? deliveryDate;
  String? tobaccoChargeId;
  String? tobaccoRate;
  List<dynamic>? itemTobaccoCharge;
  List<dynamic>? isTobacco;
  dynamic itemPromotions;
  dynamic itemPromotionsMeta;
  dynamic itemCoupons;
  dynamic itemCouponMeta;
  int? invCouponId;
  String? couponCode;
  dynamic itemEvents;
  dynamic itemEventMeta;
  bool? isLoyaltyPoints;
  int? loyaltyScheme;
  String? loyaltyPoints;
  double? loyaltyDiscount;
  List<dynamic>? chargesIds;
  List<dynamic>? chargeRate;
  List<dynamic>? chargeValue;
  dynamic chargesTaxIds;
  dynamic chargesTaxRate;
  dynamic chargesTaxValue;
  dynamic posFloor;
  dynamic posTable;
  dynamic repId;
  List<String>? batchArray;
  int? discountAccount;
  int? taxAccount;
  double? tax;
  double? invRound;
  List<int>? paymentMethodArray;
  List<String>? paymentMethodNameArray;
  dynamic paidGiftcodes;
  List<double>? paidArray;
  int? multiplePayment;
  int? shippingMethod;
  String? customerEmail;
  String? recipientEmail;
  String? btnradio;
  int? counterId;
  int? dineState;
  List<String>? tag;
  List<String>? courseArray;
  String? customerAddressLatitude;
  String? customerAddressLongitude;
  String? cusShippingAddress;
  dynamic deliveryManId;
  int? numberOfDiners;
  String? invNotes;
  String? language;
  dynamic refNo;
  double? due;
  List<double>? priceArray;
  List<int>? qtyArray;
  List<String>? discArray;
  List<String>? totalArray;
  List<String>? descArray;
  List<double>? itemDiscountValue;
  List<double>? invoiceItemDiscount;
  dynamic menuChildSelectionId;
  dynamic menuChildVariationTableId;
  dynamic menuChildSelectionQty;
  dynamic menuExclusions;
  double? subTotal;
  double? invoiceDiscount;
  String? customDiscount;
  String? customTax;
  double? discount;
  double? total;
  List<String>? noteArray;
  int? branchId;
  int? reload;
  String? invNum;
  String? invDate;
  int? invClass;
  int? poNum;
  int? term;
  int? shipVia;
  int? fobNum;
  String? mainInvNumber;
  List<int>? itemArray;
  List<double>? taxArray;
  double? actualTotal;
  String? menuChildParentId;
  String? invAddress;
  String? customerFileAttach0mobile;
  String? localTransactionId;
  int? invId;
  String? invNumber;
  String? invTime;
  double? invTotal;
  double? invPaid;
  double? invDue;
  int? invType;
  String? orderStatus;
  Customer? customer;
  Map<String, dynamic>? actualInvoicePayload;
  double? invTax;
  double? invRoundValue;
  List<CartItems>? cartItems;
  bool? hold;
  bool? isPayByCredit;
  bool? localSynced;
  int? localUpdatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_tab'] = orderTab;
    map['action'] = action;
    map['pos_session'] = posSession;
    map['counter_customer'] = counterCustomer;
    map['inv_warehouse'] = invWarehouse;
    map['invoice_subtotal_with_discount'] = invoiceSubtotalWithDiscount;
    map['cus_id'] = cusId;
    map['employee_array'] = employeeArray;
    map['is_charges_applied'] = isChargesApplied;
    map['unit_array'] = unitArray;
    map['unit_value_array'] = unitValueArray;
    map['tax_inclusive'] = taxInclusive;
    map['taxable'] = taxable;
    map['item_tax_sno'] = itemTaxSno;
    map['item_tax_rate'] = itemTaxRate;
    map['item_tax_value'] = itemTaxValue;
    map['new_old'] = newOld;
    map['delivery_date'] = deliveryDate;
    map['total_item_quantity'] = totalItemQuantity;
    map['is_paid_by_credit'] = isPayByCredit;
    map['tobacco_charge_id'] = tobaccoChargeId;
    map['tobacco_rate'] = tobaccoRate;
    if (itemTobaccoCharge != null) {
      map['item_tobacco_charge'] = List<dynamic>.from(itemTobaccoCharge!);
    }
    if (isTobacco != null) {
      map['is_tobacco'] = List<dynamic>.from(isTobacco!);
    }
    map['item_promotions'] = itemPromotions;
    map['item_promotions_meta'] = itemPromotionsMeta;
    map['item_coupons'] = itemCoupons;
    map['item_coupon_meta'] = itemCouponMeta;
    map['inv_coupon_id'] = invCouponId;
    map['coupon_code'] = couponCode;
    map['item_events'] = itemEvents;
    map['item_event_meta'] = itemEventMeta;
    map['is_loyalty_points'] = isLoyaltyPoints;
    map['loyalty_scheme'] = loyaltyScheme;
    map['loyalty_points'] = loyaltyPoints;
    map['loyalty_discount'] = loyaltyDiscount;
    if (chargesIds != null) {
      map['charges_ids'] = List<dynamic>.from(chargesIds!);
    }
    if (chargeRate != null) {
      map['charge_rate'] = List<dynamic>.from(chargeRate!);
    }
    if (chargeValue != null) {
      map['charge_value'] = List<dynamic>.from(chargeValue!);
    }
    map['charges_tax_ids'] = chargesTaxIds;
    map['coupon_id'] = couponId;
    map['charges_tax_rate'] = chargesTaxRate;
    map['charges_tax_value'] = chargesTaxValue;
    map['pos_floor'] = posFloor;
    map['pos_table'] = posTable;
    map['rep_id'] = repId;
    map['batch_array'] = batchArray;
    map['discount_account'] = discountAccount;
    map['tax_account'] = taxAccount;
    map['tax'] = tax;
    map['inv_round'] = invRound;
    map['payment_method_array'] = paymentMethodArray;
    map['payment_method_name_array'] = paymentMethodNameArray;
    map['paid_giftcodes'] = paidGiftcodes;
    map['paid_array'] = paidArray;
    map['multiple_payment'] = multiplePayment;
    map['shipping_method'] = shippingMethod;
    map['customer_email'] = customerEmail;
    map['recipientEmail'] = recipientEmail;
    map['btnradio'] = btnradio;
    map['counter_id'] = counterId;
    map['dine_state'] = dineState;
    if (tag != null) {
      map['tag'] = tag;
    }
    map['course_array'] = courseArray;
    map['customer_address_latitude'] = customerAddressLatitude;
    map['customer_address_longitude'] = customerAddressLongitude;
    map['cus_shipping_address'] = cusShippingAddress;
    map['delivery_man_id'] = deliveryManId;
    map['number_of_diners'] = numberOfDiners;
    map['inv_notes'] = invNotes;
    map['language'] = language;
    map['ref_no'] = refNo;
    map['due'] = due;
    map['price_array'] = priceArray;
    map['qty_array'] = qtyArray;
    map['disc_array'] = discArray;
    map['total_array'] = totalArray;
    map['desc_array'] = descArray;
    map['item_discount_value'] = itemDiscountValue;
    map['invoice_item_discount'] = invoiceItemDiscount;
    map['menuChildSelectionId'] = menuChildSelectionId;
    map['menuChildVariationTableId'] = menuChildVariationTableId;
    map['menuChildSelectionQty'] = menuChildSelectionQty;
    map['menuExclusions'] = menuExclusions;
    map['sub_total'] = subTotal;
    map['invoiceDiscount'] = invoiceDiscount;
    map['custom_discount'] = customDiscount;
    map['custom_tax'] = customTax;
    map['discount'] = discount;
    map['total'] = total;
    map['note_array'] = noteArray;
    map['branch_id'] = branchId;
    map['reload'] = reload;
    map['inv_num'] = invNum;
    map['inv_date'] = invDate;
    map['inv_class'] = invClass;
    map['po_num'] = poNum;
    map['term'] = term;
    map['ship_via'] = shipVia;
    map['fob_num'] = fobNum;
    map['main_inv_number'] = mainInvNumber;
    map['item_array'] = itemArray;
    map['tax_array'] = taxArray;
    map['actual_total'] = actualTotal;
    map['menuChildParentId'] = menuChildParentId;
    map['inv_address'] = invAddress;
    map['customer_file_attach_0mobile'] = customerFileAttach0mobile;
    map['local_transaction_id'] = localTransactionId;
    map['local_invoice_id'] = localTransactionId;
    map['inv_id'] = invId;
    map['inv_number'] = invNumber;
    map['inv_time'] = invTime;
    map['inv_total'] = invTotal;
    map['inv_paid'] = invPaid;
    map['inv_due'] = invDue;
    map['inv_type'] = invType;
    map['order_status'] = orderStatus;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    if (actualInvoicePayload != null) {
      map['actual_invoice_payload'] = actualInvoicePayload;
    }
    map['inv_tax'] = invTax;
    map['inv_round_value'] = invRoundValue;
    if (cartItems != null) {
      map['cart_items'] = cartItems?.map((v) => v.toJson()).toList();
    }
    map['hold'] = hold;
    map['_local_synced'] = localSynced;
    map['_local_updated_at'] = localUpdatedAt;
    return map;
  }

}