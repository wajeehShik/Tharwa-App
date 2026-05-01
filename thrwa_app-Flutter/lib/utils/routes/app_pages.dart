import 'package:get/get.dart';
import 'package:thrawa_app/controllers/auth/auth_binding.dart';
import 'package:thrawa_app/controllers/onboarding/onboarding_binding.dart';
import 'package:thrawa_app/controllers/splash/splash_binding.dart';
import 'package:thrawa_app/screens/auth/login/login_screen.dart';
import 'package:thrawa_app/screens/auth/register/register_screen.dart';
import 'package:thrawa_app/screens/onboarding/onboarding_screen.dart';
import 'package:thrawa_app/screens/splash/splash_screen.dart';
import 'package:thrawa_app/screens/expenses/expenses_screen.dart';
import 'package:thrawa_app/controllers/main/main_binding.dart';
import 'package:thrawa_app/screens/main/main_screen.dart';
import 'package:thrawa_app/controllers/expenses/expenses_binding.dart';
import 'package:thrawa_app/screens/statistics/statistics_screen.dart';
import 'package:thrawa_app/controllers/statistics/statistics_binding.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.expenses,
      page: () => const ExpensesScreen(),
      binding: ExpensesBinding(),
    ),
    GetPage(
      name: AppRoutes.statistics,
      page: () => const StatisticsScreen(),
      binding: StatisticsBinding(),
    ),
  ];
}
