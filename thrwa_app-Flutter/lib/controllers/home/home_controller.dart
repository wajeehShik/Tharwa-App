import 'package:get/get.dart';

class HomeController extends GetxController {
  final userName = 'أحمد'.obs;
  final balanceIncome = 850.0.obs;
  final balanceExpense = 420.0.obs;
  final balancedebt = 103.0.obs;

  final frozenAmount = 100.0.obs;

  final expenseDistribution =
      [
        {'name': 'احتياجات', 'value': 40.0, 'color': 0xFF34A853},
        {'name': 'كماليات', 'value': 25.0, 'color': 0xFFF59E0B},
        {'name': 'ادخار', 'value': 35.0, 'color': 0xFF10B981},
      ].obs;

  final goals =
      [
        {'title': 'سيارة', 'progress': 0.9, 'color': 0xFF34A853},
        {'title': 'عطلة', 'progress': 0.7, 'color': 0xFF10B981},
        {'title': 'منزل', 'progress': 0.5, 'color': 0xFFF59E0B},
      ].obs;

  final debts =
      [
        {
          'title': 'احتياجات',
          'amount': 100.0,
          'date': '05.04.2023',
          'isPaid': true,
        },
        {
          'title': 'الديون',
          'amount': -25.0,
          'date': '10.05.2023',
          'isPaid': false,
        },
        {'title': 'أخرى', 'amount': 28.0, 'date': '12.06.2023', 'isPaid': true},
      ].obs;
}
