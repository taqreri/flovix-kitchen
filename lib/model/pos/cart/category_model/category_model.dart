

import 'package:flovix_kitchen/model/employee/Employee_model.dart';
import 'package:flovix_kitchen/model/pos/cart/category_model/Promotion_model.dart';
import 'package:flovix_kitchen/model/pos/coupon/Coupon_model.dart';
import 'package:flovix_kitchen/model/pos/sale_representative/sale_representative_model.dart';
import 'package:flovix_kitchen/model/pos/shipping_model/shipping_model.dart';
import 'package:flovix_kitchen/utils/money_precision.dart';

import 'Charges_model.dart';
import 'Loyalty_points_model.dart';
import 'Timed_events.dart';
import 'branchinfo_model.dart';
import 'counterDetails.dart';
import 'counter_printer.dart';
import 'customer_model.dart';

/// cat_id : 35
/// cat_label : "Broast"
/// cat_label_ar : "بروست"
/// cat_image_link : "https://taqreri-cdn.fra1.digitaloceanspaces.com/company_files/userdb_347_28385/images/cuserdb230611110351am1322.jpg"
/// is_default : true
/// branch_id : 0

class CategoryItemModel {
  CategoryItemModel({
    this.catId,
    this.catLabel,
    this.catLabelAr,
    this.catImageLink,
    //  this.counterDetails,
    this.isDefault,
    this.branchId,
  });

  CategoryItemModel.fromJson(dynamic json) {
    catId = json['cat_id'];
    catLabel = json['cat_label'];
    catLabelAr = json['cat_label_ar'];
    catImageLink = json['cat_image_link'];
    isDefault = json['is_default'];
    branchId = json['branch_id'];

    //   counterDetails =json['counter_detail'] != null ? CounterDetails.fromJson(json['counter_detail']) : null ;
  }

  int? catId;
  String? catLabel;
  String? catLabelAr;
  String? catImageLink;
  bool? isDefault;
  int? branchId;

  // CounterDetails? counterDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cat_id'] = catId;
    map['cat_label'] = catLabel;
    //  map['counter_detail'] = counterDetails;
    map['cat_label_ar'] = catLabelAr;
    map['cat_image_link'] = catImageLink;
    map['is_default'] = isDefault;
    map['branch_id'] = branchId;
    return map;
  }
}

class CategoryModel {
  CounterDetails? counterDetails;
  BranchInfoModel? branchInfoModel;
  CounterPrinter? counterPrinter;
  int? invoiceStartingNumber;
  bool? isLoyalityEnabled;
  List<CategoryItemModel>? categoryItemList;
  List<ChargesModel>? chargesList;
  List<LoyaltyPointsModel>? loyaltyPointList;
  List<EmployeeModel>? employeeList;
  List<CustomerModel>? customerList;
  List<ShippingModel>? shippingMethodList;
  List<SaleRepresentativeModel>? deliveryManList;
  List<PromotionModel>? promotions;
  List<TimedEvents>? timedEvents;
  List<SaleRepresentativeModel>? saleManList;
  int? roundingDecimal;
  List<CouponModel>? couponList;

  CategoryModel(
      {this.counterPrinter,
      this.counterDetails,
      this.categoryItemList,
      this.promotions,
      this.invoiceStartingNumber,
      this.branchInfoModel,
      this.deliveryManList,
      this.loyaltyPointList,
      this.saleManList,
      this.customerList,
      this.isLoyalityEnabled,
      this.couponList,
      this.shippingMethodList,
      this.roundingDecimal,
      this.employeeList});

  CategoryModel.fromJson(dynamic json) {
    //   counterDetails = json['counter_detail'];
  //  invoiceStartingNumber =100;
    invoiceStartingNumber = json['invoice_starting_number']??0;
    // counterPrinter = json['counter_printer'];
    if (json['product_categories'] != null) {
      categoryItemList = [];

      json['product_categories'].forEach((v) {
        categoryItemList?.add(CategoryItemModel.fromJson(v));
      });
    }
    if (json['charges'] != null) {
      chargesList = [];
      json['charges'].forEach((v) {
        chargesList?.add(ChargesModel.fromJson(v));
      });
    }

    if (json['loyality_point_list'] != null) {
      loyaltyPointList = [];
      json['loyality_point_list'].forEach((v) {
        loyaltyPointList?.add(LoyaltyPointsModel.fromJson(v));
      });
    }
    if (json['sales_man'] != null) {
      saleManList = [];
      json['sales_man'].forEach((v) {
        saleManList?.add(SaleRepresentativeModel.fromJson(v));
      });
    }
    if (json['coupen_code_list'] != null) {
      couponList = [];
      json['coupen_code_list'].forEach((v) {
        couponList?.add(CouponModel.fromJson(v));
      });
    }
    if (json['delivery_mans'] != null) {
      deliveryManList = [];
      json['delivery_mans'].forEach((v) {
        deliveryManList?.add(SaleRepresentativeModel.fromJson(v));
      });
    }
    if (json['promotions'] != null) {
      promotions = [];
      json['promotions'].forEach((v) {
        promotions?.add(PromotionModel.fromJson(v));
      });
    }
    if (json['timed_events'] != null) {
      timedEvents = [];
      json['timed_events'].forEach((v) {
        timedEvents?.add(TimedEvents.fromJson(v));
      });
    }
    if (json['customers'] != null) {
      customerList = [];
      json['customers'].forEach((v) {
        customerList?.add(CustomerModel.fromJson(v));
      });
    }
    if (json['shipping_methods'] != null) {
      shippingMethodList = [];
      json['shipping_methods'].forEach((v) {
        shippingMethodList?.add(ShippingModel.fromJson(v));
      });
    }
    if (json['employees'] != null) {
      employeeList = [];
      json['employees'].forEach((v) {
        employeeList?.add(EmployeeModel.fromJson(v));
      });
    }

    isLoyalityEnabled = json['is_loyality_enabled'] ?? false;
    roundingDecimal = int.tryParse('${json['rounding_decimals'] ?? 2}') ?? 2;
    MoneyPrecision.setDecimals(roundingDecimal);
    counterDetails = json['counter_detail'] != null
        ? CounterDetails.fromJson(json['counter_detail'])
        : null;
    branchInfoModel = json['branch_info'] != null
        ? BranchInfoModel.fromJson(json['branch_info'])
        : null;
    
    counterPrinter = json["counter_detail"]['main_printer'] != null
        ? CounterPrinter.fromJson(json["counter_detail"]['main_printer'])
        : null;
  }
}
