import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flovix_kitchen/utils/app_utils.dart';
import 'package:flovix_kitchen/utils/platform/platform_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initLocalNotifications(RemoteMessage message) async {

    var androidInitializationSettings =
        const AndroidInitializationSettings("@drawable/ic_launcher_staging");
    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
    );
    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {});
  }

  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails;
    DarwinNotificationDetails darwinNotificationDetails;

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      "High Importance Channel",
      importance: Importance.max,
      enableVibration: true,
    );
    if (PlatformInfo.isAndroid) {
      // Delete the old channel if it exists
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.deleteNotificationChannel(channel.id);

      // Create a new channel with the updated sound
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
    androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: "your channel Description",

      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      //  sound: RawResourceAndroidNotificationSound(soundFile),
      // Use the sound file from the payload
      enableVibration: true,
      icon: '@drawable/ic_launcher',
    );

    darwinNotificationDetails = DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
      presentBadge: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      iOS: darwinNotificationDetails,
      android: androidNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        // message.data['title'].toString(),
        //  message.data['body'].toString(),
        notificationDetails,
      );
    });
  }

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      announcement: true,
      alert: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("user granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("user granted provision permission");
    } else {
      debugPrint("user denied permission");
    }
  }

  Future<void> firebaseInit() async {
    if (!PlatformInfo.isMobile) return;

    await requestNotificationPermission();
    if (PlatformInfo.isIOS) {
      await foregroundMessage();
    }
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        debugPrint("firebase message ${message.data}");
        debugPrint("firebase message ${message.notification?.body.toString()}");
      }
      if (PlatformInfo.isIOS) {
        // iOS already shows foreground notifications because we enabled:
        // setForegroundNotificationPresentationOptions(alert/sound/badge).
        // Showing local notifications for the same remote payload duplicates it.
        final hasRemoteNotification = message.notification != null;
        if (!hasRemoteNotification) {
          initLocalNotifications(message);
          showNotifications(message);
        }
      }
      if (PlatformInfo.isAndroid) {
        initLocalNotifications(message);
        showNotifications(message);
      }
    });
  }

  Future foregroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<String?> getToken() async {
    if (!PlatformInfo.isMobile) {
      return AppUtils.generateRandomString(10);
    }

    final token = await messaging.getToken().onError((error, stackrace) {
      return AppUtils.generateRandomString(10);
    });


    debugPrint('this is the device token $token');
    return token;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    NotificationServices().showNotifications(message);
  }
}
