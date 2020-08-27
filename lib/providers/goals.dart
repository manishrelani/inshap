import 'package:flutter/foundation.dart' show ChangeNotifier, compute, debugPrint;
import 'package:inshape/data_models/goal.dart';

class GoalsProvider with ChangeNotifier {
  Map<String, Goal> _goals = Map();

  Map<String, Goal> get goals => _goals;

  Future<void> pullFromJSON(var response) async {
    final goalsMap = await compute(Goal.getGoalsMapFromJSON, response);
    _goals = goalsMap;
    debugPrint("goalsMap length: ${goalsMap.length}");
    notifyListeners();
    return;
  }

  set goals(Map<String, Goal> value) {
    _goals = value;
    notifyListeners();
  }
}
