import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:inshape/Backend/ApiData.dart';
import 'package:inshape/data_models/recipe.dart';

class RecepiesProvider with ChangeNotifier {
  Map<String, Recipe> _recepies = Map();

  RecepiesProvider() {
    fetchRecepies();
  }

  fetchRecepies() async {
    print("fetching recepies");
    final response = await ApiData.getRecepies();
//    print(response);
    final res =
        await compute(Recipe.parseAsMap, json.decode(response)["payload"]["allReceipes"]);
    _recepies.addAll(res);
    notifyListeners();
    print("Recipes length: ${_recepies.length}");
  }

  Map<String, Recipe> get recepies => _recepies;

  set recepies(Map<String, Recipe> value) {
    _recepies = value;
    notifyListeners();
  }
}
