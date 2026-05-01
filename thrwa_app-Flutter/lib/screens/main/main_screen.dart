import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import 'package:thrawa_app/controllers/main/main_controller.dart';
import 'package:thrawa_app/controllers/home/home_controller.dart';
import 'package:thrawa_app/screens/home/home_screen.dart';
import 'package:thrawa_app/screens/expenses/expenses_screen.dart';
import 'package:thrawa_app/screens/savings/savings_screen.dart';
import 'package:thrawa_app/screens/debts/debts_screen.dart';
import 'package:thrawa_app/screens/statistics/statistics_screen.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:thrawa_app/screens/home/widgets/home_header.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    final homeController = Get.find<HomeController>();

    final List<Widget> pages = [
      const HomeScreen(showScaffold: false),
      const SavingsScreen(showScaffold: false),
      const StatisticsScreen(showScaffold: false),
      const ExpensesScreen(showScaffold: false),
      const DebtsScreen(showScaffold: false),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200.h,
                pinned: true,
                backgroundColor: const Color(0xFFF8FAFC),
                elevation: 0,
                // Using Obx for the title and greeting to update dynamically
                title: Obx(
                  () => HomeHeader(userName: homeController.userName.value),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.only(top: 120.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'appname'.tr(),
                              style: GoogleFonts.cairo(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Image.asset(
                              'assets/images/logo.png',
                              height: 40.h,
                              errorBuilder:
                                  (context, error, stackTrace) => Icon(
                                    Icons.eco,
                                    color: AppColors.primary,
                                    size: 40.h,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Obx(
                          () => Text(
                            'home_greeting'.tr(
                              args: [homeController.userName.value],
                            ),
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Text(
                          'smart_financial_assistant'.tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Obx(() => pages[controller.selectedIndex.value]),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          height: 90.h,
          decoration: BoxDecoration(
            color: Colors.white, // Light navbar as requested
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                Icons.home_outlined,
                'dashboard'.tr(),
                controller.selectedIndex.value == 0,
                () => controller.changeIndex(0),
              ),
              _buildNavItem(
                Icons.account_balance_wallet_outlined,
                'savings'.tr(),
                controller.selectedIndex.value == 1,
                () => controller.changeIndex(1),
              ),
              _buildMiddleNavItem(
                Icons.bar_chart_rounded,
                controller.selectedIndex.value == 2,
                () => controller.changeIndex(2),
              ),
              _buildNavItem(
                Icons.pie_chart_outline,
                'expenses'.tr(),
                controller.selectedIndex.value == 3,
                () => controller.changeIndex(3),
              ),
              _buildNavItem(
                Icons.list_alt,
                'debts'.tr(),
                controller.selectedIndex.value == 4,
                () => controller.changeIndex(4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiddleNavItem(IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color:
              isActive ? AppColors.primary : AppColors.primary.withOpacity(0.1),
          shape: BoxShape.circle,
          boxShadow:
              isActive
                  ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ]
                  : [],
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : AppColors.primary,
          size: 32.w,
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primary : AppColors.textHint,
              size: 26.w,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 10.sp,
                color: isActive ? AppColors.primary : AppColors.textHint,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceholderView extends StatelessWidget {
  final String title;
  const PlaceholderView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 64.sp, color: AppColors.textHint),
          SizedBox(height: 16.h),
          Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: 24.sp,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            "قريباً...",
            style: GoogleFonts.cairo(
              fontSize: 16.sp,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}
