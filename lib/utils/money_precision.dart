/// Runtime money decimal places from `CategoryModel.rounding_decimal`.
///
/// Used for **display only** (e.g. `4` → `4.0000`). Calculations keep the
/// exact numeric value — no intermediate round-off.
///
/// Prefer [format] / [asDouble] — cart totals are often `dynamic` and Dart
/// extensions do not apply to `dynamic`.
class MoneyPrecision {
  MoneyPrecision._();

  static int _decimals = 2;

  /// Active fraction digits (clamped 0–8). Default 2 until category loads.
  static int get decimals => _decimals;

  static void setDecimals(int? value) {
    final parsed = value ?? 2;
    _decimals = parsed < 0 ? 0 : (parsed > 8 ? 8 : parsed);
  }

  static void setFromRoundingDecimal(dynamic raw) {
    if (raw is int) {
      setDecimals(raw);
      return;
    }
    setDecimals(int.tryParse('$raw') ?? 2);
  }

  static double _asDouble(Object? value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  /// Exact numeric value — does **not** round.
  static double asDouble(Object? value) => _asDouble(value);

  /// @Deprecated Use [asDouble]. Kept as alias; does not round.
  static double round(Object? value) => _asDouble(value);

  /// Display string with [decimals] places (e.g. `1.2` → `1.2000` when decimals=4).
  static String format(Object? value) {
    return _asDouble(value).toStringAsFixed(decimals);
  }
}
