import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/controllers/onboarding/onboarding_controller.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: TextButton(
                  onPressed: controller.skip,
                  child: Text(
                    tr('skip'),
                    style: GoogleFonts.cairo(
                      color: AppColors.textSecondary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // PageView with Animations
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.pages.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  final page = controller.pages[index];
                  return AnimatedBuilder(
                    animation: controller.pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (controller
                          .pageController
                          .position
                          .hasContentDimensions) {
                        value = controller.pageController.page! - index;
                        value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                      }
                      return Transform.scale(
                        scale: Curves.easeOut.transform(value),
                        child: child,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Illustration
                          Image.asset(
                            page.image,
                            height: 300.h,
                            // width: 200.w,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(height: 20.h),
                          // Title
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          // Description
                          Text(
                            page.description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                              // height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Footer (Indicator + Button)
            Padding(
              padding: EdgeInsets.all(30.w),
              child: Column(
                children: [
                  // Dot Indicator
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(right: 8.w),
                          height: 8.h,
                          width:
                              controller.currentIndex.value == index
                                  ? 24.w
                                  : 8.w,
                          decoration: BoxDecoration(
                            color:
                                controller.currentIndex.value == index
                                    ? AppColors.accent
                                    : AppColors.divider,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  // Start / Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: controller.next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                        ),
                        child: Text(
                          controller.currentIndex.value ==
                                  controller.pages.length - 1
                              ? tr('start_now')
                              : tr('next'),
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
