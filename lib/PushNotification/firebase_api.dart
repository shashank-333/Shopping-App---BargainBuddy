// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
//
// import '../Provider/NotificationCount.dart';
// import '../main.dart';
// import '../views/CartPage.dart';
//
//
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print("Title : ${message.notification!.title}");
//   print("body : ${message.notification!.body}");
//   print("Payload : ${message.data}");
// }
//
//
//
// // BuildContext? ctx;
//
// class FirebaseApi {
//   final firebaseMessaging = FirebaseMessaging.instance;
//
//   final _androidChannel = const AndroidNotificationChannel(
//       "high_importance_channel", "High Importance Notification",
//       description: "This channel is used for important notification",
//       importance: Importance.defaultImportance);
//
//   final _localNotifications = FlutterLocalNotificationsPlugin();
//
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//     navigatorKey.currentState?.pushNamed(CartPage.route, arguments: message);
//   }
//
//   Future initLocalNotification() async {
//     // const ios = IOSIntializationSetting();
//     const android = AndroidInitializationSettings('@drawable/ic_launcher');
//     const settings = InitializationSettings(android: android);
//     await _localNotifications.initialize(settings,
//         onDidReceiveNotificationResponse: (payload) {
//       final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));
//       handleMessage(message);
//     });
//     final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }
//
//
//   Future initPushNotification() async {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//         alert: true, badge: true, sound: true);
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       // Provider.of<NotificationCount>(ctx!, listen: false).increment();
//       final notification = message.notification;
//       if (notification == null ) return ;
//       _localNotifications.show(notification.hashCode, notification.title, notification.body, NotificationDetails(
//         android: AndroidNotificationDetails(
//           _androidChannel.id,
//               _androidChannel.name,
//           channelDescription: _androidChannel.description,
//           icon:'@drawable/ic_launcher'
//         )
//       ),
//           payload: jsonEncode(message.toMap()),
//       );
//     });
//   }
//
//   Future<void> initNotifications() async {
//     await firebaseMessaging.requestPermission();
//     final fcmToken = await firebaseMessaging.getToken();
//     print("Token : $fcmToken");
//     initPushNotification();
//     initLocalNotification();
//   }
// }
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../Provider/NotificationCount.dart';
import '../main.dart';
import '../views/CartPage.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title : ${message.notification!.title}");
  print("body : ${message.notification!.body}");
  print("Payload : ${message.data}");
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  // Android notification channel (adjust details as needed)
  final _androidChannel = const AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notifications",
      description: "This channel is used for important notifications",
      importance: Importance.high,
      // sound: RawResourceSound('raw/notification_sound'), // Example sound resource
      enableLights: true,
      enableVibration: true,
      playSound: true);

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(CartPage.route, arguments: message);
  }

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
          final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));
          handleMessage(message);
        });
    final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotification() async {
    // Request for notification permissions (adjust for iOS if needed)
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize foreground notification presentation options
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: "@drawable/ic_launcher",
            sound: _androidChannel.sound, // Use notification channel sound here
            enableLights: _androidChannel.enableLights,
            enableVibration: _androidChannel.enableVibration,
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print("Token : $fcmToken");
    initPushNotification();
    initLocalNotification();
  }
}
