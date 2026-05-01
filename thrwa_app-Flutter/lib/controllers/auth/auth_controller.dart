import 'package:get/get.dart';
import 'package:thrawa_app/models/user_model.dart';
import 'package:thrawa_app/services/api/auth_api_service.dart';
import 'package:thrawa_app/services/firebase/auth_firebase_service.dart';
import 'package:thrawa_app/services/hive/auth_hive_service.dart';
import 'package:thrawa_app/utils/helpers/snackbar_helper.dart';
import 'package:thrawa_app/utils/routes/app_routes.dart';

/// Controller layer: business logic + reactive state for Auth.
/// ⚠️ No direct API/Firebase calls – only through service layer.
class AuthController extends GetxController {
  final AuthFirebaseService _firebaseService;
  final AuthApiService _apiService;
  final AuthHiveService _localService;

  AuthController({
    required AuthFirebaseService firebaseService,
    required AuthApiService apiService,
    required AuthHiveService localService,
  }) : _firebaseService = firebaseService,
       _apiService = apiService,
       _localService = localService;

  // ─── Reactive State ───────────────────────────────────────────────────────

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  // ─── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    _checkStoredUser();
  }

  // ─── Private helpers ─────────────────────────────────────────────────────

  Future<void> _checkStoredUser() async {
    final stored = await _localService.getUser();
    if (stored != null) {
      user.value = stored;
      Get.offAllNamed(AppRoutes.home);
    }
  }

  // ─── Public methods ───────────────────────────────────────────────────────

  Future<void> login({required String email, required String password}) async {
    isLoading.value = true;
    try {
      // 1. Firebase Auth
      await _firebaseService.signInWithEmail(email: email, password: password);

      // // 2. API Auth (passing the same credentials or firebase token if needed)
      // final apiUser = await _apiService.login(email: email, password: password);

      // // Save user (prefer API user data if they differ, or merge)
      // user.value = apiUser;
      // await _localService.saveUser(apiUser);

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      SnackbarHelper.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      // 1. Firebase Register
      await _firebaseService.registerWithEmail(
        name: name,
        email: email,
        password: password,
      );

      // 2. API Register
      // final apiUser = await _apiService.register(
      //   name: name,
      //   email: email,
      //   password: password,
      // );

      // user.value = apiUser;
      // await _localService.saveUser(apiUser);

      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      SnackbarHelper.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await _firebaseService.signOut();
      await _localService.clearUser();
      user.value = null;
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      SnackbarHelper.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
