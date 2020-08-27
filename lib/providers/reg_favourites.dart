import 'dart:convert';

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:inshape/Backend/ApiData.dart';

class RegenerationFavouritesProvider with ChangeNotifier {
  List<String> _regFavourites = [];

  final ApiData apiData = ApiData();

  RegenerationFavouritesProvider() {
    _getFavourites();
  }

  addOrRemoveFromRegFavourite(String regenerationId) {
    if (_regFavourites.contains(regenerationId)) {
      apiData.deleteFromRegFavourites(regenerationId);
      _regFavourites.remove(regenerationId);
    } else {
      apiData.addToRegFavourites(regenerationId);
      _regFavourites.add(regenerationId);
    }
    notifyListeners();
  }

  List<String> get regFavourites => _regFavourites;

  set regFavourites(List<String> value) {
    _regFavourites = value;
    notifyListeners();
  }

  Future<void> _getFavourites() async {
    if (regFavourites.length == 0) {
      String response = await ApiData.regFavourites();
//      print("Favourites: ${response}");
      final jsonDecoded = json.decode(response)["payload"]["favorites"];
      for (var w in jsonDecoded) {
        _regFavourites.add(w['regenerationId']);
      }
      print("ok $_regFavourites");
      notifyListeners();
    }
  }
}
