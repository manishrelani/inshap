import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Regeneration/FavouriteRegenScr.dart';
import 'package:inshape/Widget/bottom_navigation.dart';
import 'package:inshape/Widget/shimmer.dart';
import 'package:inshape/providers/reg_favourites.dart';
import 'package:inshape/providers/regeneration_workout.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

import 'ExerciseScr.dart';

class ProgramScreen extends StatelessWidget {
  final name;
  ProgramScreen({this.name});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return RegenerationWoroutProvider(name: name);
      },
      child: ProgrammesScr(),
    );
  }
}

class ProgrammesScr extends StatefulWidget {
  @override
  _ProgrammesScrState createState() => _ProgrammesScrState();
}

class _ProgrammesScrState extends State<ProgrammesScr> {
  // List userFavorites = getFavoritesIDs();

  Timer _timer;
  int _start = 4;
  bool isLoading = false;
  String searchText = "";

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          setState(() {
            if (_start < 1) {
              print("_start : $_start");
              isLoading = true;
              print("set");
              timer.cancel();
            } else {
              print("_start : $_start");
              _start = _start - 1;
            }
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final rege = Provider.of<RegenerationWoroutProvider>(context).regeneration;
    final regeneration = rege.values.where((element) {
      return element.regName.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    final favouritesProvider =
        Provider.of<RegenerationFavouritesProvider>(context);

    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Vorgegebene Pakete",
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: AppColors.green,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => FavouriteRegenScr(rege)));
                })
          ],
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
        body: isLoading == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: regeneration.length == 0
                    ? Center(
                        child: Text(
                          "Data Not Found",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: regeneration.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ExerciseScr(regeneration[index]),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: size.height * .015,
                                  left: size.width * .03,
                                  right: size.width * .02,
                                ),
                                height: size.height * .125,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  // color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: constraint.maxHeight * 1,
                                              width: constraint.maxWidth * .2,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: regeneration[index]
                                                      .imgUrl,
                                                  placeholder: (context, url) =>
                                                      AppShimmer(
                                                    height:
                                                        constraint.maxHeight *
                                                            1,
                                                    width: constraint.maxWidth *
                                                        .2,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.network(
                                                    "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  regeneration[index].regName,
                                                  style: TextStyle(
                                                      color: Color(0xFFE0E0E0),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Container(
                                                  height:
                                                      constraint.maxHeight * .7,
                                                  width:
                                                      constraint.maxWidth * .55,
                                                  child: Text(
                                                    regeneration[index]
                                                        .sortDescription,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                                child: Icon(
                                                  favouritesProvider
                                                          .regFavourites
                                                          .contains(
                                                              regeneration[
                                                                      index]
                                                                  .id)
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: AppColors.green,
                                                  size: 24.0,
                                                ),
                                                onTap: () {
                                                  print("Hello");
                                                  print(regeneration[index].id);
                                                  favouritesProvider.addOrRemoveFromRegFavourite(regeneration[index].id);
                                                })
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
                          },
                        ),
                      ),
              ),
        bottomNavigationBar: BottomNav(index: 3));
  }
}
