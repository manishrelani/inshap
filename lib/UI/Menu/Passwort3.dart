import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/utils/colors.dart';

class Passwort3 extends StatefulWidget {
  @override
  _Passwort3State createState() => _Passwort3State();
}

class _Passwort3State extends State<Passwort3> {
  bool firstIsChecked = false;
  bool secondIsChecked = false;
  var whitetitlefontSize = 17.0;

  @override
  Widget build(BuildContext context) {
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
                "Integrationen",
                textAlign: TextAlign.center,
                style: ThemeText.titleText,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                children: <Widget>[
                  //First Toggele Button
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Apple Watch",
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: whitetitlefontSize,
                              ),
                            ),
                            Spacer(),
                            Neumorphic(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20)),
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    depth: 0.0,
                                    lightSource: LightSource.topLeft,
                                    color: Color(0xff16162B)),
                                child: NeumorphicSwitch(
                                  height: 28.5,
                                  value: firstIsChecked,
                                  style: NeumorphicSwitchStyle(
                                      inactiveTrackColor: Color(0xFF343547),
                                      activeTrackColor: AppColors.green,
                                      activeThumbColor: Colors.white,
                                      thumbShape: NeumorphicShape.flat),
                                  onChanged: (value) {
                                    setState(() {
                                      firstIsChecked = value;
                                    });
                                  },
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 0.75,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFF373742),
                      ),
                    ],
                  ),

                  //second Toggele Button
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Schrittzähler",
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: whitetitlefontSize,
                              ),
                            ),
                            Spacer(),
                            Neumorphic(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20)),
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    depth: 0.0,
                                    lightSource: LightSource.topLeft,
                                    color: Color(0xff16162B)),
                                child: NeumorphicSwitch(
                                  height: 28.5,
                                  value: secondIsChecked,
                                  style: NeumorphicSwitchStyle(
                                      inactiveTrackColor: Color(0xFF343547),
                                      activeTrackColor: AppColors.green,
                                      activeThumbColor: Colors.white,
                                      thumbShape: NeumorphicShape.flat),
                                  onChanged: (value) {
                                    setState(() {
                                      secondIsChecked = value;
                                    });
                                  },
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 0.75,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFF373742),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
