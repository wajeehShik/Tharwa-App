import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:thrawa_app/controllers/main/main_controller.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  const HomeHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: CircleAvatar(
                radius: 20.r,
                backgroundImage: const NetworkImage(
                  'https://i.pravatar.cc/150?u=ahmad',
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'welcome_back'.tr(),
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  userName,
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            _buildIconButton(
              Icons.bar_chart_rounded,
              onTap: () => Get.find<MainController>().changeIndex(2),
            ),
            SizedBox(width: 8.w),
            _buildIconButton(Icons.notifications_outlined),
            SizedBox(width: 8.w),
            _buildIconButton(Icons.menu),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.textHint.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 24.w),
      ),
    );
  }
}
