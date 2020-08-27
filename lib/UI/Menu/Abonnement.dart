import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Menu/Abonnement1.dart';

import 'package:inshape/UI/Menu/Abonnement3.dart';
import 'package:inshape/providers/goals.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

class Abonnement extends StatefulWidget {
  @override
  _AbonnementState createState() => _AbonnementState();
}

class _AbonnementState extends State<Abonnement> {
  var whitetitlefontSize = 17.0;
  Widget custumTitle(String text, String subText) {
    return GestureDetector(
      onTap: () {
        if (text == "Plan") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Abonnement1()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontSize: whitetitlefontSize,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  child: Text(
                    subText,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 0.75,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF373742),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final goalsProvider = Provider.of<GoalsProvider>(context);

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
          children: <Widget>[
            custumTitle("Plan",
                "${goalsProvider.goals[profileProvider.profile.goal].name}"),
            custumTitle("Gültig bis", "26.02.2020"),
            custumTitle("Status", "Aktiv"),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Abonnement3()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "InShape Pro kündigen",
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: whitetitlefontSize,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () {},
                          color: Colors.white,
                        )
                      ],
                    ),
                    Container(
                      height: 0.75,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xFF373742),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
