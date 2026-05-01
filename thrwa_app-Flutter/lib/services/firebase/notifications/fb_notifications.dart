// import 'dart:convert';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_navigation/get_navigation.dart';
// // import 'package:merchant_app/get/setting_getx_controller.dart';
// // import 'package:merchant_app/view/base/custom_elevated_button.dart';
// // import 'package:merchant_app/view/screens/purchase_requisition_management/order_details.dart';

// // import '../../utils/styles.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// //************************** */

// // Future<void> _showNotificationWithSound(RemoteMessage message) async {
// //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
// //   AndroidNotificationDetails(
// //     'FLUTTER_NOTIFICATION_CLICK', // Replace with your channel ID
// //     'FLUTTER_NOTIFICATION_CLICK', // Replace with your channel name
// //     channelDescription:'FLUTTER_NOTIFICATION_CLICK', // Replace with your channel description
// //     importance: Importance.max,
// //     priority: Priority.high,
// //     sound: RawResourceAndroidNotificationSound('your_sound_file'), // Specify the sound
// //   );
// //   const NotificationDetails platformChannelSpecifics =NotificationDetails(android: androidPlatformChannelSpecifics);
// //
// //   await flutterLocalNotificationsPlugin.show(
// //     0,
// //     message.notification!.title,
// //     message.notification!.body,
// //     platformChannelSpecifics,
// //     payload: message.data.toString(),
// //   );
// // }

// typedef BackgroundMessageHandler = Future<void> Function(RemoteMessage message);
// Future<void> firebaseMessagingBackgroundHandler(
//   RemoteMessage remoteMessage,
// ) async {
//   //BACKGROUND Notifications - iOS & Android
//   await Firebase.initializeApp();
//   print('Message: ${remoteMessage.messageId}');
//   // manageNotificationAction();
// }

// // Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //     await Firebase.initializeApp();
// //   await _showNotificationWithSound(message);
// // }

// late AndroidNotificationChannel channel;
// late FlutterLocalNotificationsPlugin localNotificationsPlugin;

// mixin FbNotifications {
//   SettingGetXController _settingGetXController = Get.put<SettingGetXController>(
//     SettingGetXController(),
//   );

//   /// CALLED IN main function between ensureInitialized <-> runApp(widget);
//   static Future<void> initNotifications() async {
//     //Connect the previous created function with onBackgroundMessage to enable
//     //receiving notification when app in Background.
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//     //Channel
//     if (!kIsWeb) {
//       channel = const AndroidNotificationChannel(
//         'FLUTTER_NOTIFICATION_CLICK',
//         'FLUTTER_NOTIFICATION_CLICK',
//         description:
//             'This channel will receive notifications specific to news-app',
//         importance: Importance.high,
//         enableLights: true,
//         enableVibration: true,
//         ledColor: Colors.orange,
//         showBadge: true,
//         playSound: true,
//       );
//       print("channel");
//     }
//     //Flutter Local Notifications Plugin (FOREGROUND) - ANDROID CHANNEL

//     // localNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     // await localNotificationsPlugin
//     //     .resolvePlatformSpecificImplementation<
//     //         AndroidFlutterLocalNotificationsPlugin>()
//     //     ?.createNotificationChannel(channel);

//     //iOS Notification Setup (FOREGROUND)
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//     print("ForgroundControlNotificationNavigation");
//     // _controlNotificationNavigation(message.data);
//   }

//   //iOS Notification Permission
//   Future<void> requestNotificationPermissions() async {
//     print('requestNotificationPermissions');
//     NotificationSettings notificationSettings = await FirebaseMessaging.instance
//         .requestPermission(
//           alert: true,
//           badge: true,
//           sound: true,
//           carPlay: false,
//           announcement: false,
//           provisional: false,
//           criticalAlert: false,
//         );
//     if (notificationSettings.authorizationStatus ==
//         AuthorizationStatus.authorized) {
//       print('GRANT PERMISSION');
//     } else if (notificationSettings.authorizationStatus ==
//         AuthorizationStatus.denied) {
//       print('Permission Denied');
//     }
//   }

