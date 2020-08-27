import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Menu/Abonnement3.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/utils/colors.dart';

class Abonnement2 extends StatefulWidget {
  @override
  _Abonnement2State createState() => _Abonnement2State();
}

class _Abonnement2State extends State<Abonnement2> {
  @override
  Widget build(BuildContext context) {
    var totalHeight = MediaQuery.of(context).size.height;
    var totalwidth = MediaQuery.of(context).size.width;

    return SafeArea(
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
            "Abonnement",
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // SizedBox(height: totalHeight*.001,),
            CircleAvatar(
                backgroundColor: Color(0xff454D62).withOpacity(0.3),
                radius: 82,
                child: Image(
                  image: AssetImage("assets/Icon1.png"),
                )),

            Text(
              "Glückwunsch!",
              style: TextStyle(
                fontSize: 26.0,
                color: AppColors.green,
              ),
            ),

            Container(
              child: Column(
                children: <Widget>[
                  //white text
                  Text(
                    "Du bist jetzt Premium-Mitglied!",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xffC0C0C0),
                    ),
                  ),

                  // samll Description

                  Wrap(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          left: totalwidth * .13,
                          right: totalwidth * .13,
                          top: totalHeight * .02,
                        ),
                        child: Text(
                          "Viel Spaß mit deinem unbegrenzten Zugang zu allen Workouts und deinen eigenen maßgeschneiderten Workoutplänen.",
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            //last Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 34.0),
              child: GestureDetector(
                onTap: () {
                  print("Ausloggen Button Press");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contex) => Abonnement3()));
                },
                child: Container(
                  height: totalHeight * 0.065,
                  width: totalwidth,
                  child: Neumorphic(
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Weiter",
                          style:
                              TextStyle(color: AppColors.green, fontSize: 22),
                        ),
                      ),
                    ),
                    style: NeumorphicStyle(
                        color: Color(0xFF16162B),
                        depth: 4,
                        shadowLightColor: Color(0xFF2B2B41),
                        shadowDarkColor: Color(0xFF0A0A14)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
