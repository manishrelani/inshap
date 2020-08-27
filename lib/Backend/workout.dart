import 'dart:convert';

import 'package:http/http.dart';
import 'package:inshape/Backend/urls.dart';
import 'package:inshape/providers/session.dart';

class WorkoutsAPI {
  static Future<List<dynamic>> getWorkoutData() async {
    print(SessionProvider.jwt);
    final response = await get(
      API_WORKOUT,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
    print("Fetch workouts: ${response.statusCode}");
    return json.decode(response.body)['payload']['workouts'];
  }

  static Future<List<dynamic>> getWorkOutWithParams(
  {String workoutType, List muscle}) async {
    String url = '$API_WORKOUT/?type=$workoutType';
    for (var mus in muscle) url += '&muscles[]=$mus';

    print("Work: $workoutType");
    print("Muscle: $muscle");

    final response = await get(
      url,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
      },
    );
//    print(json.decode(response.body));
    return json.decode(response.body)['payload']['workouts'];
  }
}
