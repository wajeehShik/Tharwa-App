import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:countup/countup.dart';

class FrozenFundsCard extends StatelessWidget {
  final double amount;

  const FrozenFundsCard({super.key, required this.amount});

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // أضف هذا
                child: Text(
                  'frozen_funds'.tr(),
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Icon(Icons.ac_unit, color: Colors.blue.shade300, size: 20.w),
            ],
          ),
          SizedBox(height: 12.h),

          Image.asset(
            'assets/images/safe_icon.png',
            height: 40.h,
            errorBuilder:
                (context, error, stackTrace) => Icon(
                  Icons.monetization_on,
                  size: 40.sp,
                  color: Colors.amber,
                ),
          ),
          SizedBox(height: 8.h),
          Text(
            'frozen_amount'.tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
          ),
          Countup(
            begin: 0,
            end: amount,
            duration: const Duration(seconds: 2),
            separator: ',',
            prefix: '\$',
            style: GoogleFonts.cairo(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'extra_freeze'.tr(),
                style: GoogleFonts.cairo(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
