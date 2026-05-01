import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:ui' as ui;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:thrawa_app/controllers/expenses/expenses_controller.dart';
import 'package:thrawa_app/models/expense_model.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:thrawa_app/widgets/count_up_text.dart';

class ExpenseDetailsScreen extends GetView<ExpensesController> {
  final String expenseId;

  const ExpenseDetailsScreen({super.key, required this.expenseId});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final expense = controller.expenses.firstWhereOrNull(
        (e) => e.id == expenseId,
      );

      if (expense == null) {
        return const Scaffold(
          body: Center(child: Text('لم يتم العثور على المصروف')),
        );
      }

      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(expense),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildReceiptCard(expense),
                      SizedBox(height: 24.h),
                      _buildDetailsGrid(expense),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSliverAppBar(ExpenseModel expense) {
    return SliverAppBar(
      expandedHeight: 180.h,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFFEF4444),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(bottom: 16.h),
        title: Text(
          expense.title,
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFFEF4444), const Color(0xFFB91C1C)],
                ),
              ),
            ),
            Positioned(
              right: -30,
              top: -20,
              child: Icon(
                expense.icon,
                size: 150.sp,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptCard(ExpenseModel expense) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: const Color(0xFFFEE2E2), width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              expense.icon,
              size: 40.sp,
              color: const Color(0xFFEF4444),
            ),
          ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
          SizedBox(height: 16.h),
          Text(
            'قيمة المصروف',
            style: GoogleFonts.cairo(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CountUpText(
                value: expense.amount,
                decimalPlaces: 2,
                prefix: '- ',
                style: GoogleFonts.cairo(
                  color: const Color(0xFFEF4444),
                  fontSize: 38.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.h, right: 6.w),
                child: Text(
                  'ر.س',
                  style: GoogleFonts.cairo(
                    color: const Color(0xFFEF4444),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 200.ms).moveY(begin: 10, end: 0),

          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 16.sp,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 8.w),
                Text(
                  intl.DateFormat(
                    'dd MMMM yyyy ، hh:mm a',
                    'ar',
                  ).format(expense.date),
                  style: GoogleFonts.cairo(
                    color: AppColors.textSecondary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildDetailsGrid(ExpenseModel expense) {
    return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildGridItem(
                    'التصنيف',
                    expense.classification,
                    Icons.category_rounded,
                    Colors.orange,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildGridItem(
                    'الفئة',
                    expense.category,
                    Icons.sell_rounded,
                    Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 500.ms)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildGridItem(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    color: AppColors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.cairo(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
