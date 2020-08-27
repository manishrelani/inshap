import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Food/DietScreen.dart';
import 'package:inshape/utils/colors.dart';

class FinalDishScr extends StatefulWidget {
  @override
  _FinalDishScrState createState() => _FinalDishScrState();
}

class _FinalDishScrState extends State<FinalDishScr> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            // AppBar
            ListTile(
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
                child: Text(
                  "Frühstück",
                  style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 18),
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color:AppColors.green,
                  size: size.height * .035,
                ),
                onPressed: () {},
              ),
            ),

            //Image
            Container(
              height: size.height * .25,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1556191041-c2401936d851?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=662&q=80"),
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
                    "Beeren Minz Quark mit Mandeln",
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * .03),
              height: 1,
              color: Color(0xFF00F421),
            ),

            Container(
              margin: EdgeInsets.only(
                  left: size.width * .05,
                  right: size.width * .05,
                  top: size.height * .02),
              height: size.height * .06,
              width: double.infinity,
              child: Neumorphic(
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Text(
                    "Zutaten für 2 Portionen",
                    style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 13),
                  ),
                  trailing: IconButton(
                      padding: EdgeInsets.only(bottom: 5),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF00F120),
                        size: size.height * .05,
                      ),
                      onPressed: () {}),
                ),
                style: NeumorphicStyle(
                    color: Color(0xFF16162B),
                    depth: 2,
                    shadowLightColor: Color(0xFF707070),
                    shadowDarkColor: Colors.black),
              ),
            ),
           

            //Text Bellow the ingredients of food
            Container(
              margin: EdgeInsets.only(
                  top: size.height * .04,
                  left: size.width * .06,
                  right: size.width * .06,
                  bottom: size.height * .1),
              child: Text(
                "lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book.",
                style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            

            //Final Button
            GestureDetector(
              onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DietScreen(),
                    ),
                  );},
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
          depth: 3,
          shadowLightColor: Color(0xFF707070),
          shadowDarkColor: Colors.black),
    );
  }
}