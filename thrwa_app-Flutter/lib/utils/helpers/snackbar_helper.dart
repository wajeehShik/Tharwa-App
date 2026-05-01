import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';

class SnackbarHelper {
  SnackbarHelper._();

  static void showSuccess(String message) {
    Get.snackbar(
      '',
      message,
      titleText: const SizedBox.shrink(),
      backgroundColor: AppColors.success,
      colorText: AppColors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle_outline, color: AppColors.white),
    );
  }

  static void showError(String message) {
    Get.snackbar(
      '',
      message,
      titleText: const SizedBox.shrink(),
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
      icon: const Icon(Icons.error_outline, color: AppColors.white),
    );
  }

  static void showWarning(String message) {
    Get.snackbar(
      '',
      message,
      titleText: const SizedBox.shrink(),
      backgroundColor: AppColors.warning,
      colorText: AppColors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.warning_amber_outlined, color: AppColors.white),
    );
  }
}
