import 'package:flutter/foundation.dart' show ChangeNotifier, compute, debugPrint;
import 'package:inshape/data_models/MusleType.dart';

class MuscleTypesProvider with ChangeNotifier {
  Map<String, MuscleType> _muscleTypes = Map();

  Future<void> pullFromJSON(var response) async {
    final muscleTypesMap = await compute(MuscleType.fromJSONList, response);
    _muscleTypes = muscleTypesMap;
    debugPrint("muscleTypesMap length: ${muscleTypesMap.length}");
    notifyListeners();
    return;
  }

  Map<String, MuscleType> get muscleTypes => _muscleTypes;

  set muscleTypes(Map<String, MuscleType> value) {
    _muscleTypes = value;
    notifyListeners();
  }
}
