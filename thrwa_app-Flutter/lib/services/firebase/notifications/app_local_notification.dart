// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:timezone/timezone.dart' as tz;
// // import 'package:timezone/data/latest.dart' as tz;

// class NotificationService {
//   NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initNotification() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> showNotification(
//       int id, String title, String body, int seconds) async {

//     // Get.snackbar(
//     //   title,
//     //   body,
//     //   backgroundColor: const Color(0xffDEE9F4),
//     //   duration: const Duration(seconds: 10),
//     //   onTap: (v) {
//     //     print("value:::  ${v.message}");
//     //   },
//     //   animationDuration: const Duration(microseconds: 500),
//     // );
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'main_channel',
//           'Main Channel',
//           channelDescription: 'Main channel notifications',
//           importance: Importance.max,
//           priority: Priority.max,
//           icon: '@mipmap/ic_launcher',
//         ),
//         iOS: DarwinNotificationDetails(
//           sound: 'default.wav',
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       ),
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,

//     );

//   }

//   Future<void> cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }
