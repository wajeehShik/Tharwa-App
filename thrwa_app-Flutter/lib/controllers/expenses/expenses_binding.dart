import 'package:get/get.dart';
import 'package:thrawa_app/controllers/expenses/expenses_controller.dart';

class ExpensesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpensesController>(() => ExpensesController());
  }
}
