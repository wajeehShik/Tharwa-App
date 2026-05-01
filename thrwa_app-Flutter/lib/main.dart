import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thrawa_app/controllers/auth/auth_binding.dart';
import 'package:thrawa_app/utils/routes/app_pages.dart';
import 'package:thrawa_app/utils/routes/app_routes.dart';
import 'package:thrawa_app/utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  try {
    await Firebase.initializeApp();
    // تفعيل App Check باستخدام خيار الـ Debug
    // await FirebaseAppCheck.instance.activate(
    //   // ignore: deprecated_member_use
    //   androidProvider: AndroidProvider.debug, // هذا السطر هو السر!
    // );
  } catch (e) {
    // Firebase initialization failed.
  }

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  // try {
  //   await Future.delayed(const Duration(seconds: 2));
  //   String? debugToken = await FirebaseAppCheck.instance.getToken();
  //   print("!!!!!!!!!! COPY THIS TOKEN: $debugToken !!!!!!!!!!");
  // } catch (e) {
  //   print('Check Logcat for the Debug Secret if not shown here.');
  // }
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'ثروة',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: AppRoutes.home,
          getPages: AppPages.pages,
          initialBinding: AuthBinding(),
        );
      },
    );
  }
}
