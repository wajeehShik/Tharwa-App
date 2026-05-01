import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thrawa_app/models/debt_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DebtsController extends GetxController {
  final debts = <DebtModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Adding some mock data based on the image
    debts.addAll([
      DebtModel(
        id: '1',
        title: 'قرض البنك الراجحي',
        creditor: 'البنك الراجحي',
        subtitle: 'تم سداد 35,000 من 60,000 ر.س',
        totalAmount: 60000,
        remainingAmount: 25000,
        paidAmount: 35000,
        dueDate: DateTime.now().add(const Duration(days: 3)),
        isWarning: false,
      ),
      DebtModel(
        id: '2',
        title: 'دين خالد (شخصي)',
        creditor: 'خالد',
        subtitle: 'تم سداد 1,500 من 5,000 ر.س',
        totalAmount: 5000,
        remainingAmount: 3500,
        paidAmount: 1500,
        dueDate: DateTime.now().add(const Duration(days: 25)),
      ),
      DebtModel(
        id: '3',
        title: 'دين خالد (شخصي)',
        creditor: 'خالد',
        subtitle: 'تم سداد 1,500 من 5,000 ر.س',
        totalAmount: 5000,
        remainingAmount: 3500,
        paidAmount: 1500,
        dueDate: DateTime.now().add(const Duration(days: 25)),
        icon: Icons.person_outline,
      ),
    ]);
  }

  double get totalRemaining =>
      debts.fold(0, (sum, item) => sum + item.remainingAmount);
  double get totalPaid => debts.fold(0, (sum, item) => sum + item.paidAmount);
  double get totalAll => debts.fold(0, (sum, item) => sum + item.totalAmount);
  double get overallProgress => totalAll > 0 ? totalPaid / totalAll : 0;

  final nameController = TextEditingController();
  final creditorController = TextEditingController();
  final amountController = TextEditingController();
  final installmentController = TextEditingController();
  final dueDate = Rxn<DateTime>();
  final refreshTrigger = 0.obs;

  final editingDebtId = RxnString();

  double get formProgress {
    refreshTrigger.value; // Watch for changes
    double progress = 0;

    if (nameController.text.isNotEmpty) progress += 0.2;
    if (creditorController.text.isNotEmpty) progress += 0.2;
    if (amountController.text.isNotEmpty) progress += 0.2;
    if (dueDate.value != null) progress += 0.2;
    if (installmentController.text.isNotEmpty) progress += 0.2;
    return progress;
  }

  @override
  void onClose() {
    nameController.dispose();
    creditorController.dispose();
    amountController.dispose();
    installmentController.dispose();
    super.onClose();
  }

  void resetForm() {
    nameController.clear();
    creditorController.clear();
    amountController.clear();
    installmentController.clear();
    dueDate.value = null;
    editingDebtId.value = null;
  }

  void prepareEdit(DebtModel debt) {
    nameController.text = debt.title;
    creditorController.text = debt.creditor;
    amountController.text = debt.totalAmount.toString();
    installmentController.text = debt.monthlyInstallment?.toString() ?? "";
    dueDate.value = debt.dueDate;
    editingDebtId.value = debt.id;
    refreshTrigger.value++;
  }

  void saveDebt() {
    if (formProgress < 0.8) return;

    final existingDebt =
        editingDebtId.value != null
            ? debts.firstWhereOrNull((d) => d.id == editingDebtId.value)
            : null;

    final newDebt = DebtModel(
      id:
          editingDebtId.value ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: nameController.text,
      creditor: creditorController.text,
      subtitle:
          existingDebt != null
              ? 'تم سداد ${existingDebt.paidAmount.toInt()} من ${amountController.text} ر.س'
              : 'تم سداد 0 من ${amountController.text} ر.س',
      totalAmount: double.tryParse(amountController.text) ?? 0,
      remainingAmount:
          (double.tryParse(amountController.text) ?? 0) -
          (existingDebt?.paidAmount ?? 0),
      paidAmount: existingDebt?.paidAmount ?? 0,
      dueDate: dueDate.value ?? DateTime.now(),
      monthlyInstallment: double.tryParse(installmentController.text),
      installments: existingDebt?.installments ?? [],
    );
    if (editingDebtId.value != null) {
      final index = debts.indexWhere((d) => d.id == editingDebtId.value);
      if (index != -1) {
        debts[index] = newDebt;
      }
      Get.back();
      // تأخير بسيط لضمان ظهور الإشعار بعد انتهاء حركة الرجوع
      Future.delayed(const Duration(milliseconds: 300), () {
        _showSuccessSnackbar('التعديل', 'تمت عملية التعديل بنجاح');
      });
    } else {
      debts.add(newDebt);
      Get.back();
      _showXPReward('الإضافة', 'تمت عملية الإضافة بنجاح');
    }

    resetForm();
  }

  void deleteDebt(String id) {
    debts.removeWhere((d) => d.id == id);
    _showSuccessSnackbar('الحذف', 'تمت عملية الحذف بنجاح');
  }

  void addInstallment(String debtId, double amount, String? notes) {
    final index = debts.indexWhere((d) => d.id == debtId);
    if (index != -1) {
      final oldDebt = debts[index];

      // التأكد من أن المبلغ المدخل لا يتجاوز المبلغ المتبقي

      final actualAmount =
          (amount > oldDebt.remainingAmount) ? oldDebt.remainingAmount : amount;

      final newPaidAmount = oldDebt.paidAmount + actualAmount;
      final newRemaining = oldDebt.totalAmount - newPaidAmount;

      final installment = InstallmentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: actualAmount,
        date: DateTime.now(),
        notes: notes,
      );

      final updatedDebt = DebtModel(
        id: oldDebt.id,
        title: oldDebt.title,
        creditor: oldDebt.creditor,
        subtitle:
            newRemaining <= 0
                ? 'تم سداد كامل المبلغ بنجاح 🎉'
                : 'تم سداد ${newPaidAmount.toInt()} من ${oldDebt.totalAmount.toInt()} ر.س',
        totalAmount: oldDebt.totalAmount,
        remainingAmount: newRemaining < 0 ? 0 : newRemaining,
        paidAmount:
            newPaidAmount > oldDebt.totalAmount
                ? oldDebt.totalAmount
                : newPaidAmount,
        dueDate: oldDebt.dueDate,
        monthlyInstallment: oldDebt.monthlyInstallment,
        icon: oldDebt.icon,
        isWarning: oldDebt.isWarning,
        installments: [...oldDebt.installments, installment],
      );

      debts[index] = updatedDebt;
      debts.refresh();

      if (updatedDebt.isCompleted) {
        _showCompletionReward();
      } else {
        _showXPReward('التسديد', 'تمت إضافة القسط بنجاح وكسب الـ XP');
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
