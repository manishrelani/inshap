import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inshape/Backend/response_handler.dart';
import 'package:inshape/Model/response.dart';
import 'package:inshape/data_models/result.dart';
import 'package:inshape/providers/session.dart';

import 'urls.dart';

class Auth {
 

  Future<Result<String>> login(email, pass) async {
    final response = await http.post(
      API_AUTH,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        "email": email,
        "password": pass,
      }),
    );

//    debugPrint(response.body);
//    debugPrint(response.statusCode.toString());
    Result<String> result = ResponseHandler.getResult(response);
    if (result.success) {
//      result.data = LoginRes.fromJson(json.decode(response.body));
      result.data = response.body;
      await SessionProvider.setJWT(response.headers['set-cookie']);
    }
    return result;
  }

  Future<RegResponse> sendResetPassOtp(email) async {
    final response = await http.post(
      API_RESET,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        "email": email,
      }),
    );
    return RegResponse.fromJson(json.decode(response.body));
  }

  Future<RegResponse> verifyResetPassOtp(email, otp) async {
    print("Data");
    final response = await http.patch(
      API_RESET,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode({"email": email, "otp": otp}),
    );
    return RegResponse.fromJson(json.decode(response.body));
  }

  Future<RegResponse> resetPass(email, otp, pass) async {
    final response = await http.patch(
      API_RESET,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: json.encode({"email": email, "otp": otp, "password": pass}),
    );
    return RegResponse.fromJson(json.decode(response.body));
  }

  // ignore: missing_return
  Future<RegResponse> logOut() async {
    final response = await http.delete(
      API_RESET,
      headers: {
        'accept': 'application/json',
      },
    );
    return RegResponse.fromJson(json.decode(response.body));
  }
}
