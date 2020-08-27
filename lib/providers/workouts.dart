import 'package:flutter/foundation.dart' show ChangeNotifier, compute, debugPrint;
import 'package:inshape/data_models/workout.dart';
import 'package:inshape/data_models/workout_type.dart';

class WorkoutProvider with ChangeNotifier {
  Map<String, Workout> _workouts = Map();
  Map<String, WorkoutType> _workoutTypes = Map();

  pullWorkouts(List<dynamic> workouts) {
    if (workouts != null) {
      for (var w in workouts) {
        _workouts[w["_id"]] = Workout.fromJSON(w);
      }
      notifyListeners();
    }
  }

  Future<void> pullWorkoutTypesFromJSON(var jsonList) async {
    final workoutTypesMap = await compute(WorkoutType.fromJSONList, jsonList);
    _workoutTypes = workoutTypesMap;
    debugPrint("WorkoutTypes length: ${_workoutTypes.length}");
    notifyListeners();
    return;
  }

  Map<String, Workout> get workouts => _workouts;

  set workouts(Map<String, Workout> value) {
    _workouts = value;
    notifyListeners();
  }

  Map<String, WorkoutType> get workoutTypes => _workoutTypes;

  set workoutTypes(Map<String, WorkoutType> value) {
    _workoutTypes = value;
    notifyListeners();
  }
}
