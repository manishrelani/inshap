import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inshape/Backend/urls.dart';
import 'package:inshape/Model/response.dart';
import 'package:inshape/Model/userprofile.dart';
import 'package:inshape/providers/session.dart';  

 class UserProfile {
  static Future<RegResponse> createProfile(
      age,
      weight, 
      height,
      gender,
      bodyFrame,
      workOutFrequency,
      expertiseLevel,
      goal,
      dietPlan,
      workOutType,
      muscleType) async {
    final response = await http.post(
      API_PROFILE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
      body: json.encode({
        "gender": gender,
        "age": age,
        "height": height,
        "weight": weight,
        "bodyFrame": bodyFrame,
        "workoutFrequency": workOutFrequency,
        "expertiseLevel": expertiseLevel,
        "goal": goal,
        "dietPlan": dietPlan,
        "workoutTypes": workOutType,
        "muscleTypes": muscleType
      }),
    );
    return RegResponse.fromJson(json.decode(response.body));
  }

  static Future<RegResponse> updateProfile(
      {name,
      age,
      weight,
      height,
      gender,
      bodyFrame,
      workOutFrequency,
      expertiseLevel,
      goal,
      dietPlan,
      workOutType,
      muscleType,
      language,
      appleWatchIntg,
      pedometerIntg}) async {

    var body = Map();

    if (name != null) {
      body["fullName"] = name;
    }
    if (gender != null) {
      body["gender"] = gender;
    }
    if (age != null) {
      body["age"] = age;
    }
    if (height != null) {
      body["height"] = height;
    }
    if (weight != null) {
      body["weight"] = weight;
    }
    if (bodyFrame != null) {
      body["bodyFrame"] = bodyFrame;
    }
    if (workOutFrequency != null) {
      body["workoutFrequency"] = workOutFrequency;
    }
    if (expertiseLevel != null) {
      body["expertiseLevel"] = expertiseLevel;
    }
    if (goal != null) {
      body["goal"] = goal;
    }
    if (dietPlan != null) {
      body["dietPlan"] = dietPlan;
    }
    if (workOutType != null) {
      body["workoutTypes"] = workOutType;
    }
    if (muscleType != null) {
      body["muscleTypes"] = muscleType;
    }
    if (language != null) {
      body["language"] = language;
    }
    if (appleWatchIntg != null) {
      body["appleWatchIntg"] = appleWatchIntg;
    }
    if (pedometerIntg != null) {
      body["pedometerIntg"] = pedometerIntg;
    }

    final response = await http.patch(
      API_PROFILE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
      body: json.encode(body),
    );
    print(response.body);
    return RegResponse.fromJson(json.decode(response.body));
  }

  // ignore: missing_return
  static Future<UserProfileModel> getProfile() async {
    final response = await http.get(
      API_PROFILE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
    return UserProfileModel.fromJson(json.decode(response.body));
  }

  static Future<String> updatePassword(String oldPassword, String newPassword) async{
    final response = await http.patch(
      API_USER_PASSWORD,
      body: jsonEncode({
        "oldPassword": oldPassword,
        "newPassword": newPassword
      }),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
    return response.body;
  }

  static Future<String> uploadavtar(var image) async{
    final response = await http.post(
      API_PROFILE_AVATAR,
      body: jsonEncode({
        "avatarUrl": image,
      }),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        'Cookie': SessionProvider.jwt,
      },
    );
    return response.body;
  }
}
