import 'dart:convert';

import 'package:flutter/foundation.dart'
    show ChangeNotifier, compute;
import 'package:inshape/Backend/ApiData.dart';
import 'package:inshape/data_models/regenerationType.dart';

class RegenerationTypeProvider with ChangeNotifier {
  Map<String, RegenerationType> _regType = Map();
  RegenerationTypeProvider() {
    pullFromJSON();
  }

  Map<String, RegenerationType> get regenerationType => _regType;

 void pullFromJSON() async {
    print("in");
    final response = await ApiData.getRegenerationType();
    final data = json.decode(response)['payload']['allRegenerationTypes'];
    final regenerationType = await compute(RegenerationType.fromJSONList, data);
    _regType = regenerationType;
    print("regenerationType length: ${_regType.length}");
    notifyListeners();
    
  }

  set regenerationType(Map<String, RegenerationType> value) {
    _regType = value;
    notifyListeners();
  }
}
