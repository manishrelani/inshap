import 'package:shared_preferences/shared_preferences.dart';

class ShareMananer {
  static void setLanguageSetting(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  static Future<Map<String, String>> getLanguageSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> user = new Map<String, String>();
    user["language"] = prefs.get("language");

    return user;
  }
}
