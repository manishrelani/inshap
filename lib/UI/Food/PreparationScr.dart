import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/providers/recepie.dart';
import 'package:inshape/providers/recipe_favourite.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/toast.dart';
import 'package:provider/provider.dart';

class PreparationScr extends StatefulWidget {
  final int noOfPersons;
  final String recepieId;
  final String foodType;

  const PreparationScr(
      {Key key, this.noOfPersons, this.recepieId, this.foodType})
      : super(key: key);

  @override
  _PreparationScrState createState() => _PreparationScrState();
}

class _PreparationScrState extends State<PreparationScr> {
  @override
  Widget build(BuildContext context) {
    final favouritesProvider = Provider.of<RecipeFavouritesProvider>(context);
    final recepie =
        Provider.of<RecepiesProvider>(context).recepies[widget.recepieId];

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
        title: Center(
          child: widget.foodType == null
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
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            // AppBar

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
                  padding: EdgeInsets.only(left: 8.0, top: 8),
                  child: Text(
                    "${recepie.name}",
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * .03),
              height: 1,
              color: AppColors.green,
            ),

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
                    "Zutaten für ${widget.noOfPersons} Portionen",
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

            //TextArea for ingreadients of food Starts Here
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
              child: Container(
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[]..addAll(
                      List.of(recepie.ingredients).map(
                        (e) => Container(
                          margin: EdgeInsets.only(
                              top: size.height * .018,
                              bottom: size.height * .018),
                          child: Text(
                            '${e.quantity * widget.noOfPersons} ${e.unit}  ${e.name}',
                            style: TextStyle(
                                color: Color(0xFFC8C8C8), fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                ),
              ),
            ),

            //Text Bellow the ingredients of food
            Container(
              margin: EdgeInsets.only(
                  top: size.height * .04,
                  left: size.width * .06,
                  right: size.width * .06,
                  bottom: size.height * .06),
              child: Text(
                "${recepie.description}",
                style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),

            //Final Button
            GestureDetector(
              onTap: () {
                AppToast.show("Done cooking");
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
                  "Fertig",
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
}
