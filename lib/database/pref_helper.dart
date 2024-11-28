import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  // Save login state and username
  static Future<void> saveLoginState(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username); // Save username to SharedPreferences
  }

  static Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', userId);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  // Get login state (username) from SharedPreferences
  static Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username'); // Retrieve the saved username
  }

  // Clear login state
  static Future<void> clearLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('userId'); // Remove username from SharedPreferences
  }
}
