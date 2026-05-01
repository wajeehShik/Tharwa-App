import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/controllers/savings/savings_controller.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:ui' as ui;
import 'add_goal_screen.dart';

class GoalDetailsScreen extends GetView<SavingsController> {
  final String goalId;
  const GoalDetailsScreen({super.key, required this.goalId});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final goal = controller.goals.firstWhereOrNull((g) => g.id == goalId);
      if (goal == null) {
        return const Scaffold(
          body: Center(child: Text('لم يتم العثور على الهدف')),
        );
      }

      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
            onPressed: () => Get.back(),
          ),
          centerTitle: true,
          title: Text(
            goal.title,
            style: GoogleFonts.cairo(
              color: const Color(0xFF10B981),
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          // actions: [
          //   if (!goal.isCompleted)
          //     IconButton(
          //       icon: const Icon(Icons.edit_rounded, color: Color(0xFF1E293B)),
          //       onPressed: () {
          //         controller.prepareEdit(goal);
          //         Get.to(() => const AddGoalScreen());
          //       },
          //     ),
          // ],
        ),

        body: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(goal),
                SizedBox(height: 24.h),
                _buildDetailsCard(goal),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'سجل الإيداعات',
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '${goal.deposits.length} عمليات',
                      style: GoogleFonts.cairo(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildDepositsList(goal),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeader(GoalModel goal) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المبلغ المستهدف',
                style: GoogleFonts.cairo(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'النسبة المنجزة',
                style: GoogleFonts.cairo(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${goal.targetAmount.toInt()} ر.س',
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(goal.progress * 100).toInt()}%',
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: goal.progress,
              backgroundColor: Colors.white.withOpacity(0.2),
              color: Colors.white,
              minHeight: 12.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(GoalModel goal) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
      ),
      child: Column(
        children: [
          _buildDetailRow('اسم الهدف', goal.title, Icons.flag_rounded),
          const Divider(height: 30),
          _buildDetailRow(
            'وصف الهدف',
            goal.subtitle,
            Icons.description_rounded,
          ),
          const Divider(height: 30),
          _buildDetailRow(
            'المبلغ المتوفر',
            '${goal.savedAmount.toInt()} ر.س',
            Icons.savings_rounded,
          ),
          const Divider(height: 30),
          _buildDetailRow(
            'المبلغ المتبقي',
            '${(goal.targetAmount - goal.savedAmount).toInt()} ر.س',
            Icons.account_balance_wallet_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF10B981), size: 20.sp),
        ),
        SizedBox(width: 16.w),
        Text(
          label,
          style: GoogleFonts.cairo(
            color: AppColors.textSecondary,
            fontSize: 14.sp,
          ),
        ),
        const Spacer(),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.cairo(
              color: AppColors.textPrimary,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  Widget _buildDepositsList(GoalModel goal) {
    if (goal.deposits.isEmpty) {
      return Container(
        height: 150.h,
        alignment: Alignment.center,
        child: Text(
          'لا يوجد إيداعات مسجلة بعد',
          style: GoogleFonts.cairo(color: AppColors.textHint),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: goal.deposits.length,
      itemBuilder: (context, index) {
        final deposit = goal.deposits[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: const Color(0xFFF1F5F9), width: 1.2),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    intl.DateFormat('dd MMMM yyyy', 'ar').format(deposit.date),
                    style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (deposit.notes != null && deposit.notes!.isNotEmpty)
                    Text(
                      deposit.notes!,
                      style: GoogleFonts.cairo(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                '+ ${deposit.amount.toInt()} ر.س',
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
