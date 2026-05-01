import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/controllers/debts/debts_controller.dart';
import 'package:thrawa_app/models/debt_model.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui' as ui;
import 'package:thrawa_app/widgets/count_up_text.dart';
import 'add_debt_screen.dart';
import 'debt_details_screen.dart';
import 'package:intl/intl.dart' as intl;

class DebtsScreen extends GetView<DebtsController> {
  final bool showScaffold;
  const DebtsScreen({super.key, this.showScaffold = true});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DebtsController());

    final content = Directionality(
      textDirection: ui.TextDirection.rtl,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Subtitle
            Text(
              'إدارة الديون',
              style: GoogleFonts.cairo(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),

            Text(
                  'تتبع رحلتك نحو الحرية المالية واكسب مكافآت XP',
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 100.ms)
                .slideX(begin: 0.1, end: 0),

            SizedBox(height: 20.h),

            // Summary Card
            _buildSummaryCard()
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideY(begin: 0.1, end: 0),

            SizedBox(height: 20.h),

            // Mission Card
            _buildMissionCard()
                .animate()
                .fadeIn(duration: 600.ms, delay: 300.ms)
                .slideY(begin: 0.1, end: 0),

            SizedBox(height: 16.h),

            // Warning Notification Card
            _buildWarningCard()
                .animate()
                .fadeIn(duration: 600.ms, delay: 400.ms)
                .slideY(begin: 0.1, end: 0),

            SizedBox(height: 24.h),

            Text(
              'الديون النشطة',
              style: GoogleFonts.cairo(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),

            SizedBox(height: 16.h),

            // Debts List
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.debts.length,
                itemBuilder: (context, index) {
                  return _buildDebtCard(controller.debts[index], index);
                },
              ),
            ),

            SizedBox(height: 100.h), // Bottom padding
          ],
        ),
      ),
    );

    final fab = FloatingActionButton.extended(
      onPressed: () {
        controller.resetForm();
        Get.to(() => const AddDebtScreen());
      },

      backgroundColor: AppColors.primary,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      icon: Icon(Icons.add_rounded, size: 28.sp, color: Colors.white),
      label: Text(
        'إضافة دين جديد',
        style: GoogleFonts.cairo(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ).animate().scale(
      delay: 800.ms,
      duration: 400.ms,
      curve: Curves.easeOutBack,
    );

    if (!showScaffold) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: content,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: fab,
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(child: content),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: fab,
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'إجمالي الديون المتبقية',
            style: GoogleFonts.cairo(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CountUpText(
                value: controller.totalRemaining,
                style: GoogleFonts.cairo(
                  color: AppColors.textPrimary,
                  fontSize: 34.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.h, right: 8.w),
                child: Text(
                  'ر.س',
                  style: GoogleFonts.cairo(
                    color: AppColors.primary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                'نسبة السداد الكلية',
                style: GoogleFonts.cairo(
                  color: AppColors.textSecondary,
                  fontSize: 12.sp,
                ),
              ),
              const Spacer(),
              Text(
                '${(controller.overallProgress * 100).toInt()}%',
                style: GoogleFonts.cairo(
                  color: AppColors.primary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: controller.overallProgress,
              backgroundColor: const Color(0xFFF1F5F9),
              color: AppColors.primary,
              minHeight: 12.h,
            ),
          ),
          SizedBox(height: 20.h),
          const Divider(color: Color(0xFFF1F5F9)),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem(
                'القسط القادم',
                '15 أكتوبر',
                Icons.calendar_month_outlined,
                const Color(0xFF3B82F6),
              ),
              _buildSummaryItem(
                'انخفاض الشهر',
                '-6,200 ر.س',
                Icons.trending_down,
                const Color(0xFFEF4444),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.cairo(
                  color: AppColors.textSecondary,
                  fontSize: 11.sp,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.cairo(
                  color: AppColors.textPrimary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMissionCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(
          0xFF0F172A,
        ).withOpacity(0.8), // Dark Navy Like in the Image for contrast
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  'XP Bonus',
                  style: GoogleFonts.cairo(
                    color: Colors.blue,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.bolt, color: Colors.white, size: 18.sp),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'مهمة الالتزام',
              style: GoogleFonts.cairo(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'سدد 3 أقساط متتالية في موعدها لتحصل على 500 XP إضافية!',
              style: GoogleFonts.cairo(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _buildMissionStep(true)),
              SizedBox(width: 8.w),
              Expanded(child: _buildMissionStep(false)),
              SizedBox(width: 8.w),
              Expanded(child: _buildMissionStep(false)),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'باقي دفعة واحدة للإنجاز!',
            style: GoogleFonts.cairo(
              color: Colors.blue.shade300,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionStep(bool completed) {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        color: completed ? Colors.blue : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }

  Widget _buildWarningCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: const Color(0xFFFEE2E2), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: const Color(0xFFEF4444),
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.cairo(
                      color: AppColors.textPrimary,
                      fontSize: 13.sp,
                    ),
                    children: [
                      const TextSpan(text: 'تنبيه: '),
                      TextSpan(
                        text: 'قرض البنك الراجحي ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: 'يستحق خلال '),
                      TextSpan(
                        text: '3 أيام',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEF4444),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'سدد الآن',
              style: GoogleFonts.cairo(
                color: const Color(0xFFEF4444),
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebtCard(DebtModel debt, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Get.to(() => DebtDetailsScreen(debtId: debt.id)),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: debt.isCompleted ? const Color(0xFFF0FDF4) : Colors.white,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: [
            BoxShadow(
              color:
                  debt.isCompleted
                      ? Colors.green.withOpacity(0.05)
                      : Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color:
                debt.isCompleted
                    ? Colors.green.withOpacity(0.3)
                    : const Color(0xFFF1F5F9),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 45.w,
                  height: 45.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(debt.icon, color: AppColors.primary, size: 24.sp),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        debt.title,
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        debt.subtitle,
                        style: GoogleFonts.cairo(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: debt.progress,
                backgroundColor: const Color(0xFFF1F5F9),
                color:
                    debt.isWarning
                        ? const Color(0xFFEF4444).withGreen(100)
                        : AppColors.primary,
                minHeight: 8.h,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المتبقي',
                      style: GoogleFonts.cairo(
                        color: AppColors.textHint,
                        fontSize: 11.sp,
                      ),
                    ),
                    Text(
                      '${debt.remainingAmount.toInt()} ر.س',
                      style: GoogleFonts.cairo(
                        color: AppColors.textPrimary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                if (!debt.isCompleted)
                  IconButton(
                    onPressed: () => _showAddInstallmentDialog(debt.id),
                    icon: Icon(
                      Icons.add_circle_outline_rounded,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),

                if (debt.isCompleted)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.green,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'منجز',
                          style: GoogleFonts.cairo(
                            color: Colors.green,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                // if (!debt.isCompleted) SizedBox(width: 12.w),
                if (!debt.isCompleted)
                  IconButton(
                    onPressed: () {
                      controller.prepareEdit(debt);
                      Get.to(() => const AddDebtScreen());
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.blue,
                      size: 20.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                // if (!debt.isCompleted) SizedBox(width: 12.w),
                if (!debt.isCompleted)
                  IconButton(
                    onPressed: () => controller.deleteDebt(debt.id),
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                      size: 20.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Text(
                //       'يستحق في',
                //       style: GoogleFonts.cairo(
                //         color: AppColors.textHint,
                //         fontSize: 11.sp,
                //       ),
                //     ),
                //     Text(
                //       intl.DateFormat('dd MMMM', 'ar').format(debt.dueDate),
                //       style: GoogleFonts.cairo(
                //         color:
                //             debt.isWarning
                //                 ? const Color(0xFFD32F2F)
                //                 : AppColors.textSecondary,
                //         fontSize: 14.sp,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ).animate().fadeIn(delay: (500 + index * 100).ms).slideY(begin: 0.1, end: 0),
    );
  }

  void _showAddInstallmentDialog(String debtId) {
    final amountController = TextEditingController();
    final notesController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'إضافة قسط جديد',
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'مبلغ القسط',
                    hintText: '0.00',
                    suffixText: 'ر.س',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: notesController,
                  decoration: InputDecoration(
                    labelText: 'ملاحظات (اختياري)',
                    hintText: 'مثال: سداد شهر أكتوبر',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'إلغاء',
                        style: GoogleFonts.cairo(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    ElevatedButton(
                      onPressed: () {
                        final amount = double.tryParse(amountController.text);
                        final debt = controller.debts.firstWhere(
                          (d) => d.id == debtId,
                        );

                        if (amount != null && amount > 0) {
                          if (amount > debt.remainingAmount) {
                            Get.snackbar(
                              'تنبيه',
                              'المبلغ المدخل أكبر من المتبقي (${debt.remainingAmount.toInt()} ر.س)',
                              backgroundColor: Colors.orange,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                            );
                            return;
                          }
                          Get.back(); // إغلاق نافذة الأقساط أولاً
                          controller.addInstallment(
                            debtId,
                            amount,
                            notesController.text,
                          );
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'إضافة',
                        style: GoogleFonts.cairo(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
