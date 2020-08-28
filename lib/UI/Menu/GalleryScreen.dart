import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inshape/UI/Menu/ProfileScreen.dart';
import 'package:inshape/UI/Menu/SelectImage.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/Widget/bottom_navigation.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  Widget customLongCard(var topImage) {
    return Stack(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width / 2 - 25,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF74747C).withOpacity(0.2),
                  offset: Offset(-6.0, -6.0),
                  blurRadius: 16.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(6.0, 6.0),
                  blurRadius: 16.0,
                ),
              ],
              borderRadius: BorderRadius.circular(12.0),
              color: Color(0xFF16162B),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  imageUrl: topImage,
                  fit: BoxFit.cover,
                ))),
        Container(
          height: MediaQuery.of(context).size.height * 0.40,
          width: MediaQuery.of(context).size.width / 2 - 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.black38,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width / 2 - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            //TODO add date
            child: Text(
              "",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ),
        )
      ],
    );
  }

  /* var gallery;

  @override
  void initState() {
    super.initState();
    setState(() {
      
      print(gallery);
    });
  } */

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false);
    final gallery =
        Provider.of<ProfileProvider>(context, listen: false).profile.gallery;
    print(gallery.length);
    var totalHeight = MediaQuery.of(context).size.height;
    var totalWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => _onWillPop(),
      child: SafeArea(
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
                  "Gallerie",
                  textAlign: TextAlign.center,
                  style: ThemeText.titleText,
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: AppColors.green,
                        size: 26.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectImage()));
                      }),
                ],
              ),
              body: gallery.length <= 0
                  ? Center(
                      child: Text(
                        "No Image Found",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: ListView(
                        children: <Widget>[
                          gallery.length <= 1
                              ? Row(
                                  children: <Widget>[
                                    customLongCard(gallery[0]),
                                    Spacer(),
                                    Container()
                                  ],
                                )
                              : Container(),
                          gallery.length >= 2
                              ? Row(
                                  children: <Widget>[
                                    customLongCard(gallery[0]),
                                    Spacer(),
                                    customLongCard(gallery[1]),
                                  ],
                                )
                              : Container(),
                          gallery.length <= 2
                              ? Container()
                              : GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  children: List.generate(gallery.length - 2,
                                      (index) {
                                    return Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: totalHeight * 0.40,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                40,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xFF3A3A5E)
                                                      .withOpacity(0.4),
                                                  offset: Offset(-6.0, -6.0),
                                                  blurRadius: 16.0,
                                                ),
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  offset: Offset(6.0, 6.0),
                                                  blurRadius: 16.0,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Color(0xFF16162B),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              child: CachedNetworkImage(
                                                imageUrl: gallery[index + 2],
                                                width: totalWidth / 2 - 25,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: totalHeight * 0.40,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: totalHeight * 0.40,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${index + 1}.  ",
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                                ),
                        ],
                      ),
                    ),
              bottomNavigationBar: BottomNav(index: 4))),
    );
  }

  //Handle Back Button
  Future<bool> _onWillPop() async {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ProfileScreen()));
  }
}
