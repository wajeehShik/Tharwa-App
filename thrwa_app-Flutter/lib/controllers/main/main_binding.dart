import 'package:get/get.dart';
import 'package:thrawa_app/controllers/main/main_controller.dart';
import 'package:thrawa_app/controllers/home/home_controller.dart';
import 'package:thrawa_app/controllers/expenses/expenses_controller.dart';
import 'package:thrawa_app/controllers/savings/savings_controller.dart';
import 'package:thrawa_app/controllers/debts/debts_controller.dart';
import 'package:thrawa_app/controllers/statistics/statistics_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ExpensesController>(() => ExpensesController());
    Get.lazyPut<SavingsController>(() => SavingsController());
    Get.lazyPut<DebtsController>(() => DebtsController());
    Get.lazyPut<StatisticsController>(() => StatisticsController());
  }
}
