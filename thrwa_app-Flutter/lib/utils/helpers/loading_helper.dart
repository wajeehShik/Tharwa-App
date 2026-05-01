import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingHelper {
  LoadingHelper._();

  static void show() {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
