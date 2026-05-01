import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class BalanceCard extends StatelessWidget {
  final double income;
  final double expense;
  final double debt;
  late final double total;

  BalanceCard({
    super.key,
    required this.income,
    required this.expense,
    required this.debt,
  }) {
    total = income + expense + debt;
  }

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
            children: [
              Expanded(
                child: Text(
                  'balance_summary'.tr(),
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              // Icon(Icons.more_horiz, color: AppColors.textHint, size: 20.w),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar(Colors.green, income / total, 'income'.tr()),
              SizedBox(width: 20.w),
              _buildBar(Colors.blue, expense / total, 'expense'.tr()),
              SizedBox(width: 20.w),
              _buildBar(Colors.orange, debt / total, 'debt'.tr()),
            ],
          ),
          SizedBox(height: 12.h),
          Column(
            children: [
              _buildIndicator(Colors.green, 'income'.tr()),
              // SizedBox(width: 10.w),
              _buildIndicator(Colors.blue, 'expense'.tr()),
              // SizedBox(width: 10.w),
              _buildIndicator(Colors.orange, 'debt'.tr()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(Color color, double heightFactor, String label) {
    return Column(
      children: [
        Container(
          width: 25.w,
          height: 120.h * heightFactor,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 13.sp,
            color: AppColors.darkBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
