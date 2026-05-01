import 'package:get/get.dart';
import 'package:thrawa_app/controllers/statistics/statistics_controller.dart';

class StatisticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisticsController>(() => StatisticsController());
  }
}
