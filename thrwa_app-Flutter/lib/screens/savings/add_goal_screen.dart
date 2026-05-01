import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/controllers/savings/savings_controller.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:thrawa_app/widgets/custom_text_field.dart';
import 'dart:ui' as ui;

class AddGoalScreen extends GetView<SavingsController> {
  const AddGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Obx(
          () => Text(
            controller.isEditing.value ? 'تعديل الهدف' : 'إضافة هدف ادخار جديد',
            style: GoogleFonts.cairo(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF109D59)),
          onPressed: () {
            controller.clearForm();
            Get.back();
          },
        ),
      ),
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Incentive Banner
              _buildIncentiveBanner(),

              SizedBox(height: 30.h),

              // Goal Name
              _buildLabel('اسم الهدف'),
              CustomTextField(
                controller: controller.titleController,
                hint: 'مثلاً: سيارة جديدة، رحلة سياحية',
                prefixIcon: Icons.edit_note,
                textInputAction: TextInputAction.next,
              ),

              SizedBox(height: 25.h),

              // Target Amount
              _buildLabel('المبلغ الإجمالي المستهدف'),
              CustomTextField(
                controller: controller.targetAmountController,
                hint: '0.00',
                prefixIcon: Icons.payments_outlined,
                keyboardType: TextInputType.number,
                suffix: Text(
                  'SAR',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF065F46),
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  'سيتم تقسيم هذا المبلغ على فترات ادخار ذكية',
                  style: GoogleFonts.cairo(fontSize: 11.sp, color: Colors.grey),
                ),
              ),

              SizedBox(height: 15.h),

              // Initial Deposit
              _buildLabel('إيداع أولي (اختياري)'),
              CustomTextField(
                controller: controller.initialDepositController,
                hint: 'ابتدأ بمبلغ بسيط',
                prefixIcon: Icons.account_balance_wallet_outlined,
                keyboardType: TextInputType.number,
                suffix: Text(
                  'SAR',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF065F46),
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),

              SizedBox(height: 40.h),

              // Action Button
              SizedBox(
                width: double.infinity,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () => controller.saveGoal(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF065F46),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    elevation: 5,
                    shadowColor: const Color(0xFF065F46).withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        controller.isEditing.value
                            ? Icons.check_circle_outline
                            : Icons.add_task,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        controller.isEditing.value
                            ? 'حفظ التعديلات'
                            : 'إنشاء الخزنة',
                        style: GoogleFonts.cairo(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Delete Button (if editing)
              // Obx(
              //   () =>
              //       controller.isEditing.value
              //           ? Padding(
              //             padding: EdgeInsets.only(top: 15.h),
              //             child: SizedBox(
              //               width: double.infinity,
              //               height: 55.h,
              //               child: OutlinedButton(
              //                 onPressed: () => controller.deleteGoal(),
              //                 style: OutlinedButton.styleFrom(
              //                   side: const BorderSide(color: Colors.red),
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(15.r),
              //                   ),
              //                 ),
              //                 child: Text(
              //                   'حذف الهدف',
              //                   style: GoogleFonts.cairo(
              //                     color: Colors.red,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           )
              //           : const SizedBox.shrink(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, right: 5.w),
      child: Text(
        label,
        style: GoogleFonts.cairo(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildIncentiveBanner() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7F0),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFBEE7D7), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: Color(0xFF109D59),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.stars, color: Colors.white),
          ),
          SizedBox(width: 15.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تحفيز للإنجاز',
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF109D59),
                  ),
                ),
                Text(
                  'احصل على 150 XP عند إنشاء هدفك الأول',
                  style: GoogleFonts.cairo(
                    fontSize: 13.sp,
                    color: const Color(0xFF3F6656),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
