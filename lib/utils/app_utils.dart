import 'dart:async';
import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flovix_kitchen/services/session_manager/session_controller.dart';
import 'package:flovix_kitchen/utils/routes/routes_name.dart';
import 'package:flovix_kitchen/utils/safe_navigator.dart';
import 'package:flovix_kitchen/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors/colors.dart';
import 'money_precision.dart';


/// App-wide [ScaffoldMessenger] — toasts without [Navigator] routes (avoids _debugLocked).
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class AppUtils {
  static String mapKey = "AIzaSyAg3oppfEdKuulNyrKzM1_ZpfWNXDSnjW8";
  static double dropDownHeight = 0.07;
  static const String _offlineInvoiceCounterKey = 'offline_invoice_counter';
  static bool isCurrentTimeInRange(String startTime, String endTime) {
    final now = DateTime.now();

    // Parse "HH:mm:ss"
    final nowSec = now.hour * 3600 + now.minute * 60 + now.second;

    final start = DateFormat("HH:mm:ss").parse(startTime);
    final end = DateFormat("HH:mm:ss").parse(endTime);

    final startSec = start.hour * 3600 + start.minute * 60 + start.second;
    final endSec = end.hour * 3600 + end.minute * 60 + end.second;

    // Normal range: e.g. 06:00:00 -> 16:00:00
    if (startSec <= endSec) {
      return nowSec >= startSec && nowSec <= endSec;
    }

    // Overnight range: e.g. 22:00:00 -> 06:00:00
    return nowSec >= startSec || nowSec <= endSec;
  }

  static bool isCurrentDateTimeInRange(
      String startDate, String endDate, String startTime, String endTime) {
    final now = DateTime.now();
    final dateOnly = DateFormat('yyyy-MM-dd');
    final timeOnly = DateFormat('HH:mm:ss');

    final startD = dateOnly.parseStrict(startDate);
    final endD = dateOnly.parseStrict(endDate);
    final nowD = DateTime(now.year, now.month, now.day);

    // Date must be inside campaign/event date range.
    if (nowD.isBefore(startD) || nowD.isAfter(endD)) {
      return false;
    }

    final startT = timeOnly.parseStrict(startTime);
    final endT = timeOnly.parseStrict(endTime);

    final nowSec = now.hour * 3600 + now.minute * 60 + now.second;
    final startSec = startT.hour * 3600 + startT.minute * 60 + startT.second;
    final endSec = endT.hour * 3600 + endT.minute * 60 + endT.second;

    // Date is valid; enforce daily time window for every day in range.
    if (startSec <= endSec) {
      return nowSec >= startSec && nowSec <= endSec;
    }

    // Overnight range: e.g. 22:00:00 -> 06:00:00
    return nowSec >= startSec || nowSec <= endSec;
  }

  static String generateRandomString(int length) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();

    return List.generate(
      length,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }

  static BorderRadiusGeometry borderRadius(
      {required BuildContext context, double? radius}) {
    return BorderRadius.circular(SizeConfig.width(context, radius ?? 0.02));
  }

  static List<BoxShadow> boxShadow({required BuildContext context}) {
    return [
      BoxShadow(
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 2),
          color: Colors.black12),
    ];
  }

  static double? timeEventPriceCalculation(
      {double? price,
      double? amount,
      double? percentage,
      int? type,
      int? quantity}) {
    // Handle null safety for quantity - default to 1 if null
    final safeQuantity = quantity ?? 1;
debugPrint("timed event type ${type} ${price} ${amount} ${safeQuantity}");
    if (type == 1) {
      return (amount ?? 0.0) * safeQuantity;
    } else if (type == 2) {
      return (price ?? 0.0) -( (amount ?? 0.0)* safeQuantity);
     // return (price??0.0 - 25.00 ?? 0.0) * double.parse(safeQuantity.toString()??"0.0");
    } else if (type == 3) {
      // Handle null safety for amount and percentage


      final safeAmount = amount ?? 0.0;
      double percent = ((price ?? 0.0*safeQuantity)) * (safeAmount / 100);
      return ((price ?? 0.0) - percent) ;
    } else if (type == 4) {
      return (price ?? 0.0) + ((amount ?? 0.0) * safeQuantity);
    } else if (type == 5) {
      // Handle null safety for amount and percentage
      final safeAmount = amount ?? 0.0;
      double percent = ((price ?? 0.0*safeQuantity)) * (safeAmount / 100);
      return ((price ?? 0.0) + percent) ;
    }
    return null; // Return null if type doesn't match any case
  }

  static bool? timeEventAddProduct({int? sellable, int? type}) {
    // Handle null safety for quantity - default to 1 if null

    if (type == 6) {
      return true;
    }
    if (type == 7) {
      return false;
    }
    return null; // Return null if type doesn't match any case
  }

  static int getFractional({required double value, required int isRoundOff}) {
    int roundedIntegerPart = value.round();
    

    // Get the fractional part
    double fractionalPart = value - roundedIntegerPart;

    
    // Return a map or list with the rounded integer and fractional part

    return roundedIntegerPart;
  }

  static String? getProductPrice(
      {required String price, String? name, String? discount,bool isShowProductPrice=false})
  {
    final basePrice = parseAmount(price);


    double finalPrice = basePrice;
if(isShowProductPrice){
  return MoneyPrecision.format(finalPrice);
}
    if (discount != null && discount.trim().isNotEmpty) {
      final rawDiscount = discount.trim();

      if (rawDiscount.contains('%')) {
        final percent = parseAmount(removePercent(rawDiscount));
       // debugPrint("inside the rawDiscount.contains('%') ${rawDiscount} ${percent}");
        finalPrice = basePrice * (( percent) / 100);
        finalPrice=basePrice-finalPrice;
      //  debugPrint("inside the rawDiscount.contains('%') ${name} $basePrice $finalPrice ${rawDiscount} ${percent}");

      } else {
        final fixedDiscount = parseAmount(rawDiscount);
        finalPrice = basePrice - fixedDiscount;
       // debugPrint("inside the rawDiscount.contains('%') else ${name} $basePrice $finalPrice ${rawDiscount} ");

      }

      if (finalPrice.isNegative) {
        finalPrice = 0.0;
      }
    }
   // debugPrint ("product name and final price ${price} ${name} ${basePrice} ${finalPrice} ${discount}");
    return MoneyPrecision.format(finalPrice);
  }
  static String formatDateToYMD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  static generateRandomNumberForItem(String itemId) {
    // Use the itemId as a seed to generate randomness
    Random random = Random(itemId.hashCode);

    // Generate a random 9-digit number
    String randomNumber = '';
    for (int i = 0; i < 9; i++) {
      randomNumber += random.nextInt(10).toString(); // Generates a random digit (0-9)
    }

    return randomNumber;
  }

  static Future<String> generateOfflineInvoiceNumber(
      dynamic invoiceGenerateNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getInt(_offlineInvoiceCounterKey);
    final startingValue = int.tryParse(invoiceGenerateNumber?.toString() ?? '0') ?? 0;

    final baseValue = stored != null
        ? (stored > startingValue ? stored : startingValue)
        : startingValue;
    final nextValue = baseValue + 1;
    await prefs.setInt(_offlineInvoiceCounterKey, nextValue);
    return nextValue.toString();
  }

  static int generateRandomNumber(int length) {
    if (length <= 0) {
      throw ArgumentError('Length must be greater than zero');
    }

    final random = Random();
    int min = pow(10, length - 1).toInt();
    int max = pow(10, length).toInt() - 1;

    return min + random.nextInt(max - min);
  }

  static double roundOffAndGetFractional(
      {required double value, required isRoundOff}) {
    // Get the integer part
    // Round the value to the nearest integer
    if (isRoundOff == 0) {
      return value;
    }
    int roundedIntegerPart = value.round();

    // Get the fractional part
    double fractionalPart = value - roundedIntegerPart;

    
    // Return a map or list with the rounded integer and fractional part
    if (fractionalPart.isNegative) {
      return fractionalPart.abs();
    } else {
      return -fractionalPart;
    }
    return 56.5;
  }

  static String removePercent(String s) {
    return s.contains('%') ? s.replaceAll('%', '') : s;
  }

  static double parseAmount(String? value) {
    if (value == null) return 0.0;
    final cleaned = value
        .replaceAll(',', '')
        .replaceAll(RegExp(r'[^0-9.\-]'), '')
        .trim();
    return double.tryParse(cleaned) ?? 0.0;
  }

  static Flushbar<dynamic>? _currentFlushbar;
  static bool _flushbarShowScheduled = false;

  static String getFormattedDate() {
    // Get current date and time
    DateTime now = DateTime.now();

    // Define the desired date format
    DateFormat formatter = DateFormat('dMMy-Hms');

    // Format the current date and time
    return formatter.format(now);
  }

  static void showFlushBar(String msg, BuildContext context) {
    if (msg.trim().isEmpty) return;
    unawaited(_presentFlushBar(msg, context));
  }

  static Future<void> _presentFlushBar(String msg, BuildContext context) async {
    await SafeNavigator.afterUnlocked();

    final messenger = rootScaffoldMessengerKey.currentState;
    if (messenger != null) {
      messenger.clearSnackBars();
      messenger.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.info, size: 18, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text(msg)),
            ],
          ),
          backgroundColor: GlobalColors.primaryColor,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          duration: const Duration(seconds: 5),
        ),
      );
      return;
    }

    await _showFlushbarFallback(msg, context);
  }

  static Future<void> _dismissFlushbarSafely() async {
    final previous = _currentFlushbar;
    if (previous == null) return;
    if (!previous.isShowing()) {
      _currentFlushbar = null;
      return;
    }
    try {
      await previous.dismiss();
    } catch (e, st) {
      debugPrint('Flushbar dismiss skipped: $e\n$st');
    } finally {
      if (_currentFlushbar == previous) {
        _currentFlushbar = null;
      }
    }
  }

  static Future<void> _showFlushbarFallback(
    String msg,
    BuildContext context,
  ) async {
    if (_flushbarShowScheduled) return;
    _flushbarShowScheduled = true;
    try {
      await SafeNavigator.afterUnlocked();
      if (!context.mounted) return;

      await _dismissFlushbarSafely();

      final flushbar = Flushbar(
        backgroundColor: GlobalColors.primaryColor,
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: msg,
        duration: const Duration(seconds: 5),
        flushbarPosition: FlushbarPosition.BOTTOM,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(Icons.info, size: 18, color: Colors.white),
      );

      _currentFlushbar = flushbar;
      try {
        await flushbar.show(context);
      } catch (e, st) {
        debugPrint('Flushbar show failed: $e\n$st');
      } finally {
        if (_currentFlushbar == flushbar) {
          _currentFlushbar = null;
        }
      }
    } finally {
      _flushbarShowScheduled = false;
    }
  }

  static Future<void> handleUnauthorized(
    BuildContext context, {
    String message = 'Your session has been expired',
  }) async {
    await SessionController().clearUserData();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

  //  await PosOfflineDatabase.instance.deleteAllLocalTransactions();
   // await PosOfflineDatabase.instance.clearAll();

    if (!context.mounted) return;

    await SafeNavigator.pushNamedAndRemoveUntilSafe(
      context,
      RoutesName.loginScreen,
      (route) => false,
    );

    if (message.trim().isNotEmpty && context.mounted) {
      AppUtils.showFlushBar(message, context);
    }
  }
}
