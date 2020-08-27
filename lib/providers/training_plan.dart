import 'dart:convert';

import 'package:flutter/foundation.dart' show compute, ChangeNotifier;
import 'package:inshape/Backend/ApiData.dart';
import 'package:inshape/data_models/training_plan.dart';
import 'package:inshape/data_models/workout.dart';
import 'package:inshape/utils/toast.dart';

class TrainingPlansProvider with ChangeNotifier {
  TrainingPlansProvider() {
    getRecommendedPlans();
  }

  String _recommendedPlan;

  Map<String, TrainingPlan> _trainingPlans = Map();
  int _currentDay = 1;

  void getRecommendedPlans() async {
    if (_trainingPlans.length < 1) {
      print("fetching training plans");
      forceGetRecommendedPlans();
    }
  }

  swapDays(int src, int target, String trainingPlanId) {
    List<Plan> srcArr = _trainingPlans[trainingPlanId].plans[src];
    List<Plan> tarArr = _trainingPlans[trainingPlanId].plans[target];
    _trainingPlans[trainingPlanId].plans[target] = srcArr;
    _trainingPlans[trainingPlanId].plans[src] = tarArr;
    notifyListeners();
  }

  void forceGetRecommendedPlans() async {
    final String response = await ApiData.getTrainingPlans(); // payload map
    _recommendedPlan = json.decode(response)['payload']['recommendedPlan'];
//    print(response);
    final map = await compute(TrainingPlan.parseJSONAsMap, response);
    _trainingPlans.addAll(map);
    print("Training Plans: ${_trainingPlans.length}");
//      print(_recommendedPlan);
//      print(_trainingPlans[_recommendedPlan]);
    notifyListeners();
  }

  ApiData apiData = ApiData();

  addThisWorkoutId(
      String trainingId, int day, Workout workout, bool addPermanently) {
    _trainingPlans[trainingId].plans[day].add(
          Plan(
              name: workout.name,
              thumbnailUrl: workout.thumbnailUrl,
              workouts: [WorkoutId(workoutId: workout.id)],
              day: day),
        );
    apiData.addWorkout(day, workout.id);
    AppToast.show("Added ${workout.name} to today\'s workout");
    notifyListeners();
  }

  Map<String, TrainingPlan> get trainingPlans => _trainingPlans;

  set trainingPlans(Map<String, TrainingPlan> value) {
    _trainingPlans = value;
    notifyListeners();
  }

  int get currentDay => _currentDay;

  set currentDay(int value) {
    _currentDay = value;
    notifyListeners();
  }

  String get recommendedPlan => _recommendedPlan;

  set recommendedPlan(String value) {
    _recommendedPlan = value;
    notifyListeners();
  }
}
