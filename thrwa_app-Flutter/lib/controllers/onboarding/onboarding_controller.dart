import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:thrawa_app/models/onboarding_model.dart';
import 'package:thrawa_app/utils/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      title: tr('onboarding1_title'),
      description: tr('onboarding1_desc'),
      image: 'assets/images/onboarding1.png',
    ),
    OnboardingModel(
      title: tr('onboarding2_title'),
      description: tr('onboarding2_desc'),
      image: 'assets/images/onboarding2.png',
    ),
    OnboardingModel(
      title: tr('onboarding3_title'),
      description: tr('onboarding3_desc'),
      image: 'assets/images/onboarding3.png',
    ),
  ];

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void next() {
    if (currentIndex.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    } else {
      start();
    }
  }

  void skip() {
    // start();
    pageController.jumpToPage(2);
  }

  void start() {
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
