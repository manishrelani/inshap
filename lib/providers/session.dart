import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class SessionProvider with ChangeNotifier {
  static const JWT_KEY = "jwt";
  static const PROFILE_STATUS_KEY = "profile_filled";

//  static SharedPreferences _sharedPrefs;
  static final _storage = FlutterSecureStorage();

  static String jwt;

  static Future<bool> init() async {
//    _sharedPrefs = await SharedPreferences.getInstance();
    jwt = await _storage.read(key: JWT_KEY);
    if (jwt == null) {
      return false;
    }

    debugPrint(jwt);
    // check if payload is expired

    final jJWT = jwt.split(";")[0].replaceFirst("jwt=", "");
    final parts = jJWT.split('.');
    if (parts.length != 3) {
      return false;
    }

    final payload = parts[1];
    var normalized = base64Url.normalize(payload);
    var resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);

    if (payloadMap is! Map<String, dynamic>) {
      // invalid jwt
      return false;
    }

    // debugPrint("Exp: ${payloadMap["exp"]}");
    if (DateTime.fromMillisecondsSinceEpoch(payloadMap["exp"] * 1000)
        .isAfter(DateTime.now())) {
      return true;
    }

    // payload expired, refresh the token and continue
    return false;
  }

  static Future<void> setJWT(String token) async {
    await _storage.delete(key: JWT_KEY);
    jwt = token;
    await _storage.write(key: JWT_KEY, value: token);
  }

  static Future<String> getJWT(String token) async {
    return await _storage.read(key: JWT_KEY);
  }

  static Future<void> setFilledProfile() async {
    await _storage.delete(key: PROFILE_STATUS_KEY);
    await _storage.write(key: PROFILE_STATUS_KEY, value: "true");
  }

  static Future<bool> isProfileFilled() async {
    final res = await _storage.read(key: PROFILE_STATUS_KEY) ?? "false";
    return res.contains("true") ? true : false;
  }

  static clear() async {
    debugPrint("clearing all local data");
    await _storage.deleteAll();
  }
}
