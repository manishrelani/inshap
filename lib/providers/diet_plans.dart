import 'package:flutter/foundation.dart' show ChangeNotifier, compute, debugPrint;
import 'package:inshape/data_models/diet_plans.dart';

class DietPlansProvider with ChangeNotifier {
  Map<String, DietPlan> _dietPlans = Map();

  Future<void> pullFromJSON(var response) async {
    final dietPlansMap = await compute(DietPlan.fromJSONList, response);
    _dietPlans = dietPlansMap;
    debugPrint("dietPlansMap length: ${dietPlansMap.length}");
    notifyListeners();
    return;
  }

  Map<String, DietPlan> get dietPlans => _dietPlans;

  set dietPlans(Map<String, DietPlan> value) {
    _dietPlans = value;
    notifyListeners();
  }
}
