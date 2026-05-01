import 'package:get/get.dart';
import 'package:thrawa_app/controllers/auth/auth_controller.dart';
import 'package:thrawa_app/services/api/auth_api_service.dart';
import 'package:thrawa_app/services/firebase/auth_firebase_service.dart';
import 'package:thrawa_app/services/hive/auth_hive_service.dart';

/// Injects dependencies for [AuthController] via GetX lazy binding.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthHiveService>(() => AuthHiveService());
    Get.lazyPut<AuthFirebaseService>(() => AuthFirebaseService());
    Get.lazyPut<AuthApiService>(() => AuthApiService());
    Get.lazyPut<AuthController>(
      () => AuthController(
        firebaseService: Get.find<AuthFirebaseService>(),
        apiService: Get.find<AuthApiService>(),
        localService: Get.find<AuthHiveService>(),
      ),
    );
  }
}
