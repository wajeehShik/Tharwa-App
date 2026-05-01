import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui' as ui;
import 'package:thrawa_app/controllers/expenses/expenses_controller.dart';
import 'package:thrawa_app/models/expense_model.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:thrawa_app/widgets/count_up_text.dart';
import 'add_expense_screen.dart';
import 'expense_details_screen.dart';

class ExpensesScreen extends StatelessWidget {
  final bool showScaffold;
  const ExpensesScreen({super.key, this.showScaffold = true});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExpensesController());

    final content = Directionality(
      textDirection: ui.TextDirection.rtl,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildInsightCard()
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Container(
              margin: EdgeInsets.only(top: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                        'قائمة المصروفات',
                        style: GoogleFonts.cairo(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 300))
                      .slideX(begin: 0.1, end: 0),

                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.expenses.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10.h),
                        itemBuilder: (context, index) {
                          final expense = controller.expenses[index];
                          return _buildExpenseItem(expense, index, controller);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    final fab = FloatingActionButton.extended(
      onPressed: () {
        controller.clearForm();
        Get.to(() => const AddExpenseScreen());
      },
      backgroundColor: AppColors.primary,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      icon: Icon(Icons.add_rounded, size: 28.sp, color: Colors.white),
      label: Text(
        'إضافة مصروف جديد',
        style: GoogleFonts.cairo(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ).animate().scale(
      delay: const Duration(milliseconds: 800),
      duration: const Duration(milliseconds: 400),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'سجل المصروفات',
          style: GoogleFonts.cairo(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Get.back(),
        ),
      ),
      body: content,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: fab,
    );
  }

  Widget _buildInsightCard() {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/safe_icon.png',
                    height: 40.h,
                    errorBuilder:
                        (c, e, s) =>
                            const Icon(Icons.auto_awesome, color: Colors.green),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مبروك يا أحمد!',
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'لقد صرفت أقل من الشهر الماضي بمقدار ',
                                style: GoogleFonts.cairo(
                                  fontSize: 14.sp,
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            CountUpText(
                              value: 215,
                              decimalPlaces: 0,
                              style: GoogleFonts.cairo(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                              prefix: ' \$',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCategoryTag('الاحتياجات', Colors.green),
                  SizedBox(width: 20.w),
                  _buildCategoryTag('الكماليات', Colors.orange),
                ],
              ),
            ],
          ),
          Positioned(
            left: -10,
            top: -10,
            child: Icon(
              Icons.star,
              color: Colors.amber.withOpacity(0.3),
              size: 30.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTag(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: GoogleFonts.cairo(fontSize: 12.sp, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildExpenseItem(
    ExpenseModel expense,
    int index,
    ExpensesController controller,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Get.to(() => ExpenseDetailsScreen(expenseId: expense.id)),
      child: Container(
            margin: EdgeInsets.only(bottom: 15.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(color: Colors.black.withOpacity(0.05)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1FDF6),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Icon(
                        expense.icon,
                        color: const Color(0xFF109D59),
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                expense.title,
                                style: GoogleFonts.cairo(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Spacer(),
                              CountUpText(
                                value: expense.amount,
                                decimalPlaces: 2,
                                style: GoogleFonts.cairo(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFEF4444),
                                ),
                                prefix: '- ',
                                suffix: ' ريال',
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Text(
                                '${expense.classification} - ${expense.category}',
                                style: GoogleFonts.cairo(
                                  fontSize: 12.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  DateFormat(
                                    'd MMM',
                                    'ar',
                                  ).format(expense.date),
                                  style: GoogleFonts.cairo(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: 12.h),
                const Divider(height: 1),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Edit Action
                    IconButton(
                      onPressed: () {
                        controller.prepareEdit(expense);
                        Get.to(() => const AddExpenseScreen());
                      },
                      icon: Icon(
                        Icons.edit_note_rounded,
                        color: const Color(0xFF64748B),
                        size: 24.sp,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    SizedBox(width: 16.w),
                    // Delete Action
                    IconButton(
                      onPressed:
                          () => _showDeleteConfirmation(expense, controller),
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: const Color(0xFFEF4444),
                        size: 22.sp,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          )
          .animate()
          .fadeIn(delay: Duration(milliseconds: 400 + index * 100))
          .slideX(begin: 0.1, end: 0),
    );
  }

  void _showDeleteConfirmation(
    ExpenseModel expense,
    ExpensesController controller,
  ) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_sweep_rounded,
                    color: Colors.red,
                    size: 40.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'حذف المصروف',
                  style: GoogleFonts.cairo(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // As requested
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'هل أنت متأكد من رغبتك في حذف المصروف "${expense.title}"؟ لا يمكن التراجع عن هذه العملية.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'إلغاء',
                          style: GoogleFonts.cairo(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          controller.deleteExpense(expense.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text(
                          'حذف',
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
