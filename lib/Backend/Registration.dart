import 'package:http/http.dart' as http;
import 'package:inshape/Backend/urls.dart';
import 'package:inshape/Model/response.dart';
import 'dart:convert';

class Registration {
  Future<RegResponse> register(email, fullName, pass, mobile) async {
    final response = await http.post(
      API_REG,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        "fullName": fullName,
        "email": email,
        "password": pass,
        "mobile": mobile
      }),
    );
    return RegResponse.fromJson(json.decode(response.body));
  }

  // ignore: missing_return
  Future<RegResponse> sendEmailVerification(email) async {
    final response = await http.post(
      API_EMAIL_VERIFY,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        "email": email
      })
    );
    return RegResponse.fromJson(json.decode(response.body));
  }

  //varify otp
  Future <RegResponse> verifyOtp(otp,email) async {
    final response = await http.put(
        API_EMAIL_VERIFY,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          "email": email,
          "otp":otp
        })
    );
    return RegResponse.fromJson(json.decode(response.body));
  }
}
