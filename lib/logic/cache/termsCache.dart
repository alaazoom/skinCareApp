import 'package:shared_preferences/shared_preferences.dart';

class TermsCache {
  static const String key = "cached_terms";

  Future<void> save(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  Future<String?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}