//   //ANDROID
//   //GENERAL (Android & iOS)
//   void initializeForegroundNotificationForAndroid({
//     required BuildContext context,
//   }) {
//     print("initializeForegroundNotificationForAndroid");
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // print('Message Received: ${message.messageId}');
//       // RemoteNotification? notification = message.notification;
//       // AndroidNotification? androidNotification = notification?.android;
//       // if (notification != null && androidNotification != null) {
//       //   localNotificationsPlugin.show(
//       //     notification.hashCode,
//       //     notification.title,
//       //     notification.body,
//       //     NotificationDetails(
//       //       android: AndroidNotificationDetails(
//       //         channel.id,
//       //         channel.name,
//       //         channelDescription: channel.description,
//       //         icon: 'launch_background',
//       //       ),
//       //     ),
//       //   );
//       // }
//       print("ForgroundControlNotificationNavigation");
//       // _controlNotificationNavigation(message.data);
//       // AwesomeDialog(
//       //   context: context,
//       //   dialogType: DialogType.success,
//       //   animType: AnimType.rightSlide,
//       //   title: 'خدمة غير مفعلة',
//       //   body: Text("يرجي تفعيل موقعك الحالي (GPS)"),
//       //   //       desc: '',
//       //   //       btnCancelOnPress: () {},
//       //   // btnOkOnPress: () {},
//       // )..show();
//       print("---------------FirebaseMessaging.onMessage------------");
//       print(message.messageId);
//       print(message.messageType);
//       print(message.category);
//       print(message.contentAvailable);
//       print(message.contentAvailable);
//       print(message.notification!.title);
//       print(message.notification!.body);
//       print(message.contentAvailable);
//       print("-------------before: Get.bottomSheet --------------");
//       Get.bottomSheet(getBottom(message));
//       print("-------------After: Get.bottomSheet --------------");

//       // getBottom(message);
//       // Get.snackbar("اشعار", "${message.messageId}يوجد اشعار لديك رقم",duration:Duration(seconds: 5));
//     });
//   }

//   void manageNotificationAction() {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       _controlNotificationNavigation(message.data);
//     });
//   }

//   Future<void> _controlNotificationNavigation(Map<String, dynamic> data) async {
//     print('Data: $data');
//     if (data['type'] != null) {
//       print(data['type'] is String);
//       // print(data['type'] is int);

//       // if(data['type'] is String){print("object")}
//       // if(data['type']==""){}
//       switch (data['type']) {
//         case "order":
//           int orderId = int.parse(data['ref_id'].toString());
//           Get.to(() => OrderDetails(orderId: orderId));
//           await _settingGetXController.readNotification();
//           // print('Product Id: $productId');
//           break;
//         case 'settings':
//           print('Navigate to settings');
//           break;
//         case 'profile':
//           print('Navigate to Profile');
//           break;
//       }
//     }
//   }

//   Widget getBottom(RemoteMessage message) {
//     return Container(
//       // constraints: BoxConstraints(
//       //   minHeight: 0.0,
//       //   maxHeight: 100,
//       // ),
//       padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24.r),
//           topRight: Radius.circular(24.r),
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Wrap(
//           // mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Icon(Icons.account_circle, size: 60.r),
//                 SizedBox(width: 8.w),
//                 Expanded(
//                   child: Text(
//                     "${message.notification!.title} :" ?? "طلبية",
//                     style: tajawalBold.copyWith(
//                       fontSize: 12,
//                       overflow: TextOverflow.fade,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8.w),
//                 Expanded(
//                   flex: 2,
//                   child: Text(
//                     message.notification!.body ?? "طلبية",
//                     style: tajawalRegular.copyWith(
//                       fontSize: 12,
//                       overflow: TextOverflow.fade,
//                     ),
//                   ),
//                 ),
//                 // Spacer(),
//                 SizedBox(width: 10.w),
//                 InkWell(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Icon(Icons.close, size: 25.sp),
//                 ),
//               ],
//             ),
//             SizedBox(height: 45.h),
//             // Text(message.notification!.title??"الطلبية", style: tajawalBold.copyWith(
//             //   fontSize: 12.sp ,
//             // ),),
//             // Text(message.notification!.body??"تفاصيل الطلبية", style: tajawalBold.copyWith(
//             //   fontSize: 12.sp ,
//             // ),),
//             CustomElevatedButton(
//               text: 'تفاصيل الطلبية',
//               onPressed: () async {
//                 _controlNotificationNavigation(message.data);
//               },
//               width: 150.w,
//               height: 40.h,
//             ),
//             SizedBox(height: 20.h),
//           ],
//           alignment: WrapAlignment.center,
//         ),
//       ),
//     );
//   }
// }
