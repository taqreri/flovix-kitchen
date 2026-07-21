import 'package:flovix_kitchen/config/app_env.dart';

class AppUrl {
  // asset url
  static const String assetUrl = AppEnv.assetBaseUrl;

  // api url
  static const String apiEndPoint = AppEnv.apiBaseUrl;
  //static const String apiEndPoint = "https://posapi.taqreri.com/api";
  static const String apiEndPoint2 = AppEnv.webBaseUrl;
  static const String splashUrl = "$apiEndPoint2/splash";
  static const String appSettingsEndpoint =
      "$apiEndPoint2/general.php?action=site_config";
  static const String appUpdateEndpoint = "$apiEndPoint/app_version?slug=pos_app";
  static const String loginUrl = "$apiEndPoint/user/login";
  static const String deviceLogin = "$apiEndPoint/user/device-login";
  static const String selectBranchUrl = "$apiEndPoint/branches";
  static const String appSettingUrl =
      "$apiEndPoint/general.php?action=site_config";
  static const String pdfFilesUrl = "$apiEndPoint2/generate_pdf.php";
  static const String getInvoicesUrl =
      "$apiEndPoint/pos/invoice/getTransactionList";
  static const String getHomeScreenEndpoint =
      "$apiEndPoint/pos/getDashboardData";  static const String logoutEndpoint =
      "$apiEndPoint/user/device-logout";
  static const String changeTemplateUrl =
      "$apiEndPoint/pos/posPrintPages/changeTemplate";
  static const String getDefaultTemplate =
      "$apiEndPoint/pos/posPrintPages/getDefaultTemplate";
  static const String closeSession = "$apiEndPoint/pos/posSession/closeSession";
  static const String closeSessionModal =
      "$apiEndPoint/pos/posSession/closeSessionModal";
  static const String invoiceTemplate6Url =
      "$apiEndPoint/pos/posPrintPages/print";
  static const String posSessionlist =
      "$apiEndPoint/pos/posSession/posSessionlist?page=1";
  static const String getSessionSummary =
      "$apiEndPoint/pos/posSession/getSessionSummary/";
  static const String getSingleProduct = "$apiEndPoint/pos/products/";
  static const String getSessionList =
      "$apiEndPoint/pos/posSession/getSessionList";
  static const String sessionStatus =
      "$apiEndPoint/pos/posSession/sessionStatus";
  static const String newSessionModal =
      "$apiEndPoint/pos/posSession/newSessionModal";
  static const String createPosSession =
      "$apiEndPoint/pos/posSession/createPosSession";
  static const String getUserList = "$apiEndPoint/userList";
  static const String searchProductList = "$apiEndPoint/pos/products/search";
  static const String registerUrl = "$apiEndPoint/register";
  static const String profileUrl = "$apiEndPoint/profile";
  static const String homeUrl = "$apiEndPoint/home";
  static const String getCategoriesUrl = "$apiEndPoint/pos/pos-main";
  static const String createCustomerUrl = "$apiEndPoint/pos/customer";
  static const String customerDetailEndpoint = "$apiEndPoint/pos/customer";
  static const String loyaltyPointDetailEndpoint = "$apiEndPoint/pos/customer/loyalty-points";
  static const String getDialCodes = "$apiEndPoint/pos/customer/dial_codes";
  static const String getOrderTagData = "$apiEndPoint/pos/invoice/tags/4";
  static const String getOrderTypeData = "$apiEndPoint/pos/invoice/orderTypes";
  static const String posMainUrl = "$apiEndPoint/pos/pos-main";
  static const String applyCouponEndpoint = "$apiEndPoint/pos/coupon/apply";
  static const String applyGiftCardEndpoint = "$apiEndPoint/pos/gift-card/apply";
  static const String createPosUrl = "$apiEndPoint/pos/pos-counters";
  static const String updatePosUrl = "$apiEndPoint/pos/pos-counters";
  static const String getAddProductModel =
      "$apiEndPoint/pos/products/createProductModalData";
  static const String newProductUrl = "$apiEndPoint/pos/products/save_item_new";
  static const String createPrnterUrl = "$apiEndPoint/pos/printer-group/create";

  // static const String getDefaultTemplate =
  //     "$apiEndPoint/pos/posPrintPages/getDefaultTemplate";
  static const String getdefaultCustomerPosUrl =
      "$apiEndPoint/pos/customer/show-all";

  static const String getAllCountersUrlA = "$apiEndPoint/shipping-method";
  static const String getAllCountersUrl = "$apiEndPoint/pos/pos-counters";
  static const String getAllTaxItemsUrl = "$apiEndPoint/pos/tax/taxList";
  static const String getAllPaymentMethodUrl =
      "$apiEndPoint/payment-method?language=en&status=1&branch=";
  static const String getAllSuppliersUrl = "$apiEndPoint/pos/supplier_list";
  static String getNotificationUrl({int page = 1, int perPage = 5}) =>
      "$apiEndPoint/pos/notifications?channel=1&per_page=$perPage&page=$page";
  static const String markNotificationsReadUrl =
      "$apiEndPoint/pos/notifications/mark-multiple-read";
  static const String getRoundingAccountEndpoints = "$apiEndPoint/pos/pos-counters/main/settings";
  static const String updateSettingsEndpoints = "$apiEndPoint/pos/pos-counters/update-pos-settings";
  static const String getAllDiscountItemsurl = "$apiEndPoint/pos/discount";
  static const String getAllPrinters = "$apiEndPoint/pos/printer-group";
  static const String getFloorEndPoint = "$apiEndPoint/pos/floor-table";
  static const String getShippingTable = "$apiEndPoint/shipping-method";
  static const String getPaymentMethod = "$apiEndPoint/payment-method";
  static const String deleteInvoiceItem =
      "$apiEndPoint/pos/invoice/delete-item/";
  static const String createInvoiceUrl = "$apiEndPoint/pos/invoice/create";
  static const String saleReturnUrl = "$apiEndPoint/pos/invoice/pos/sale_return";

  static const String getFloorTableEndPoint = "$apiEndPoint/pos/floor-table";
  static const String getTransactionDetailEndPoint =
      "$apiEndPoint/pos/invoice/get-order/";
  static const String getSaleRepresentativeEndPoint =
      "$apiEndPoint/pos/sales-person";
  static const String getDiscountList =
      "$apiEndPoint/pos/discount?type=8&status=1";
  static const String getproductCategoryPosUrl =
      "$apiEndPoint/pos/products_by_category";
  static const String getProductByCategoryId =
      "$apiEndPoint/pos/products_by_category";
  static const String getAllProducts =
      "$apiEndPoint/pos/products/syncAllProducts";
//pos/discount
}

