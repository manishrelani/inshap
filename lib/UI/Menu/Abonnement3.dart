import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/utils/colors.dart';

class Abonnement3 extends StatefulWidget {
  @override
  _Abonnement3State createState() => _Abonnement3State();
}

class _Abonnement3State extends State<Abonnement3> {
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
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 100,
                child: Image(
                  image: AssetImage("assets/icon2.png"),
                )),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: totalwidth * .07,
                      right: totalwidth * .07,
                    ),
                    child: Text(
                      "Wenn du InShape Premium kündigst, verlierst du den unbegrenzten Zugang zu allen Workouts und maßgeschneiderten Workoutplänen. ",
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),

            //last Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("Ausloggen Button Press");
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
                          "InSight Pro kündigen",
                          style:
                              TextStyle(color: AppColors.green, fontSize: 18),
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
