import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/controllers/savings/savings_controller.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui' as ui;
import 'package:thrawa_app/widgets/count_up_text.dart';
import 'add_goal_screen.dart';
import 'goal_details_screen.dart';

class SavingsScreen extends GetView<SavingsController> {
  final bool showScaffold;
  const SavingsScreen({super.key, this.showScaffold = true});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    Get.lazyPut(() => SavingsController());

    final content = Directionality(
      textDirection: ui.TextDirection.rtl,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'خزنة الأهداف',
              style: GoogleFonts.cairo(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),

            SizedBox(height: 20.h),

            // Total Savings Summary Card (Light Theme)
            _buildTotalSummaryCard()
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideY(begin: 0.1, end: 0),

            SizedBox(height: 20.h),
            Text(
              'قائمة المدخرات ',
              style: GoogleFonts.cairo(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),
            SizedBox(height: 20.h),

            // Goals List
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.goals.length,
                itemBuilder: (context, index) {
                  return _buildGoalCard(controller.goals[index], index);
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
        controller.clearForm();
        Get.to(() => const AddGoalScreen());
      },
      backgroundColor: AppColors.primary,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      icon: Icon(Icons.add_rounded, size: 28.sp, color: Colors.white),
      label: Text(
        'إضافة هدف جديد',
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: fab,
    );
  }

  Widget _buildTotalSummaryCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: const Color(0xFFD1FAE5), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'إجمالي المدخرات',
                style: GoogleFonts.cairo(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.account_balance_wallet_outlined,
                color: const Color(0xFF10B981),
                size: 20.sp,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CountUpText(
                  value: controller.totalSavings,
                  prefix: '+ ',
                  style: GoogleFonts.cairo(
                    color: const Color(0xFF10B981),
                    fontSize: 34.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h, right: 8.w),
                  child: Text(
                    'ريال',
                    style: GoogleFonts.cairo(
                      color: AppColors.textSecondary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          // Total Progress Bar
          Obx(
            () => Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LinearProgressIndicator(
                    value: controller.totalProgress,
                    backgroundColor: const Color(0xFFECFDF5),
                    color: const Color(0xFF10B981),
                    minHeight: 10.h,
                  ),
                ).animate().shimmer(
                  delay: const Duration(seconds: 1),
                  duration: const Duration(seconds: 2),
                ),
                SizedBox(height: 14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الهدف الكلي: ${controller.totalTarget.toInt()} ريال',
                      style: GoogleFonts.cairo(
                        color: AppColors.textPrimary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        '${(controller.totalProgress * 100).toInt()}%',
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(GoalModel goal, int index) {
    return GestureDetector(
          onTap: () => Get.to(() => GoalDetailsScreen(goalId: goal.id)),

          child: Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: goal.isCompleted ? const Color(0xFFF0FDF4) : Colors.white,
              borderRadius: BorderRadius.circular(22.r),
              boxShadow: [
                BoxShadow(
                  color:
                      goal.isCompleted
                          ? Colors.green.withOpacity(0.05)
                          : Colors.black.withOpacity(0.03),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color:
                    goal.isCompleted
                        ? Colors.green.withOpacity(0.3)
                        : const Color(0xFFF1F5F9),
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Icon - On the Right in RTL
                    Container(
                      width: 45.w,
                      height: 45.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        goal.icon,
                        color: Colors.blueGrey,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    // Title & Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            goal.title,
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            goal.subtitle,
                            style: GoogleFonts.cairo(
                              fontSize: 12.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Badge - On the Far Left in RTL
                    if (goal.monthlyAddition != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1FAE5),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '+ ${goal.monthlyAddition!.toInt()} ريال هذا الشهر',
                          style: GoogleFonts.cairo(
                            color: const Color(0xFF065F46),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else if (goal.isNear)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Colors.orange,
                              size: 12.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'قريباً جداً',
                              style: GoogleFonts.cairo(
                                color: const Color(0xFF92400E),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (goal.isCompleted)
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
                  ],
                ),
                SizedBox(height: 20.h),
                // Amounts
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CountUpText(
                          value: goal.savedAmount,
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'ريال',
                          style: GoogleFonts.cairo(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${goal.targetAmount.toInt()}',
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'ريال',
                          style: GoogleFonts.cairo(
                            fontSize: 12.sp,
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                // Individual Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LinearProgressIndicator(
                    value: goal.progress,
                    backgroundColor: const Color(0xFFF1F5F9),
                    color:
                        goal.isNear
                            ? const Color(0xFF10B981)
                            : const Color(0xFF10B981).withOpacity(0.7),
                    minHeight: 8.h,
                  ),
                ),
                if (!goal.isCompleted) SizedBox(height: 16.h),
                if (!goal.isCompleted)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Edit Icon
                      IconButton(
                        onPressed: () {
                          controller.prepareEdit(goal);
                          Get.to(() => const AddGoalScreen());
                        },
                        icon: Icon(
                          Icons.edit_note_rounded,
                          color: Colors.blueGrey,
                          size: 24.sp,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      SizedBox(width: 8.w),
                      // Delete Icon
                      IconButton(
                        onPressed: () => _showDeleteConfirmation(goal),
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.redAccent,
                          size: 22.sp,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      SizedBox(width: 8.w),
                      // Add Deposit Icon
                      IconButton(
                        onPressed: () => _showAddDepositDialog(goal.id),
                        icon: Icon(
                          Icons.add_circle_outline_rounded,
                          color: const Color(0xFF10B981),
                          size: 26.sp,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: (400 + index * 100).ms)
        .slideY(begin: 0.1, end: 0);
  }

  void _showAddDepositDialog(String goalId) {
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
                  'إيداع مبلغ جديد',
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF10B981),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'مبلغ الإيداع',
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
                    hintText: 'مثال: دخل إضافي',
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
                        final goal = controller.goals.firstWhere(
                          (g) => g.id == goalId,
                        );

                        if (amount != null && amount > 0) {
                          if (amount > (goal.targetAmount - goal.savedAmount)) {
                            Get.snackbar(
                              'تنبيه',
                              'المبلغ المودع يتجاوز المتبقي للهدف (${(goal.targetAmount - goal.savedAmount).toInt()} ر.س)',
                              backgroundColor: Colors.orange,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                            );
                            return;
                          }
                          Get.back();
                          controller.addDeposit(
                            goalId,
                            amount,
                            notesController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'إيداع',
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

  void _showDeleteConfirmation(GoalModel goal) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
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
                  'حذف الهدف',
                  style: GoogleFonts.cairo(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'هل أنت متأكد من رغبتك في حذف هدف "${goal.title}"؟ لا يمكن التراجع عن هذه العملية.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
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
                          controller.editingGoal = goal;
                          controller.deleteGoal();
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
