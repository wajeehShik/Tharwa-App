import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:thrawa_app/utils/routes/app_routes.dart';
import 'package:thrawa_app/controllers/main/main_controller.dart';
import 'package:thrawa_app/widgets/count_up_text.dart';

class HomeScreen extends StatelessWidget {
  final bool showScaffold;
  const HomeScreen({super.key, this.showScaffold = true});

  @override
  Widget build(BuildContext context) {
    final content = Directionality(
      textDirection: ui.TextDirection.rtl,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                Widget? child;
                switch (index) {
                  case 0:
                    child = _buildUserLevelCard();
                    break;
                  case 1:
                    child = SizedBox(height: 20.h);
                    break;
                  case 2:
                    child = _buildMainBalanceCard(context);
                    break;
                  case 3:
                    child = const SizedBox(height: 25);
                    break;
                  case 5:
                    child = _buildDashboardItem(
                      title: "الادخار",
                      amount: 12000,
                      amountColor: Colors.green[700],
                      icon: Icons.savings_outlined,
                      iconColor: const Color(0xFF4CAF50),
                      bgColor: const Color(0xFFE8F5E9),
                    );
                    break;
                  case 7:
                    child = _buildDashboardItem(
                      title: "المصروفات",
                      amount: 8400,
                      amountColor: Colors.red[700],
                      icon: Icons.account_balance_wallet_outlined,
                      iconColor: Colors.red[600]!,
                      bgColor: const Color(0xFFFFEBEE),
                    );
                    break;
                  case 9:
                    child = _buildDashboardItem(
                      title: "الديون",
                      amount: 2500,
                      amountColor: Colors.orange[800],
                      icon: Icons.account_balance_outlined,
                      iconColor: Colors.orange[800]!,
                      bgColor: const Color(0xFFFFF3E0),
                    );
                    break;
                  case 10:
                    child = buildSmartInsightCard();
                    break;
                  default:
                    child = const SizedBox(height: 15);
                    if (index % 2 == 0 && index > 3 && index < 10) {
                      child = const SizedBox(height: 0);
                    }
                }

                return child
                    .animate(key: ValueKey("anim_$index"))
                    .fadeIn(duration: 600.ms, delay: (index * 100).ms)
                    .slideY(
                      begin: 0.1,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOutQuart,
                    );
              }, childCount: 11),
            ),
          ),
        ],
      ),
    );

    if (!showScaffold) return content;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: content,
      bottomNavigationBar: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: _buildBottomNavBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.find<MainController>().changeIndex(2),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.bar_chart_rounded, color: Colors.white),
      ),
    );
  }

  Widget buildSmartInsightCard({
    String title = "رؤية ذكية",
    String description =
        "أداء رائع في الادخار هذا الشهر! استمر في هذا المسار لتحقيق هدفك القادم. لقد وفرت 15% أكثر من الشهر الماضي.",
    IconData icon = Icons.auto_awesome,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F9F6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD1EBE1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF109D59),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF3F6656),
              fontSize: 14,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.dashboard, 'dashboard'.tr(), true),
          _buildNavItem(
            Icons.account_balance_wallet_outlined,
            'savings'.tr(),
            false,
          ),
          _buildNavItem(
            Icons.pie_chart_outline,
            'expenses'.tr(),
            false,
            onTap: () => Get.toNamed(AppRoutes.expenses),
          ),
          _buildNavItem(Icons.list_alt, 'debts'.tr(), false),
        ],
      ),
    );
  }

  Widget _buildUserLevelCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF81C784).withOpacity(0.5)),
      ),
      child: Row(
        children: const [
          Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF2E7D32)),
          SizedBox(width: 8),
          Text(
            "مستوى المالي : محترف مالي",
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ).animate().shimmer(
        delay: const Duration(seconds: 1),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildMainBalanceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "الرصيد الحالي",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CountUpText(
                value: 45670,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "ريال",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem({
    required String title,
    required double amount,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    Color? amountColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const Spacer(),
          Row(
            children: [
              CountUpText(
                value: amount,
                style: TextStyle(
                  color: amountColor ?? Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "ريال",
                style: TextStyle(
                  color: amountColor ?? Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.textHint,
            size: 24.w,
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
    );
  }
}
