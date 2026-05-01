import 'package:thrawa_app/models/user_model.dart';
import 'package:thrawa_app/services/api/core/api_client.dart';
import 'package:thrawa_app/services/api/core/api_endpoints.dart';
import 'package:thrawa_app/services/api/core/api_response.dart';

/// Data layer: API calls for authentication only.
/// No UI, no state – just data in and data out.
class AuthApiService {
  final ApiClient _client;

  AuthApiService({ApiClient? client}) : _client = client ?? ApiClient();

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      path: ApiEndpoints.login,
      body: {'email': email, 'password': password},
    );

    if (response is ApiSuccess<Map<String, dynamic>>) {
      return UserModel.fromJson(response.data);
    }

    throw Exception((response as ApiFailure).message);
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      path: ApiEndpoints.register,
      body: {'name': name, 'email': email, 'password': password},
    );

    if (response is ApiSuccess<Map<String, dynamic>>) {
      return UserModel.fromJson(response.data);
    }

    throw Exception((response as ApiFailure).message);
  }
}
