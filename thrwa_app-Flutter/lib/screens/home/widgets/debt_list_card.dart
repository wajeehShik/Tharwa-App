import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';

class DebtListCard extends StatelessWidget {
  const DebtListCard({super.key});

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
                'الديون',
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Debt List',
                style: GoogleFonts.cairo(
                  fontSize: 12.sp,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDebtItem('احتياجات', 100.0, '05.04.2023', true),
          Divider(color: AppColors.divider, height: 24.h),
          _buildDebtItem('الديون', -25.0, '10.05.2023', false),
          Divider(color: AppColors.divider, height: 24.h),
          _buildDebtItem('خطط سداد ذكية', 28.0, '12.06.2023', true),
        ],
      ),
    );
  }

  Widget _buildDebtItem(String title, double amount, String date, bool isPaid) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color:
                isPaid
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            isPaid ? Icons.check_circle_outline : Icons.error_outline,
            color: isPaid ? Colors.green : Colors.red,
            size: 20.w,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Due Date: $date',
                style: GoogleFonts.cairo(
                  fontSize: 10.sp,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${amount > 0 ? '' : ''}\$${amount.abs().toStringAsFixed(2)}',
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: amount > 0 ? AppColors.textPrimary : Colors.red,
          ),
        ),
      ],
    );
  }
}
