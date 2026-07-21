import 'dart:convert'; // Importing dart:convert for JSON encoding and decoding

import 'package:flovix_kitchen/model/pos/cart/category_model/branchinfo_model.dart';
import 'package:flovix_kitchen/model/user_model/user_model_new/User_model_new.dart';
import 'package:flovix_kitchen/storage/local_storage.dart';
import 'package:flutter/material.dart'; // Importing Flutter material library
import 'package:shared_preferences/shared_preferences.dart';
// Importing local storage for storing user data

/// A singleton class for managing user session data.
class SessionController {
  /// Instance of [LocalStorage] for accessing local storage.
  final LocalStorage sharedPreferenceClass = LocalStorage();

  /// Singleton instance of [SessionController].
  static final SessionController _session = SessionController._internal();

  /// Flag indicating whether the user is logged in or not.
  static bool? isLogin;

  /// Model representing the user data.
  static UserModelNew user = UserModelNew();

  /// Private constructor for creating the singleton instance of [SessionController].
  SessionController._internal() {
    // Initialize default values
    isLogin = false;
  }

  //In Dart, a factory constructor is a special kind of constructor that can return an instance of the class,
  // potentially a cached or pre-existing instance, instead of always creating a new one.
  // It's defined using the factory keyword.
  // This is useful for implementing patterns like singletons or when you want to control instance creat
  //
  /// Factory constructor for accessing the singleton instance of [SessionController].
  factory SessionController() {
    return _session;
  }Future<void> setLocale(bool locale ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEnglish', locale);
  }
  
  /// Retrieves the saved locale preference from local storage
  Future<bool?> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isEnglish');
  }
  Future<void> setCustomerTag(String customerTag ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('customer_tag', customerTag);
  }
  Future <String?> getCustomerTag( ) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
   String?value= prefs.getString('customer_tag',);
    // Storing value to check login
    
    return  value;

  }
  Future<void> setProductLastPage(int lastPage) async {
    await sharedPreferenceClass.setValue('product_last_page', '$lastPage');
  }

  Future<void> setCounterDiscountValue({
    required String value,
    bool? isPercentage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('counter_discount_value', value);
    await prefs.setBool('counter_discount_isPercentage', isPercentage ?? false);
  }

  Future<int> getProductLastPage() async {
    //  try {
    final raw = await sharedPreferenceClass.readValue('product_last_page');
    return int.tryParse(raw?.toString() ?? '') ?? 0;
  }
  /// Saves user data into the local storage.
  ///
  /// Takes a [user] object as input and saves it into the local storage.

  /// Retrieves user data from the local storage.
  ///
  /// Retrieves user data from the local storage and assigns it to the session controller
  /// to be used across the app.
  Future<void> getUserFromPreference() async {
    try {
      var userData = await sharedPreferenceClass.readValue('user');
      var isLogin = await sharedPreferenceClass.readValue('isLogin');
      
      final userJson = userData?.toString();
      if (userJson != null && userJson.isNotEmpty) {
        SessionController.user = UserModelNew.fromJson(jsonDecode(userJson));
      } else {
        final prefs = await SharedPreferences.getInstance();
        final legacyToken = prefs.getString('user_token');
        if (legacyToken != null && legacyToken.isNotEmpty) {
          SessionController.user = UserModelNew(token: legacyToken);
        }
      }
      SessionController.isLogin = isLogin?.toString() == 'true';
      
    } catch (e) {
      debugPrint(e.toString());
    }
  }  /// Saves user data into the local storage.
  ///

  Future<BranchInfoModel?> getBranchInformation() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('branch_Information');
    if (jsonString != null && jsonString.isNotEmpty) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return BranchInfoModel.fromJson(jsonMap);
    }
    return null; // returns null if nothing saved
  }
  /// Takes a [user] object as input and saves it into the local storage.
  Future<void> saveUserInPreference(dynamic user) async {
    await sharedPreferenceClass.setValue('user', jsonEncode(user));

    if (user is UserModelNew && user != null) {
      await sharedPreferenceClass.setValue(
        'employee_name',
        user.employeeName ?? '',
      );
      await sharedPreferenceClass.setValue(
        'branch_id',
        user.branchId?.toString() ?? '0',
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_token', user.token ?? '');
    }

    await sharedPreferenceClass.setValue('isLogin', 'true');
  }

  // ✅ ADD BRANCH NAME STORAGE METHODS
  /// Saves branch name into the local storage
  Future<void> saveBranchName(String branchName) async {
    await sharedPreferenceClass.setValue('branch_name', branchName);
    
  }

  /// Retrieves branch name from the local storage
  Future<String> getBranchName() async {
    try {
      final branchName = await sharedPreferenceClass.readValue('branch_name');
      final name = branchName?.toString();
      return name != null && name.isNotEmpty ? name : 'Select Branch';
    } catch (e) {
      debugPrint("Error reading branch name: $e");
      return 'Select Branch';
    }
  }

  // ✅ ADD STATIC GETTER FOR BRANCH NAME (for easy access)
  static Future<String> get branchName async {
    final session = SessionController();
    return await session.getBranchName();
  }

  // Existing static getters
  static int get branchId {
    return user.branchId ?? 0;
  }

  static String get employeeName {
    return user.employeeName ?? 'User';
  }

  /// Retrieves user data from the local storage.
  ///
  /// Retrieves user data from the local storage and assigns it to the session controller
  /// to be used across the app.

  // ✅ ADD HELPER METHOD TO CHECK IF USER HAS VALID DATA
  static bool get hasUserData {
    return user != null;
  }

  /// ✅ ADD THIS METHOD: Clears all user data from local storage
  Future<void> clearUserData() async {
    try {
      // Clear all stored user data
      await sharedPreferenceClass.clearValue('user');
      await sharedPreferenceClass.clearValue('isLogin');
      await sharedPreferenceClass.clearValue('employee_name');
      await sharedPreferenceClass.clearValue('branch_id');
      await sharedPreferenceClass.clearValue('branch_name');
      await sharedPreferenceClass.clearValue('product_last_page');

      // Clear SharedPreferences data
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('counter_discount_value');
      await prefs.remove('counter_discount_isPercentage');
      await prefs.remove('isEnglish');

      // Reset static variables
      isLogin = false;
      user = UserModelNew();

      
    } catch (e) {
      debugPrint('Error clearing user data: $e');
      throw e; // Re-throw to handle in the calling method
    }
  }
}
