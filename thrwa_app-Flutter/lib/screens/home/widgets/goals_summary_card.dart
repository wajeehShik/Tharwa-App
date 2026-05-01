import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:countup/countup.dart';

class GoalsSummaryCard extends StatelessWidget {
  const GoalsSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.textHint.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'goals_summary'.tr(),
                style: GoogleFonts.cairo(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.more_horiz, color: AppColors.textHint, size: 20.w),
            ],
          ),
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildGoalGauge(0.9, 'car'.tr(), Colors.green),
              _buildGoalGauge(0.7, 'vacation'.tr(), Colors.blue),
              _buildGoalGauge(0.5, 'house'.tr(), Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalGauge(double progress, String label, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 70.w,
              height: 70.w,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 6.w,
                color: color,
                backgroundColor: color.withOpacity(0.1),
                strokeCap: StrokeCap.round,
              ),
            ),
            Countup(
              begin: 0,
              end: progress * 100,
              duration: const Duration(seconds: 2),
              suffix: '%',
              style: GoogleFonts.cairo(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 15.sp,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
