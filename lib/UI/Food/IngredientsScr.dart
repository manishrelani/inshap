import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Food/PreparationScr.dart';
import 'package:inshape/data_models/recipe.dart';
import 'package:inshape/providers/favourites.dart';
import 'package:inshape/providers/recepie.dart';
import 'package:inshape/providers/recipe_favourite.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

class IngredientsScr extends StatefulWidget {
  final String recepieId;
  final String foodType;

  const IngredientsScr({Key key, this.recepieId, this.foodType})
      : super(key: key);

  @override
  _IngredientsScrState createState() => _IngredientsScrState();
}

class _IngredientsScrState extends State<IngredientsScr> {
  int noOfPersons = 4;

  @override
  Widget build(BuildContext context) {
    final favouritesProvider = Provider.of<RecipeFavouritesProvider>(context);
    final recepie =
        Provider.of<RecepiesProvider>(context).recepies[widget.recepieId];
    print("reci $recepie");
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        centerTitle: true,
        elevation: 4.0,
        title: widget.foodType == null
            ? Text(() {
                switch (recepie.meals[0].toLowerCase()) {
                  case "breakfast":
                    return "Frühstück";
                    break;

                  case "lunch":
                    return "Mittagessen";
                    break;

                  case "dinner":
                    return "Abendessen";
                    break;

                  case "snack":
                    return "Snack";
                    break;
                }
              }())
            : Text(() {
                switch (widget.foodType) {
                  case "breakfast":
                    return "Frühstück";
                    break;

                  case "lunch":
                    return "Mittagessen";
                    break;

                  case "dinner":
                    return "Abendessen";
                    break;

                  case "snack":
                    return "Snack";
                    break;
                }
              }()),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFC8C8C8),
            size: size.height * .035,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.transparent,
            icon: Icon(
              favouritesProvider.recFavourites.contains(widget.recepieId)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: AppColors.green,
              size: size.height * .035,
            ),
            onPressed: () {
              favouritesProvider.addOrRemoveFromFoodFavourite(widget.recepieId);
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            //Image
            Container(
              height: size.height * .25,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: recepie.imageUrl != null
                      ? CachedNetworkImageProvider(recepie.imageUrl)
                      : CachedNetworkImageProvider(
                          "https://images.unsplash.com/photo-1543353071-873f17a7a088?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(.01),
                      Colors.black.withOpacity(.3),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 16),
                  child: Text(
                    "${recepie.name}",
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Divider(
              color: AppColors.green,
              thickness: 1.5,
              height: 8.0,
            ),

            SizedBox(height: 16.0),

            Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[]
                  ..addAll(nutritionWidget(recepie.nutrition, size))
                /*  foodSpecs("Carbohydrates", recepie.carbohydrate * noOfPersons),
                foodSpecs("Protein", recepie.protein * noOfPersons),
                foodSpecs("Fat", recepie.fat * noOfPersons), */
                ),

            SizedBox(
              height: 8.0,
            ),

            //Second Row of Buttons Started Here
            _getSecondRow(recepie, size),

            //Ingriedients List Started here
            Container(
              margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              height: 50.0,
              width: double.infinity,
              child: Neumorphic(
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Zutaten für $noOfPersons Portionen",
                    style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 16.0),
                  ),
                ),
                style: NeumorphicStyle(
                    color: Color(0xFF16162B),
                    depth: 4,
                    shadowLightColor: Color(0xFF2B2B41),
                    shadowDarkColor: Color(0xFF0A0A14)),
              ),
            ),

            Neumorphic(
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              padding: const EdgeInsets.all(16.0),
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              style: NeumorphicStyle(
                depth: -5,
                color: Color(0xFF16162B),
                shadowDarkColor: Color(0xFF0A0A14),
                shadowDarkColorEmboss: Color(0xFF0A0A14),
                shadowLightColorEmboss: AppColors.shadowLightColor,
              ),
              child:
                  //Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[]
                  //     ..addAll(ingredientWidgets(recepie.ingredients)),
                  // ),
                  Container(
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[]
                    ..addAll(ingredientWidgets(recepie.ingredients, size)),
                ),
              ),
            ),

            //Final Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreparationScr(
                      noOfPersons: noOfPersons,
                      recepieId: widget.recepieId,
                      foodType: widget.foodType,
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.only(
                  left: size.width * .06,
                  right: size.width * .06,
                ),
                margin: EdgeInsets.only(top: 18),
                width: double.infinity,
                height: size.height * .065,
                child: button(
                  "Kochen",
                  AppColors.green,
                ),
              ),
            ),
            SizedBox(
              height: 69,
            )
          ],
        ),
      ),
    );
  }

  Iterable<Widget> nutritionWidget(List<Nutrition> nutrition, Size size) {
    final children = List.of(nutrition).map(
      (e) => foodSpecs(e.name, e.quantity * noOfPersons, size),
    );
    return children;
  }

  Iterable<Widget> ingredientWidgets(List<Ingredient> ingredients, Size size) {
    final children = List.of(ingredients).map(
      (e) => Container(
        margin: EdgeInsets.only(
          top: size.height * .018,
          bottom: size.height * .018,
        ),
        child: Text(
          '${e.quantity * noOfPersons} ${e.unit}  ${e.name}',
          style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 16.0),
        ),
      ),
    );
    return children;
  }

  Widget _getSecondRow(Recipe recepie, Size size) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: <Widget>[
          customSpecsField(
              "${recepie.cookingTime * noOfPersons} ", " Minuten", size),
          customSpecsField("", "${recepie.difficulties[0]}", size),
          SizedBox(width: 8.0),
          SizedBox(
            height: size.height * .07,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Neumorphic(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
                  style: NeumorphicStyle(
                    depth: -5,
                    color: Color(0xFF16162B),
                    shadowDarkColor: Color(0xFF0A0A14),
                    shadowDarkColorEmboss: Color(0xFF0A0A14),
                    shadowLightColorEmboss: AppColors.shadowLightColor,
                  ),
                  child: Container(
                    height: size.height * .06,
                    width: size.width * .09,
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                          iconSize: 0,
                          style: TextStyle(
                            color: AppColors.green,
                            fontSize: 14.0,
                          ),
                          value: noOfPersons,
                          items: [
                            DropdownMenuItem(
                              child: Text('1'),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text('2'),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text('3'),
                              value: 3,
                            ),
                            DropdownMenuItem(
                              child: Text('4'),
                              value: 4,
                            ),
                          ],
                          onChanged: (int value) {
                            print(value);
                            setState(() {
                              noOfPersons = value;
                            });
                          }),
                    ),
                  ),
                ),
                Neumorphic(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(6)),
                  style: NeumorphicStyle(
                      color: Color(0xFF16162B),
                      depth: 4,
                      shadowLightColor: Color(0xFF2B2B41),
                      shadowDarkColor: Color(0xFF0A0A14)),
                  child: SizedBox(
                    height: size.height * .06,
                    width: size.width * .28,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "   Personen ",
                          style:
                              TextStyle(color: Color(0xFFC8C8C8), fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              noOfPersons = 4;
                            });
                          },
                          child: Icon(
                            Icons.refresh,
                            color: AppColors.green,
                          ),
                        ),
                        SizedBox(width: 8.0)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );

  Widget foodSpecs(String spec, dynamic value, Size size) {
    return Container(
      height: size.height * .12,
      width: size.width * .25,
      child: Neumorphic(
        style: NeumorphicStyle(
          color: Color(0xFF16162B),
          depth: 4,
          shadowLightColor: Color(0xFF2B2B41),
          shadowDarkColor: Color(0xFF0A0A14),
        ),
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        margin: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("${value.toString()}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.green, fontSize: 16)),
              SizedBox(height: 4.0),
              /* Text(
                spec,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 12),
              ) */
              Text(
                () {
                  switch (spec.toLowerCase()) {
                    case "calories":
                      return "Kalorien";
                      break;

                    case "protein":
                      return "Eiweiß";
                      break;

                    case "carbohydrate":
                      return "Kohlenhydrate";
                      break;

                    case "fat":
                      return "Fett";
                      break;

                    default: 
                    return "error";
                    break;  
                  }
                }(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFFC8C8C8),
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //button
  Widget button(txt, color) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(color: AppColors.green, fontSize: 18),
        ),
      ),
      style: NeumorphicStyle(
          color: Color(0xFF16162B),
          depth: 4,
          shadowLightColor: Color(0xFF2B2B41),
          shadowDarkColor: Color(0xFF0A0A14)),
    );
  }

  //button widget for second row
  Widget customSpecsField(String txt1, String txt2, Size size,
      [Widget child, double depth]) {
    return Container(
      height: size.height * .06,
      width: size.width * .28,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Neumorphic(
          style: NeumorphicStyle(
            color: Color(0xFF16162B),
            depth: depth ?? 4,
            shadowLightColor: Color(0xFF2B2B41),
            shadowDarkColor: Color(0xFF0A0A14),
          ),
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(8.0),
          ),
          // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          margin: EdgeInsets.only(left: size.width * .03),
          child: child ??
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: constraints.maxWidth * .07,
                    ),
                    child: Text(
                      txt1,
                      style: TextStyle(color: AppColors.green, fontSize: 16),
                    ),
                  ),
                  //SizedBox(height: 4.0),
                  Container(
                    //color: Colors.red,
                    width: constraints.maxWidth * .46,
                    child: Text(txt2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: Color(0xFFC8C8C8), fontSize: 11)),
                  )
                ],
              ),
        );
      }),
    );
  }
}
