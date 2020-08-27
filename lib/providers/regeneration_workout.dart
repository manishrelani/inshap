import 'dart:convert';

import 'package:flutter/foundation.dart' show ChangeNotifier, compute;
import 'package:inshape/Backend/ApiData.dart';
import 'package:inshape/data_models/regenerationWorkout.dart';

class RegenerationWoroutProvider with ChangeNotifier {
  final name;
  RegenerationWoroutProvider({this.name}) {
    pullFromJSON();
  }

  Map<String, RegenerationWorkout> _regType = Map();

  Map<String, RegenerationWorkout> get regeneration => _regType;

  Future<void> pullFromJSON() async {
  
    final response = await ApiData.getRegenerationWorout(name); 
    final data = json.decode(response)['payload']['allRegenerations'];
    final regeneration = await compute(RegenerationWorkout.fromJSONList, data);
    _regType = regeneration;
    print("RegenerationWorout length: ${_regType.length}");
    notifyListeners();
  }

  set regeneration(Map<String, RegenerationWorkout> value) {
    _regType = value;
    notifyListeners();
  }
}
