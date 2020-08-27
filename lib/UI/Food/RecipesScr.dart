import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Food/IngredientsScr.dart';
import 'package:inshape/data_models/recipe.dart';
import 'package:inshape/providers/recepie.dart';
import 'package:inshape/providers/recipe_favourite.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

enum FoodType { Breakfast, Lunch, Dinner, Snack }

extension FTExtension on FoodType {
  String value() {
    return this.toString().substring(9).toLowerCase();
  }

  String sentenceCase() {
    return this.toString().substring(9);
  }
}

//class RecipesScr extends StatefulWidget {
class RecipesScr extends StatelessWidget {
  // food types - Mixed, Vegetarian, Vegan....
  final List<String> selectedDietPlans;
  final List<String> selectedDietPlanIds;
  final FoodType foodType;
  final String goalType;
  final String searchText;

  const RecipesScr(
      {Key key,
      this.selectedDietPlans,
      this.foodType,
      this.selectedDietPlanIds,
      this.goalType,
      this.searchText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recepies =
        Provider.of<RecepiesProvider>(context).recepies.values.where((recipe) {
      return recipe.goal.contains(goalType) &&
          selectedDietPlans.contains(recipe.dietType) &&
          recipe.meals.contains(foodType.value()) &&
          recipe.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    return SafeArea(
      child: recepies.length == 0
          ? Center(
              child: Text(
              "Recipes not available",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
              ),
            ))
          : ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: recepies.length,
              itemBuilder: (context, index) {
                return FoodRecepieWidget(
                  recipe: recepies[index],
                  foodType: foodType,
                );
              },
            ),
    );
  }
}

class FoodRecepieWidget extends StatelessWidget {
  final Recipe recipe;
  final FoodType foodType;

  const FoodRecepieWidget({Key key, this.recipe, this.foodType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favouritesProvider = Provider.of<RecipeFavouritesProvider>(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IngredientsScr(
              foodType: foodType.value(),
              recepieId: recipe.id,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: size.height * .015,
          left: size.width * .03,
          right: size.width * .02,
        ),
        height: 100,
        child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * .015,
              bottom: size.height * .015,
            ),
            child: LayoutBuilder(
              builder: (ctx, constraint) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15)),
                      height: constraint.maxHeight * 1,
                      width: constraint.maxWidth * .2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          recipe.imageUrl ??
                              "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: constraint.maxHeight * 1,
                      width: constraint.maxWidth * .55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${recipe.name}",
                            style: TextStyle(
                                color: Color(0xFFE0E0E0),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                          ),
                          Text(
                            "${recipe.description}",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        favouritesProvider
                            .addOrRemoveFromFoodFavourite(recipe.id);
                      },
                      child: Icon(
                        favouritesProvider.recFavourites.contains(recipe.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: AppColors.green,
                        size: 24.0,
                      ),
                    )
                  ],
                );
              },
            ),
          ), //Text("data",style: TextStyle(color: Colors.white),),
          style: NeumorphicStyle(
              color: Color(0xFF181818),
              depth: 1.5,
              shadowLightColor: Color(0xFF707070),
              shadowDarkColor: Colors.black),
        ),
      ),
    );
  }
}
