import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:thrawa_app/models/user_model.dart';

/// Data layer: Local storage for auth user data using Hive.
/// No UI, no state – just data in and data out.
class AuthHiveService {
  static const String _boxName = 'auth';
  static const String _userKey = 'user';

  Future<Box> _openBox() async => Hive.openBox(_boxName);

  Future<void> saveUser(UserModel user) async {
    final box = await _openBox();
    await box.put(_userKey, jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUser() async {
    final box = await _openBox();
    final raw = box.get(_userKey);
    if (raw == null) return null;
    return UserModel.fromJson(jsonDecode(raw as String));
  }

  Future<void> clearUser() async {
    final box = await _openBox();
    await box.delete(_userKey);
  }

  Future<bool> hasUser() async {
    final user = await getUser();
    return user != null;
  }
}
