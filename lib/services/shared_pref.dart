import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<bool> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool?> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
