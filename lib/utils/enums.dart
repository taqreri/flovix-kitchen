enum LoginEnum { initial, loading, success, error }
enum SessionStatusEnum { initial, loading, success, error }
enum StartSessionStatus { initial, loading, success, error }
enum CategoryEnum { initial, loading, success, error,unAuthorized }
enum ProductEnum { initial, loading, success, error,unAuthorized }
enum GetDialCodeEnum { initial, loading, success, error }
enum CounterDiscountEnum { initial, loading, success, error }
enum SingleProductEnum { initial, loading, success, error }
enum ProductPaginationEnum { initial, loading, success, error }
enum CartListEnum { initial, loading, success, error }
enum OrderTagEnum { initial, loading, success, error }
enum CouponCodeEnum { initial, loading, success, error }
enum GiftCardEnum { initial, loading, success, error }

enum OrderTypesEnum { initial, loading, success, error }
enum FloorListEnum { initial, loading, success, error }
enum FloorTableListEnum { initial, loading, success, error }
enum PaymentMethodEnum { initial, loading, success, error }
enum CreateCustomerEnum { initial, loading, success, error }
enum SaleRepresentativeListEnum { initial, loading, success, error }
enum DeliveryListEnum { initial, loading, success, error }
enum ShippingListEnum { initial, loading, success, error }
enum CartTotalEnum { initial, loading, success, error,unAuthorized }
enum TransactionEnum { initial, loading, success, error ,unAuthorized}
enum SessionEnum { initial, loading, success, error }
enum TransactionPaginationEnum { initial, loading, success, error,unAuthorized }
enum TransactionDetailEnum { initial, loading, success, error }
enum PrintFileEnum { initial, loading, success, error }
enum AppUpdateEnum { initial, loading, success, error }
enum AppSettingEnum { initial, loading, success, error }
enum HomeEnum { initial, loading, success, error,unAuthorized }
enum LogoutEnum { initial, loading, success, error }
enum RoundAccountEnum { initial, loading, success, error,unAuthorized }
enum NotificationEnum { initial, loading, success, error,unAuthorized }
enum UpdateSettingEnum { initial, loading, success, error,unAuthorized }

enum PrintingMode {
  /// Nothing to print (save-order with invoice + KOT disabled).
  none,

  /// KOT printing disabled; only the invoice will be printed.
  invoiceOnly,

  /// Regular KOT only (no invoice) — save-order KOT without invoice.
  kotOnly,

  /// Regular KOT printing along with the invoice.
  regularKot,

  /// Group KOT printing along with the invoice.
  groupKot,

  /// Group KOT only (no invoice) — save-order grouped KOT without invoice.
  groupKotOnly,
}
enum Status {initial, loading, completed, error }

