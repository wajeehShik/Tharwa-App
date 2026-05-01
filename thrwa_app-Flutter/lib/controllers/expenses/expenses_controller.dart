import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:thrawa_app/models/expense_model.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';

class ExpensesController extends GetxController {
  var expenses = <ExpenseModel>[].obs;

  // Form controllers
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  var selectedCategory = 'طعام'.obs;
  var selectedClassification = 'أساسي'.obs;
  var selectedDate = DateTime.now().obs;

  ExpenseModel? editingExpense;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  void _loadMockData() {
    expenses.addAll([
      ExpenseModel(
        id: '1',
        title: 'شراء أغراض منزلية',
        category: 'طعام',
        classification: 'أساسي',
        amount: 85.00,
        date: DateTime(2023, 10, 25),
        icon: Icons.restaurant,
        color: const Color(0xFF109D59),
      ),
      ExpenseModel(
        id: '2',
        title: 'فاتورة الكهرباء',
        category: 'مواصلات',
        classification: 'أساسي',
        amount: 115.50,
        date: DateTime(2023, 10, 26),
        icon: Icons.directions_car,
        color: const Color(0xFF109D59),
      ),
      ExpenseModel(
        id: '3',
        title: 'وجبة غداء',
        category: 'ترفيه',
        classification: 'كمالي',
        amount: 45.00,
        date: DateTime(2023, 10, 27),
        icon: Icons.celebration,
        color: const Color(0xFFFF9800),
      ),
    ]);
  }

  void prepareEdit(ExpenseModel expense) {
    editingExpense = expense;
    amountController.text = expense.amount.toString();
    descriptionController.text = expense.title;
    selectedCategory.value = expense.category;
    selectedClassification.value = expense.classification;
    selectedDate.value = expense.date;
  }

  void clearForm() {
    editingExpense = null;
    amountController.clear();
    descriptionController.clear();
    selectedCategory.value = 'طعام';
    selectedClassification.value = 'أساسي';
    selectedDate.value = DateTime.now();
  }

  void saveExpense() {
    if (amountController.text.isEmpty) {
      Get.snackbar(
        'خطأ',
        'يرجى إدخال المبلغ',
        backgroundColor: Colors.red.withOpacity(0.1),
      );
      return;
    }

    final amount = double.tryParse(amountController.text) ?? 0;
    final isEditing = editingExpense != null;

    if (isEditing) {
      // Update existing
      final index = expenses.indexWhere((e) => e.id == editingExpense!.id);
      if (index != -1) {
        expenses[index] = editingExpense!.copyWith(
          title:
              descriptionController.text.isEmpty
                  ? selectedCategory.value
                  : descriptionController.text,
          amount: amount,
          date: selectedDate.value,
          category: selectedCategory.value,
          classification: selectedClassification.value,
          icon: _getCategoryIcon(selectedCategory.value),
          color: _getCategoryColor(selectedCategory.value),
        );
      }
    } else {
      // Add new
      final newExpense = ExpenseModel(
        id: DateTime.now().toString(),
        title:
            descriptionController.text.isEmpty
                ? selectedCategory.value
                : descriptionController.text,
        amount: amount,
        date: DateTime.now(), // Automatically set current date
        category: selectedCategory.value,
        classification: selectedClassification.value,
        icon: _getCategoryIcon(selectedCategory.value),
        color: _getCategoryColor(selectedCategory.value),
      );
      expenses.insert(0, newExpense);
    }

    Get.back();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!isEditing) {
        _showXPReward(
          'المصروف',
          'تمت إضافة المصروف بنجاح,سيتم خصم من رصيدك -15xp',
        );
      } else {
        _showSuccessSnackbar('التعديل', 'تم تحديث المصروف بنجاح');
      }
    });

    clearForm();
  }

  void deleteExpense(String id) {
    expenses.removeWhere((e) => e.id == id);

    Future.delayed(const Duration(milliseconds: 300), () {
      _showSuccessSnackbar('الحذف', 'تم حذف المصروف بنجاح');
    });
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

  void _showXPReward(String title, String message) {
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
              const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.redAccent,
                    size: 90,
                  )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .shimmer(duration: 1200.ms, color: Colors.white)
                  .scale(duration: 600.ms, curve: Curves.elasticOut),
              const SizedBox(height: 20),
              Text(
                'تنبيه المصروفات',
                style: GoogleFonts.cairo(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'تذكر أن كل مصروف يقربك من نفاذ ميزانيتك! حاول الادخار أكثر.',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  color: Colors.black87,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'فهمت',
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
    ); //.then((_) => _showSuccessSnackbar(title, message));
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'طعام':
        return Icons.restaurant;
      case 'مواصلات':
        return Icons.directions_car;
      case 'تسوق':
        return Icons.shopping_bag;
      case 'ترفيه':
        return Icons.celebration;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(String category) {
    return const Color(0xFF109D59); // Unified green as per image buttons
  }
}
