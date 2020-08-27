import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Food/FavdietScr.dart';
import 'package:inshape/UI/Food/RecipesScr.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Widget/bottom_navigation.dart';
import 'package:inshape/data_models/recipe.dart';
import 'package:inshape/utils/colors.dart';

class RecipesTabs extends StatefulWidget {
  final List<String> selectedDietPlans;
  final List<String> selectedDietPlansIds;
  final String goalType;

  const RecipesTabs(
      {Key key,
      this.selectedDietPlans,
      this.selectedDietPlansIds,
      this.goalType})
      : super(key: key);

  @override
  _RecipesTabsState createState() => _RecipesTabsState();
}

class _RecipesTabsState extends State<RecipesTabs>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;
  int index;
  String serachText = "";
  Recipe recipe = Recipe();

  @override
  void initState() {
    print("diet: ${widget.selectedDietPlans}");
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Tab(
        child: newTextButton("Frühstück", index == 0),
      ),
      Tab(
        child: newTextButton("Mittagessen", index == 1),
      ),
      Tab(
        child: newTextButton("Abendessen", index == 2),
      ),
      Tab(
        child: newTextButton("Snack", index == 3),
      ),
    ];

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  print("Pop Button Press");
                  Navigator.pop(context);
                }),
            title: Text(
              "Rezepte",
              textAlign: TextAlign.center,
              style: ThemeText.titleText,
            ),
            actions: <Widget>[
              IconButton(
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.favorite_border,
                  color: AppColors.green,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavdietScr(),
                    ),
                  );
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 90.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TabBar(
                    // physics: NeverScrollableScrollPhysics(),
                    indicatorColor: AppColors.primaryBackground,
                    labelColor: Colors.white,
                    isScrollable: true,
                    unselectedLabelColor: Colors.white,
                    indicatorPadding: EdgeInsets.all(0.0),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.75,
                    ),
                    unselectedLabelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      letterSpacing: 0.75,
                      fontWeight: FontWeight.w400,
                    ),
                    onTap: (int value) {
                      setState(() {
                        index = value;
                      });
                    },
                    tabs: tabs,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 8.0,
                    ),
                    height: 45.0,
                    child: TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF333448),
                        contentPadding: const EdgeInsets.all(0.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFFFFFFFF),
                          size: 32.0,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          serachText = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              RecipesScr(
                selectedDietPlanIds: widget.selectedDietPlansIds,
                selectedDietPlans: widget.selectedDietPlans,
                goalType: widget.goalType,
                foodType: FoodType.Breakfast,
                searchText:serachText,
              ),
              RecipesScr(
                selectedDietPlanIds: widget.selectedDietPlansIds,
                selectedDietPlans: widget.selectedDietPlans,
                goalType: widget.goalType,
                foodType: FoodType.Lunch,
                searchText:serachText,
              ),
              RecipesScr(
                selectedDietPlanIds: widget.selectedDietPlansIds,
                selectedDietPlans: widget.selectedDietPlans,
                goalType: widget.goalType,
                foodType: FoodType.Dinner,
                searchText:serachText,
              ),
              RecipesScr(
                selectedDietPlanIds: widget.selectedDietPlansIds,
                selectedDietPlans: widget.selectedDietPlans,
                goalType: widget.goalType,
                foodType: FoodType.Snack,
                searchText:serachText,
              ),
            ],
          ),
          /* : Center(
                  child: Text(
                  "Recipes not availbe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
                )), */
          bottomNavigationBar: BottomNav(
            index: 2,
          )),
    );
  }

  Widget newTextButton(String txt, bool mode) {
    return Neumorphic(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(0),
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(8),
      ),
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: mode ? AppColors.green : Color(0xFFC8C8C8),
        ),
      ),
      style: mode
          ? NeumorphicStyle(
              color: Color(0xFF16162B),
              depth: -7.0,
              shadowDarkColor: Color(0xFF0A0A14),
              shadowDarkColorEmboss: Color(0xFF0A0A14),
              shadowLightColorEmboss: AppColors.shadowLightColor,
            )
          : NeumorphicStyle(
              color: Color(0xFF16162B),
              depth: 4,
              shadowLightColor: Color(0xFF2B2B41),
              shadowDarkColor: Color(0xFF0A0A14)),
    );
  }
}
