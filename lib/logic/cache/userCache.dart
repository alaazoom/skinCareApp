import 'dart:convert';
import 'package:ecommere2/logic/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalStorage {
  static const String key = "cached_user";

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);

    if (data == null) return null;

    return UserModel.fromJson(jsonDecode(data));
  }
}