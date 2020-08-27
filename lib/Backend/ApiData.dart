import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inshape/Backend/urls.dart';
import 'package:inshape/Model/quotes.dart';
import 'package:inshape/Model/targetWorkout.dart';
import 'package:inshape/Model/training.dart';
import 'package:inshape/Model/userprofile.dart';
import 'package:inshape/Model/workout.dart';
import 'package:inshape/providers/session.dart';

class ApiData {
  Future<UserProfileModel> getProfile() async {
    final response = await http.get(API_PROFILE, headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Cookie': SessionProvider.jwt,
    });
    return UserProfileModel.fromJson(json.decode(response.body));
  }

  Future<Quotes> getQuotes() async {
    final response = await http.get(
      API_QUOTES,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
    return Quotes.fromJson(json.decode(response.body));
  }

  static Future<String> getRegenerationType() async {
    final response = await http.get(
      API_REGENERATION_TYPE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
    print("res: ${response.body}");
    return response.body;
  }

  static Future<String> getRegenerationWorout(String name) async {
    final response = await http.get(
      API_REGENERATION + "/$name",
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
    print("resWorout: ${response.body}");
    return response.body;
  }

  Future<WorkOut> getWorkOut() async {
    final response = await http.get(
      API_WORKTYPE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
    );
    return WorkOut.fromJson(json.decode(response.body));
  }

  Future<Training> trainingPlan() async {
    final response = await http.get(
      API_TRAINING,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
    return Training.fromJson(json.decode(response.body));
  }

  static Future<String> favourites() async {
    final response = await http.get(
      API_FAVOURITE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
    return response.body;
  }

  static Future<String> regFavourites() async {
    final response = await http.get(
      API_REG_FAVOURITE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
    return response.body;
  }

  static Future<String> recFavourites() async {
    final response = await http.get(
      API_REC_FAVOURITE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
    return response.body;
  }

  Future<void> addPlan() async {
    final response = await http.patch(
      API_TRAINING,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
    print(response.body);
  }

  Future<TargetWorkOut> getFullWorkOut() async {
    final response = await http.get(
      API_WORKOUT,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
//    print(json.decode(response.body));
    return TargetWorkOut.fromJson(json.decode(response.body));
  }

  static Future<String> getTrainingPlans() async {
    final response = await http.get(
      API_TRAINING,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
    );
    print(response.body);
    return response.body;
  }

  static Future<String> getDashboard() async {
    final response = await http.get(
      API_DASHBOARD,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
    );
    return response.body;
//    return json.decode(response.body)['payload']['trainingPlan']['plan'];
  }

  Future<void> addToFavourites(String workoutId) async {
    final response = await http.post(
      API_FAVOURITE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
      body: jsonEncode(
        {
          "workoutId": workoutId,
        },
      ),
    );
    print(response.body);
  }

  Future<void> deleteFromFavourites(String workoutId) async {
    final response = await http.delete(
      API_FAVOURITE + "/$workoutId",
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
//      body: jsonEncode(
//        {
//          "workoutId": workoutId,
//        },
//      ),
    );
    print(response.body);
  }

  Future<void> addToRegFavourites(String regenerationId) async {
    final response = await http.post(
      API_REG_FAVOURITE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
      body: jsonEncode(
        {
          "regenerationId": regenerationId,
        },
      ),
    );
    print(response.body);
  }


  Future<void> deleteFromRegFavourites(String regenerationId) async {
    final response = await http.delete(
      API_REG_FAVOURITE + "/$regenerationId",
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
    );
    print(response.body);
  }

  Future<void> addToRecFavourites(String receipeId) async {
    final response = await http.post(
      API_REC_FAVOURITE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
      body: jsonEncode(
        {
          "receipeId": receipeId,
        },
      ),
    );
    print("rec ${response.body}");
  }


  Future<void> deleteFromRecFavourites(String receipeId) async {
    final response = await http.delete(
      API_REC_FAVOURITE + "/$receipeId",
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
    );
    print(response.body);
  }

  Future<void> addWorkout(int day, String workoutId) async {
    final response = await http.patch(
      API_FAVOURITE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
      body: jsonEncode({"day": day, "workoutId": workoutId}),
    );
    print(response.body);
  }

  Future<void> deleteWorkout(int day, String workoutId) async {
    final response = await http.delete(
      API_FAVOURITE + "?workoutId=$workoutId&day=$day",
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
//      body: jsonEncode(
//        {
//          "workoutId": workoutId,
//        },
//      ),
    );
    print(response.body);
  }

  /// ------------------ recepie
  static Future<String> getRecepies() async {
    final response = await http.get(
      API_RECEPIE,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt
      },
    );
    return response.body;
//    return json.decode(response.body)['payload']['trainingPlan']['plan'];
  }
}
