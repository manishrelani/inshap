import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Food/IngredientsScr.dart';
import 'package:inshape/Widget/bottom_navigation.dart';
import 'package:inshape/data_models/recipe.dart';
import 'package:inshape/providers/recepie.dart';
import 'package:inshape/providers/recipe_favourite.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

class FavdietScr extends StatefulWidget {
  @override
  _FavdietScrState createState() => _FavdietScrState();
}

class _FavdietScrState extends State<FavdietScr> {
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    final recepies = Provider.of<RecepiesProvider>(context).recepies;
    final favouritesProvider = Provider.of<RecipeFavouritesProvider>(context)
        .recFavourites
        .where((element) {
      if (element != null)
        return recepies[element].name.toLowerCase().contains(searchText);
      else
        return false;
    }).toList();

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNav(
          index: 2,
        ),
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
            "Favourites",
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 50.0),
            child: Container(
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
                    searchText = value;
                  });
                },
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.primaryBackground,
        body: favouritesProvider.isEmpty
            ? Center(
                child: Text(
                "Your favourite list is empty",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ))
            : ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: favouritesProvider.length,
                itemBuilder: (context, index) {
                  return FoodRecepieWidgetFavScreen(
                    recipe: recepies[favouritesProvider[index]],
                  );
                },
              ),
      ),
    );
  }
}

class FoodRecepieWidgetFavScreen extends StatelessWidget {
  final Recipe recipe;

  const FoodRecepieWidgetFavScreen({Key key, this.recipe}) : super(key: key);

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
              //  foodType: foodType.value(),
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
                          // color: Colors.red,
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
                        favouritesProvider.addOrRemoveFromFoodFavourite(recipe.id);
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

  void remove(BuildContext context, String recepieId) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Zu dem Workout hinzufugen?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 8.0),
            Text('Willst du dein Workout Plan wirklich bearbeiten?'),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Zurucksetzen'),
            onPressed: () {
              Provider.of<RecipeFavouritesProvider>(context, listen: false)
                  .addOrRemoveFromFoodFavourite(recepieId);
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('Ubernehmen'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
