import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';

class SavingsController extends GetxController {
  // Goal Model class defined locally or imported
  var goals =
      <GoalModel>[
        GoalModel(
          id: '1',
          title: "لابتوب جديد",
          subtitle: "للعمل الحر",
          targetAmount: 8000,
          savedAmount: 4500,
          monthlyAddition: 250,
          icon: Icons.laptop_mac,
        ),
        GoalModel(
          id: '2',
          title: "سفرة الصيف",
          subtitle: "أوروبا",
          targetAmount: 5000,
          savedAmount: 1200,
          monthlyAddition: 500,
          icon: Icons.flight_takeoff,
        ),
        GoalModel(
          id: '3',
          title: "جوال جديد",
          subtitle: "ترقية",
          targetAmount: 4000,
          savedAmount: 3800,
          isNear: true,
          icon: Icons.phone_android,
        ),
      ].obs;

  // Form Controllers
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final targetAmountController = TextEditingController();
  final initialDepositController = TextEditingController();

  var isEditing = false.obs;
  GoalModel? editingGoal;

  double get totalSavings =>
      goals.fold(0, (sum, item) => sum + item.savedAmount);
  double get totalTarget =>
      goals.fold(0, (sum, item) => sum + item.targetAmount);
  double get totalProgress => totalTarget > 0 ? totalSavings / totalTarget : 0;

  void clearForm() {
    titleController.clear();
    subtitleController.clear();
    targetAmountController.clear();
    initialDepositController.clear();
    isEditing.value = false;
    editingGoal = null;
  }

  void prepareEdit(GoalModel goal) {
    editingGoal = goal;
    titleController.text = goal.title;
    subtitleController.text = goal.subtitle;
    targetAmountController.text = goal.targetAmount.toString();
    initialDepositController.text = goal.savedAmount.toString();
    isEditing.value = true;
  }

  void saveGoal() {
    if (titleController.text.isEmpty || targetAmountController.text.isEmpty) {
      Get.snackbar(
        'خطأ',
        'يرجى ملء الحقول المطلوبة',
        backgroundColor: Colors.red[100],
      );
      return;
    }

    final newGoal = GoalModel(
      id: editingGoal?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      subtitle:
          subtitleController.text.isEmpty
              ? 'هدف ادخار'
              : subtitleController.text,
      targetAmount: double.tryParse(targetAmountController.text) ?? 0,
      savedAmount: double.tryParse(initialDepositController.text) ?? 0,
      icon: editingGoal?.icon ?? Icons.savings_outlined,
      monthlyAddition: editingGoal?.monthlyAddition,
      isNear: editingGoal?.isNear ?? false,
      deposits: editingGoal?.deposits ?? [],
    );

    if (isEditing.value && editingGoal != null) {
      int index = goals.indexOf(editingGoal!);
      if (index != -1) goals[index] = newGoal;
      Future.delayed(const Duration(milliseconds: 300), () {
        // Get.snackbar(
        //   'نجاح',
        //   'تم تحديث الهدف بنجاح',
        //   backgroundColor: Colors.green[100],
        // );
        _showSuccessSnackbar('التعديل', 'تم تحديث الهدف بنجاح');
      });
    } else {
      goals.add(newGoal);
      Future.delayed(const Duration(milliseconds: 300), () {
        // Get.snackbar(
        //   'نجاح',
        //   'تمت إضافة الهدف بنجاح',
        //   backgroundColor: Colors.green[100],
        // );
        _showXPReward('الإضافة', 'تمت إضافة الهدف بنجاح');
      });
    }

    Get.back();
    clearForm();
  }

  void deleteGoal() {
    if (editingGoal != null) {
      goals.remove(editingGoal);
      Get.back();

      Future.delayed(const Duration(milliseconds: 300), () {
        _showSuccessSnackbar('الحذف', 'تم حذف الهدف بنجاح');
      });
      clearForm();
    }
  }

  void addDeposit(String goalId, double amount, String? notes) {
    final index = goals.indexWhere((g) => g.id == goalId);
    if (index != -1) {
      final oldGoal = goals[index];

      final actualAmount =
          (amount > (oldGoal.targetAmount - oldGoal.savedAmount))
              ? (oldGoal.targetAmount - oldGoal.savedAmount)
              : amount;

      final newSavedAmount = oldGoal.savedAmount + actualAmount;

      final deposit = GoalDeposit(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: actualAmount,
        date: DateTime.now(),
        notes: notes,
      );

      final updatedGoal = GoalModel(
        id: oldGoal.id,
        title: oldGoal.title,
        subtitle:
            newSavedAmount >= oldGoal.targetAmount
                ? 'تم تحقيق الهدف بنجاح 🎉'
                : oldGoal.subtitle,
        targetAmount: oldGoal.targetAmount,
        savedAmount: newSavedAmount,
        monthlyAddition: oldGoal.monthlyAddition,
        isNear: newSavedAmount >= (oldGoal.targetAmount * 0.8),
        icon: oldGoal.icon,
        deposits: [...oldGoal.deposits, deposit],
      );

      goals[index] = updatedGoal;
      goals.refresh();

      if (updatedGoal.isCompleted) {
        _showCompletionReward();
      } else {
        _showXPReward('الإيداع', 'تمت إضافة المبلغ بنجاح وكسب الـ XP');
      }
    }
  }

  void _showCompletionReward() {
    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.green, width: 2),
            boxShadow: [
              BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 20),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.green,
                    size: 100,
                  )
                  .animate()
                  .scale(duration: 800.ms, curve: Curves.elasticOut)
                  .shimmer(delay: 800.ms),
              const SizedBox(height: 20),
              Text(
                'مبروك! تم الإنجاز',
                style: GoogleFonts.cairo(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'لقد تم تحقيق الهدف رائع احصل على الهداية',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  color: Colors.black87,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(200, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'استلام الهدية 🎁',
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack).fadeIn(),
      barrierDismissible: false,
    );
  }

  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(15),
      borderRadius: 15,
    );
  }

  void _showXPReward([
    String title = 'الإضافة',
    String message = 'تمت العملية بنجاح',
  ]) {
    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.stars_rounded, color: Colors.amber, size: 90)
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 1200.ms, color: Colors.white)
                  .scale(duration: 600.ms, curve: Curves.elasticOut),
              const SizedBox(height: 20),
              Text(
                'تهانينا!',
                style: GoogleFonts.cairo(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'لقد كسبت 50xp لانجازك هذه المهمة',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  color: Colors.black87,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'متابعة',
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack).fadeIn(),
      barrierDismissible: false,
    ).then((_) => _showSuccessSnackbar(title, message));
  }
}

class GoalModel {
  final String id;
  final String title;
  final String subtitle;
  final double targetAmount;
  final double savedAmount;
  final double? monthlyAddition;
  final bool isNear;
  final IconData icon;
  final List<GoalDeposit> deposits;

  GoalModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.targetAmount,
    required this.savedAmount,
    this.monthlyAddition,
    this.isNear = false,
    required this.icon,
    this.deposits = const [],
  });

  double get progress => savedAmount / targetAmount;
  bool get isCompleted => progress >= 1.0;
}

class GoalDeposit {
  final String id;
  final double amount;
  final DateTime date;
  final String? notes;

  GoalDeposit({
    required this.id,
    required this.amount,
    required this.date,
    this.notes,
  });
}
