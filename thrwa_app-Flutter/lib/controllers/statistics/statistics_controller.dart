import 'package:get/get.dart';

class StatisticsController extends GetxController {
  // Mock data for the charts
  final RxList<double> weeklyExpenses =
      <double>[40, 60, 45, 30, 80, 20, 40].obs;
  final RxList<double> weeklyXP = <double>[50, 40, 60, 70, 40, 50, 30].obs;

  final RxMap<String, double> resourceDistribution =
      <String, double>{'طعام': 40.0, 'مسكن': 35.0, 'ترفيه': 25.0}.obs;

  final RxDouble totalSpent = 842.0.obs;

  // Transaction history mock
  final RxList<Map<String, dynamic>> recentTransactions =
      <Map<String, dynamic>>[
        {
          'title': 'المعيشة',
          'amount': -336.80,
          'transactions': 12,
          'status': 'معدل استهلاك عالٍ',
          'type': 'expense',
          'category': 'living',
        },
        {
          'title': 'صيانة المقر',
          'amount': -294.70,
          'transactions': 1,
          'status': 'متوقع',
          'type': 'expense',
          'category': 'housing',
        },
        {
          'title': 'الترفيه',
          'amount': -210.50,
          'transactions': 4,
          'status': 'ضمن الحدود',
          'type': 'expense',
          'category': 'entertainment',
        },
      ].obs;
}
