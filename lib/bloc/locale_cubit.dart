import 'package:easy_localization/easy_localization.dart';
import 'package:flovix_kitchen/main.dart';
import 'package:flovix_kitchen/services/session_manager/session_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(_getInitialLocale()) {
    // Initialize with saved locale preference asynchronously
    _initializeLocale();
  }

  /// Get initial locale synchronously from global variable (set in main.dart)
  static Locale _getInitialLocale() {
    // Use the global isEnglish variable that was set in main.dart
    return isEnglish ? const Locale('en') : const Locale('ar');
  }

  /// Initialize locale from saved preference (async update if needed)
  Future<void> _initializeLocale() async {
    try {
      final isEnglishLocale = await SessionController().getLocale();
      if (isEnglishLocale != null) {
        final savedLocale = isEnglishLocale ? const Locale('en') : const Locale('ar');
        // Always update to ensure EasyLocalization is synced
        isEnglish = isEnglishLocale;
        emit(savedLocale);
        
      } else {
        // No saved preference, use default (English)
        // Ensure we emit the default locale to sync EasyLocalization
        final defaultLocale = const Locale('en');
        isEnglish = true;
        emit(defaultLocale);
        
      }
    } catch (e) {
      // On error, emit default locale to ensure consistency
      final defaultLocale = const Locale('en');
      isEnglish = true;
      emit(defaultLocale);
    }
  }

  // Update the locale
  Future<void> updateLocale(String languageCode, BuildContext? context) async {
    try {
      final newLocale = languageCode == 'en' 
          ? const Locale('en') 
          : const Locale('ar');
      
      // 1. Save to storage first
      await SessionController().setLocale(languageCode == 'en');
      isEnglish = languageCode == 'en';
      
      // 2. Update EasyLocalization immediately if context is available
      if (context != null && context.mounted) {
        await context.setLocale(newLocale);
      }
      
      // 3. Emit new state to trigger BlocBuilder rebuild
      emit(newLocale);
      
      
    } catch (e) {
      // Re-emit current state on error to maintain consistency
      emit(state);
    }
    SessionController().getLocale();
  }
}
