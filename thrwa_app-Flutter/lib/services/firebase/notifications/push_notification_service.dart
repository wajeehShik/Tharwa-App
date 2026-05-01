// import 'dart:ui';
//
// import 'package:eta/controller/notification_controller.dart';
// import 'package:eta/model/notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
//
// import '../controller/home_page_controller.dart';
//
// class PushNotificationService {
//   HomePageController homePageController = Get.put(HomePageController());
//   NotificationController notify = Get.put(NotificationController());
//   DataNotification notificationsModel = DataNotification();
//
// // It is assumed that all messages contain a data field with the key 'type'
//   Future<void> setupInteractedMessage() async {
//     await Firebase.initializeApp();
//     FirebaseMessaging.instance
//         .getToken()
//         .then((value) => print("TokenDevice📲📲📲 $value"));
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       print("message::::: ${message.notification!.title}");
//
//       Get.snackbar(
//         message.notification!.title.toString(),
//         message.notification!.body.toString(),
//         backgroundColor: const Color(0xffDEE9F4),
//         duration: const Duration(seconds: 10),
//         onTap: (v) {
//           print("value:::  ${v.message}");
//         },
//         animationDuration: const Duration(microseconds: 500),
//       );
//
//       homePageController.getTasks();
//       await notify.getNotification();
//
//     });
//     enableIOSNotifications();
//     await registerNotificationListeners();
//
//   }
//
//   Future<void> registerNotificationListeners() async {
//     final AndroidNotificationChannel channel = androidNotificationChannel();
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     // const AndroidInitializationSettings androidSettings =
//     //     AndroidInitializationSettings('@drawable/ic_launcher');
//     // const IOSInitializationSettings iOSSettings = IOSInitializationSettings(
//     //   requestSoundPermission: false,
//     //   requestBadgePermission: false,
//     //   requestAlertPermission: false,
//     // );
//     // const InitializationSettings initSettings =
//     //     InitializationSettings(android: androidSettings, iOS: iOSSettings);
//     // flutterLocalNotificationsPlugin.initialize(initSettings,
//     //     onSelectNotification: (String? message) async {
//     //   // This function handles the click in the notification when the app is in foreground
//     //   // Get.toNamed(NOTIFICATIONS_ROUTE);
//     // });
// // onMessage is called when the app is in foreground and a notification is received
//     FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
//       homePageController.getTasks();
//       print("message::::: ${message!.notification!.title}");
//       Get.snackbar(
//         message.notification!.title.toString(),
//         message.notification!.body.toString(),
//         backgroundColor: const Color(0xffDEE9F4),
//         duration: const Duration(seconds: 10),
//         onTap: (v) {
//           print("value:::  ${v.message}");
//         },
//         animationDuration: const Duration(microseconds: 500),
//       );
//
//
//
//       final RemoteNotification? notification = message.notification;
//       final AndroidNotification? android = message.notification?.android;
//       // If `onMessage` is triggered with a notification, construct our own
//       // local notification to show to users using the created channel.
//
//
//       print("multiDexEnabled true  ${notification }");
//
//
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               channelDescription: channel.description,
//               icon: android.smallIcon,
//             ),
//           ),
//         );
//       }
//     });
//   }
//
//   Future<void> enableIOSNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );
//   }
//
//   AndroidNotificationChannel androidNotificationChannel() =>
//       const AndroidNotificationChannel(
//         'high_importance_channel', // id
//         'High Importance Notifications', // title
//         description:
//         'This channel is used for important notifications.', // description
//         importance: Importance.max,
//       );
// }
