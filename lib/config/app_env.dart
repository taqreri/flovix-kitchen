import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class AppEnv {
  static const String flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'production',
  );

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://posapi.flovix.online/api',
  );

  static const String webBaseUrl = String.fromEnvironment(
    'WEB_BASE_URL',
    defaultValue: 'https://app.flovix.online',
  );

  static const String assetBaseUrl = String.fromEnvironment(
    'ASSET_BASE_URL',
    defaultValue: 'https://dev.taqreri.com',
  );

  static const String firebaseAndroidApiKey = String.fromEnvironment(
    'FIREBASE_ANDROID_API_KEY',
    defaultValue: 'AIzaSyAI3avaY76o1EuCq5xlu3Tn5A7NR-SFDcI',
  );

  static const String firebaseAndroidAppId = String.fromEnvironment(
    'FIREBASE_ANDROID_APP_ID',
    defaultValue: '1:828657372193:android:f450565febbe6762462760',
  );

  static const String firebaseMessagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
    defaultValue: '828657372193',
  );

  static const String firebaseProjectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
    defaultValue: 'flovix-kitchen',
  );

  static FirebaseOptions get androidFirebaseOptions => const FirebaseOptions(
        apiKey: firebaseAndroidApiKey,
        appId: firebaseAndroidAppId,
        messagingSenderId: firebaseMessagingSenderId,
        projectId: firebaseProjectId,
      );

  static const String firebaseIosApiKey = String.fromEnvironment(
    'FIREBASE_IOS_API_KEY',
    defaultValue: 'AIzaSyDXiTcQ_w6Lq2_X47G-DazLpRIqSfCOoCE',
  );

  static const String firebaseIosAppId = String.fromEnvironment(
    'FIREBASE_IOS_APP_ID',
    defaultValue: '1:246067218024:ios:f9ac747b72184c942b1ddd',
  );

  static const String firebaseIosBundleId = String.fromEnvironment(
    'FIREBASE_IOS_BUNDLE_ID',
    defaultValue: 'com.taqreri.app',
  );

  static FirebaseOptions get iosFirebaseOptions => const FirebaseOptions(
        apiKey: firebaseIosApiKey,
        appId: firebaseIosAppId,
        messagingSenderId: firebaseMessagingSenderId,
        projectId: firebaseProjectId,
        iosBundleId: firebaseIosBundleId,
      );

  static const String firebaseWindowsAppId = String.fromEnvironment(
    'FIREBASE_WINDOWS_APP_ID',
    defaultValue: '1:246067218024:windows:3bb97f52dcabc0782b1ddd',
  );

  static FirebaseOptions get windowsFirebaseOptions => const FirebaseOptions(
        apiKey: firebaseAndroidApiKey,
        appId: firebaseWindowsAppId,
        messagingSenderId: firebaseMessagingSenderId,
        projectId: firebaseProjectId,
      );

  static Future<void> initializeFirebase() async {
    if (kIsWeb) {
      await Firebase.initializeApp();
      return;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        await Firebase.initializeApp(options: androidFirebaseOptions);
      case TargetPlatform.iOS:
        await Firebase.initializeApp(options: iosFirebaseOptions);
      case TargetPlatform.windows:
        await Firebase.initializeApp(options: windowsFirebaseOptions);
      default:
        await Firebase.initializeApp();
    }
  }
}
