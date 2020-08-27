import 'package:inshape/utils/parser.dart';

class Recipe {
  String id;
  List<String> goal;

  // breakfast, lunch, dinner, snack
  List<String> meals;
  String name;
  String imageUrl;
  String description;
  int cookingTime;
  String cookingTimeUnits;
  String dietType;

  // noOfPersons and portion
  List<Ingredient> ingredients;
  List<String> difficulties;
  List<Nutrition> nutrition;

  Recipe(
      {this.id,
      this.goal,
      this.meals,
      this.name,
      this.imageUrl,
      this.description,
      this.cookingTime,
      this.nutrition,
      this.cookingTimeUnits,
      this.dietType,
      this.ingredients,
      this.difficulties});

  static Recipe fromJSON(var map) {
    return Recipe(
      id: map["_id"],
      goal: DataParser.parseStringList(map["goal"]),
      meals: DataParser.parseStringList(map["meals"]),
      name: map["receipeName"],
      imageUrl: map["imageUrl"],
      description: map["description"],
      ingredients: Ingredient.parseListFromJSON(map["ingredients"]),
      cookingTime: map["cookingTIme"]["value"],
      dietType: map["dietType"],
      cookingTimeUnits: map["cookingTIme"]["unit"],
      difficulties: DataParser.parseStringList(
        map["difficultyLevel"],
      ),
      nutrition: Nutrition.parseListFromJSON(map["nutritionValue"]),
    );
  }

  static Map<String, Recipe> parseAsMap(var jsonList) {
    Map<String, Recipe> mappedList = Map();
    for (var c in jsonList) {
      final r = Recipe.fromJSON(c);
      mappedList[r.id] = r;
    }
    return mappedList;
  }
}

class Ingredient {
  String name;
  int quantity;
  String unit;

  Ingredient({this.name, this.quantity, this.unit});

  static Ingredient fromJSON(var map) {
    return Ingredient(
      name: map["name"],
      quantity: map["qty"],
      unit: map["unit"],
    );
  }

  static List<Ingredient> parseListFromJSON(var jsonList) {
    List<Ingredient> list = [];
    for (var c in jsonList) {
      list.add(Ingredient.fromJSON(c));
    }
    return list;
  }
}

class Nutrition {
  String name;
  int quantity;
  String unit;

  Nutrition({this.name, this.quantity, this.unit});

  static Nutrition fromJSON(var map) {
    return Nutrition(
      name: map["name"],
      quantity: map["qty"],
      unit: map["unit"],
    );
  }

  static List<Nutrition> parseListFromJSON(var jsonList) {
    List<Nutrition> list = [];
    for (var c in jsonList) {
      list.add(Nutrition.fromJSON(c));
    }
    return list;
  }
}
