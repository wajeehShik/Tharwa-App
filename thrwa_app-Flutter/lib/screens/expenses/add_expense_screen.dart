import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui' as ui;
import 'package:thrawa_app/controllers/expenses/expenses_controller.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';

class AddExpenseScreen extends GetView<ExpensesController> {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          controller.editingExpense != null
              ? 'تعديل المصروف'
              : 'إضافة مصروف جديد',
          style: GoogleFonts.cairo(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
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
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              // Amount Field
              _buildSectionLabel('المبلغ'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        textAlign: TextAlign.right,
                        textDirection: ui.TextDirection.ltr,
                        style: GoogleFonts.cairo(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'SAR',
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),

              // Classification
              _buildSectionLabel('تصنيف المصروف'),
              Row(
                children: [
                  Expanded(
                    child: _buildClassificationBtn(
                      'أساسي',
                      Icons.check_circle_outline,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: _buildClassificationBtn(
                      'كمالي',
                      Icons.diamond_outlined,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),

              // Category Grid
              _buildSectionLabel('فئة التصنيف'),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 15.r,
                crossAxisSpacing: 15.r,
                childAspectRatio: 1.2,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildCategoryBtn('طعام', Icons.restaurant),
                  _buildCategoryBtn('مواصلات', Icons.directions_car),
                  _buildCategoryBtn('تسوق', Icons.shopping_bag),
                  _buildCategoryBtn('ترفيه', Icons.celebration),
                ],
              ),
              SizedBox(height: 25.h),

              // Note Field
              _buildSectionLabel('ملاحظة (اختياري)'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                ),
                child: TextField(
                  controller: controller.descriptionController,
                  maxLines: 3,
                  style: GoogleFonts.cairo(
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'تفاصيل إضافية...',
                    hintStyle: GoogleFonts.cairo(color: AppColors.textHint),
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              // XP Alert
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFFEE2E2)),
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
                      child: Text(
                        'هذه المصروفات ستكلفك 15 نقاط خبرة (XP).',
                        style: GoogleFonts.cairo(
                          fontSize: 13.sp,
                          color: const Color(0xFFB91C1C),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () => controller.saveExpense(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF109D59),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    controller.editingExpense != null
                        ? 'حفظ التعديلات'
                        : 'تأكيد العملية',
                    style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Align(
        alignment: Alignment.centerRight, // RTL adjustment
        child: Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildClassificationBtn(String label, IconData icon) {
    return Obx(() {
      final isSelected = controller.selectedClassification.value == label;
      return GestureDetector(
        onTap: () => controller.selectedClassification.value = label,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color:
                  isSelected
                      ? const Color(0xFF109D59)
                      : Colors.black.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color:
                    isSelected
                        ? const Color(0xFF109D59)
                        : AppColors.textSecondary,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 15.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color:
                      isSelected
                          ? const Color(0xFF109D59)
                          : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCategoryBtn(String label, IconData icon) {
    return Obx(() {
      final isSelected = controller.selectedCategory.value == label;
      return GestureDetector(
        onTap: () => controller.selectedCategory.value = label,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color:
                  isSelected
                      ? const Color(0xFF109D59)
                      : Colors.black.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? const Color(0xFF109D59)
                          : const Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color:
                      isSelected
                          ? const Color(0xFF109D59)
                          : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
