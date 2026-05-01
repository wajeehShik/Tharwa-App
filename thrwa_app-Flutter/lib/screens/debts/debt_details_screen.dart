import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/controllers/debts/debts_controller.dart';
import 'package:thrawa_app/models/debt_model.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:ui' as ui;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:thrawa_app/widgets/count_up_text.dart';

class DebtDetailsScreen extends GetView<DebtsController> {
  final String debtId;
  const DebtDetailsScreen({super.key, required this.debtId});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final debt = controller.debts.firstWhereOrNull((d) => d.id == debtId);
      if (debt == null)
        return const Scaffold(
          body: Center(child: Text('لم يتم العثور على الدين')),
        );

      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(debt),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryCard(debt),
                      SizedBox(height: 24.h),
                      _buildDetailsGrid(debt),
                      SizedBox(height: 30.h),
                      Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'سجل السداد',
                                style: GoogleFonts.cairo(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  '${debt.installments.length} دفعات',
                                  style: GoogleFonts.cairo(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          )
                          .animate()
                          .fadeIn(delay: 400.ms)
                          .slideX(begin: 0.1, end: 0),
                      SizedBox(height: 16.h),
                      _buildInstallmentsTimeline(debt),
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

  Widget _buildSliverAppBar(DebtModel debt) {
    return SliverAppBar(
      expandedHeight: 180.h,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(bottom: 16.h),
        title: Text(
          debt.title,
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
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            Positioned(
              right: -30,
              top: -20,
              child: Icon(
                debt.icon,
                size: 150.sp,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(DebtModel debt) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'المبلغ المتبقي',
                    style: GoogleFonts.cairo(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CountUpText(
                        value: debt.remainingAmount,
                        style: GoogleFonts.cairo(
                          color: AppColors.textPrimary,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h, right: 6.w),
                        child: Text(
                          'ر.س',
                          style: GoogleFonts.cairo(
                            color: AppColors.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 70.w,
                height: 70.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    '${(debt.progress * 100).toInt()}%',
                    style: GoogleFonts.cairo(
                      color: AppColors.primary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: debt.progress,
              backgroundColor: const Color(0xFFF1F5F9),
              color: AppColors.primary,
              minHeight: 10.h,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0 ر.س',
                style: GoogleFonts.cairo(
                  color: AppColors.textHint,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                '${debt.totalAmount.toInt()} ر.س',
                style: GoogleFonts.cairo(
                  color: AppColors.textHint,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildDetailsGrid(DebtModel debt) {
    return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildGridItem(
                    'جهة الدين',
                    debt.creditor,
                    Icons.business_rounded,
                    Colors.orange,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildGridItem(
                    'القسط',
                    '${debt.monthlyInstallment?.toInt() ?? 0} ر.س',
                    Icons.payments_rounded,
                    Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _buildGridItem(
                    'تاريخ الاستحقاق',
                    intl.DateFormat('dd MMMM yyyy', 'ar').format(debt.dueDate),
                    Icons.calendar_month_rounded,
                    Colors.purple,
                    fullWidth: true,
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
    Color color, {
    bool fullWidth = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
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

  Widget _buildInstallmentsTimeline(DebtModel debt) {
    if (debt.installments.isEmpty) {
      return Container(
        height: 150.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_rounded, size: 40.sp, color: AppColors.textHint),
            SizedBox(height: 12.h),
            Text(
              'لا يوجد سجل سداد حتى الآن',
              style: GoogleFonts.cairo(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 500.ms);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: debt.installments.length,
      itemBuilder: (context, index) {
        final installment = debt.installments[index];
        final isLast = index == debt.installments.length - 1;

        return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2.w,
                            color: AppColors.primary.withOpacity(0.2),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  intl.DateFormat(
                                    'dd MMMM yyyy',
                                    'ar',
                                  ).format(installment.date),
                                  style: GoogleFonts.cairo(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                if (installment.notes != null &&
                                    installment.notes!.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Text(
                                      installment.notes!,
                                      style: GoogleFonts.cairo(
                                        fontSize: 12.sp,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '+${installment.amount.toInt()} ر.س',
                              style: GoogleFonts.cairo(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF16A34A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(delay: (600 + (index * 100)).ms)
            .slideX(begin: 0.1, end: 0);
      },
    );
  }
}
