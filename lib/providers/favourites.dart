import 'dart:convert';

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:inshape/Backend/ApiData.dart';
import 'package:inshape/data_models/workout.dart';

class FavouritesProvider with ChangeNotifier {
  List<String> _fitnessFavourites = [];

  //List<String> _foodFavourites = [];

  final ApiData apiData = ApiData();

  FavouritesProvider() {
    _getFavourites();
   // _getRecFavourites();
  }

  List<String> _excludedWorkoutIds = [];

  addOrRemoveFromFavourite(String workoutId, Workout value) {
    if (_fitnessFavourites.contains(workoutId)) {
      apiData.deleteFromFavourites(workoutId);
      _fitnessFavourites.remove(workoutId);
    } else {
      apiData.addToFavourites(workoutId);
      _fitnessFavourites.add(workoutId);
    }
    notifyListeners();
  }

  // todo: add api
  /* addOrRemoveFromFoodFavourite(String recepieId) {
    if (_foodFavourites.contains(recepieId)) {
      apiData.deleteFromRecFavourites(recepieId);
      _foodFavourites.remove(recepieId);
    } else {
      apiData.addToRecFavourites(recepieId);
      _foodFavourites.add(recepieId);
    }
    notifyListeners();
  } */

  excludeAWorkout(int day, String workoutId, bool removePermanently) {
    _excludedWorkoutIds.add(workoutId);
    apiData.deleteWorkout(day, workoutId);
    notifyListeners();
  }

  List<String> get excludedWorkoutIds => _excludedWorkoutIds;

  set excludedWorkoutIds(List<String> value) {
    _excludedWorkoutIds = value;
    notifyListeners();
  }

  Future<void> _getFavourites() async {
    if (fitnessFavourites.length == 0) {
      String response = await ApiData.favourites();
//      print("Favourites: ${response}");
      final jsonDecoded = json.decode(response)["payload"]["favorites"];
      for (var w in jsonDecoded) {
        _fitnessFavourites.add(w['workoutId']);
      }
      notifyListeners();
    }
  }

 /*  Future<void> _getRecFavourites() async {
    if (foodFavourites.length == 0) {
      String response = await ApiData.recFavourites();
      print("Favourites: ${response}");
      final jsonDecoded = json.decode(response)["payload"]["favorites"];
      for (var w in jsonDecoded) {
        _foodFavourites.add(w['receipeId']);
      }
      notifyListeners();
    }
  } */

  List<String> get fitnessFavourites => _fitnessFavourites;

  set fitnessFavourites(List<String> value) {
    _fitnessFavourites = value;
    notifyListeners();
  }

 /*  List<String> get foodFavourites => _foodFavourites;

  set foodFavourites(List<String> value) {
    _foodFavourites = value;
    notifyListeners();
  } */
}
