import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/controllers/debts/debts_controller.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart' as intl;

class AddDebtScreen extends GetView<DebtsController> {
  const AddDebtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Custom SliverAppBar
            SliverAppBar(
              expandedHeight: 120.h,
              pinned: true,
              backgroundColor: const Color(0xFFF8FAFC),
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () => Get.back(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  controller.editingDebtId.value != null
                      ? 'تعديل الدين'
                      : 'إضافة دين جديد',
                  style: GoogleFonts.cairo(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Mission Card at Top (Hide when editing)
                  if (controller.editingDebtId.value == null)
                    _buildMissionHeader(),

                  if (controller.editingDebtId.value == null)
                    SizedBox(height: 24.h),

                  // Form Fields
                  _buildTextField(
                    label: 'اسم الدين',
                    hint: 'مثال: قرض شخصي',
                    icon: Icons.edit_note_rounded,
                    textInputAction: TextInputAction.next,
                    controller: controller.nameController,
                  ),

                  _buildTextField(
                    label: 'الجهة الدائنة',
                    hint: 'مثال: البنك الأهلي',
                    icon: Icons.account_balance_rounded,
                    textInputAction: TextInputAction.next,
                    controller: controller.creditorController,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'المبلغ الإجمالي',
                          hint: '0.00',
                          suffix: 'ريال',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: controller.amountController,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(child: _buildDatePickerField(context)),
                    ],
                  ),

                  _buildTextField(
                    label: 'القسط الشهري (اختياري)',
                    hint: '0.00',
                    suffix: 'ريال',
                    icon: Icons.payments_outlined,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    controller: controller.installmentController,
                  ),

                  if (controller.editingDebtId.value == null)
                    SizedBox(height: 30.h),

                  // Progress Card (Hide when editing)
                  if (controller.editingDebtId.value == null)
                    _buildProgressCard(),

                  SizedBox(height: 30.h),

                  // Save Button inside scroll view
                  _buildBottomButton(),

                  SizedBox(height: 50.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.stars_rounded,
              color: AppColors.primary,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مهمة جديدة: توثيق الالتزامات',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '+50 XP عند إكمال البيانات',
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_left, color: AppColors.textHint, size: 20.sp),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1, end: 0);
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    IconData? icon,
    String? suffix,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: controller,
            onChanged: (v) => this.controller.refreshTrigger.value++,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            style: GoogleFonts.cairo(
              fontSize: 15.sp,
              color: AppColors.textPrimary,
            ),

            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.cairo(
                color: AppColors.textHint,
                fontSize: 14.sp,
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon:
                  icon != null
                      ? Icon(icon, color: AppColors.primary, size: 22.sp)
                      : null,
              suffixText: suffix,
              suffixStyle: GoogleFonts.cairo(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 15.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(
                  color: const Color(0xFFF1F5F9),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تاريخ الاستحقاق',
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now().add(const Duration(days: 30)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
              );
              if (picked != null) {
                controller.dueDate.value = picked;
                controller.refreshTrigger.value++;
              }
            },
            child: Obx(
              () => Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color:
                        controller.dueDate.value != null
                            ? AppColors.primary
                            : const Color(0xFFF1F5F9),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      controller.dueDate.value == null
                          ? 'YY/MM/DD'
                          : intl.DateFormat(
                            'yyyy/MM/dd',
                          ).format(controller.dueDate.value!),
                      style: GoogleFonts.cairo(
                        color:
                            controller.dueDate.value == null
                                ? AppColors.textHint
                                : AppColors.textPrimary,
                        fontSize: 14.sp,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'تقدم المهمة',
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(controller.formProgress * 100).toInt()}%',
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: controller.formProgress,
                backgroundColor: const Color(0xFFF1F5F9),
                color: AppColors.primary,
                minHeight: 10.h,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'توثيق ديونك هو الخطوة الأولى للحرية المالية.',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildBottomButton() {
    return Obx(
      () => ElevatedButton(
        onPressed:
            controller.formProgress >= 0.8 ? () => controller.saveDebt() : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.4),
          minimumSize: Size(double.infinity, 56.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save_rounded, color: Colors.white, size: 24.sp),
            SizedBox(width: 10.w),
            Text(
              'حفظ الدين',
              style: GoogleFonts.cairo(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  const SliverSizedBox({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: height, width: width));
  }
}
