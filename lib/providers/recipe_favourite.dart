import 'dart:convert';

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:inshape/Backend/ApiData.dart';

class RecipeFavouritesProvider with ChangeNotifier {
  List<String> _recFavourites = [];

  final ApiData apiData = ApiData();

  RecipeFavouritesProvider() {
    _getFavourites();
  }

  addOrRemoveFromFoodFavourite(String recepieId) {
    if (_recFavourites.contains(recepieId)) {
      apiData.deleteFromRecFavourites(recepieId);
      _recFavourites.remove(recepieId);
    } else {
      apiData.addToRecFavourites(recepieId);
      _recFavourites.add(recepieId);
    }
    notifyListeners();
  }

  List<String> get recFavourites => _recFavourites;

  set recFavourites(List<String> value) {
    _recFavourites = value;
    notifyListeners();
  }

  Future<void> _getFavourites() async {
    if (recFavourites.length == 0) {
      String response = await ApiData.recFavourites();
//      print("Favourites: ${response}");
      final jsonDecoded = json.decode(response)["payload"]["favorites"];
      for (var w in jsonDecoded) {
        _recFavourites.add(w['receipeId']);
      }
      print("ok $_recFavourites");
      notifyListeners();
    }
  }
}
