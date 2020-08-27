import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Menu/Passwort.dart';
import 'package:inshape/UI/Menu/Passwort2.dart';
import 'package:inshape/UI/Menu/Passwort3.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

class KontoScreen extends StatefulWidget {
  @override
  _KontoScreenState createState() => _KontoScreenState();
}

class _KontoScreenState extends State<KontoScreen> {
  var whitetitlefontSize = 17.0;
  int _selectedIndex = 0;
  bool isChecked = false;

  // Perform Action Here
  buttonWithBackAction(String text) {
    switch (text) {
      case "Passwort ändern":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UpdatePassword()));
        //customPopUp();
        print("Passwort ändern Button Press");
        break;
      case "Sprache":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Passwort2()));
        print("Sprache Button Press");
        break;
      case "Integrationen":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Passwort3()));
        print("Integrationen Press");
        break;

      default:
    }
  }

  Future<void> customPopUp() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            titlePadding: EdgeInsets.all(0),
            elevation: 4,
            title: Container(
              height: MediaQuery.of(context).size.height * 0.34,
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                  color: Color(0xff1E1E1E),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Passwort",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  Text(
                    "Bitte gib dein aktuelles Passwort ein",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          hintText: "Passwort",
                          hintStyle: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 0.75,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFF373742),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Center(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  print("Zurück Button Press");
                                },
                                child: Text(
                                  "Zurück",
                                  style: TextStyle(
                                      fontSize: 17.0, color: Color(0xff0A84FF)),
                                ),
                              )),
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: VerticalDivider(
                                color: Color(0xFF373742),
                              )),
                          Expanded(
                            child: Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  print("Weiter Button Press");
                                },
                                child: Center(
                                    child: Text(
                                  "Weiter",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Color(0xff0A84FF),
                                  ),
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget custumTitle(String text, String subText) {
    return GestureDetector(
      onTap: () {
        print("Button Press");
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

  Widget custumTitleWithBack(String text) {
    return GestureDetector(
      onTap: () {
        buttonWithBackAction(text);
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
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    buttonWithBackAction(text);
                  },
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
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
          "Konto",
          textAlign: TextAlign.center,
          style: ThemeText.titleText,
        ),
      ),
      body: ListView(
        children: <Widget>[
          custumTitle("E-Mail", "${profileProvider.profile.email}"),
          custumTitleWithBack("Passwort ändern"),
          custumTitleWithBack("Sprache"),

          //Switch Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Einheiten",
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: whitetitlefontSize,
                        ),
                      ),
                      Spacer(),
                      Neumorphic(
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(9),
                          ),
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            depth: 0.0,
                            color: Color(0xff767680),
                          ),
                          child: NeumorphicToggle(
                            padding: EdgeInsets.all(0.75),
                            style: NeumorphicToggleStyle(
                              animateOpacity: true,
                              backgroundColor: Color(0xFF1E1E36),
                              borderRadius: BorderRadius.circular(9),
                              depth: 10.0,
                              disableDepth: true,
                            ),
                            height: MediaQuery.of(context).size.height * 0.052,
                            width: MediaQuery.of(context).size.width / 2,
                            selectedIndex: _selectedIndex,
                            displayForegroundOnlyIfSelected: true,
                            children: [
                              ToggleElement(
                                  background: Center(
                                    child: Text(
                                      "Metrisch",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  foreground: Center(
                                    child: Text(
                                      "Metrisch",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                              ToggleElement(
                                  background: Center(
                                    child: Text(
                                      "Imperial",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  foreground: Center(
                                    child: Text(
                                      "Imperial",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ))
                            ],
                            thumb: Neumorphic(
                              style: NeumorphicStyle(
                                color: Color(0xff16162B),
                                disableDepth: true,
                              ),
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(9.0)),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _selectedIndex = value;
                                print("$_selectedIndex");
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
          ),
          custumTitleWithBack("Integrationen"),

          //Switch Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Benachrichtungen",
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
                            value: isChecked,
                            style: NeumorphicSwitchStyle(
                                inactiveTrackColor: Color(0xFF343547),
                                activeTrackColor: AppColors.green,
                                activeThumbColor: Colors.white,
                                thumbShape: NeumorphicShape.flat),
                            onChanged: (value) {
                              setState(() {
                                isChecked = value;
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                ),
                GestureDetector(
                  onTap: () {
                    print("Konto löschen Press");
                    customPopUp();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.065,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xff707070),
                          width: 0.5,
                        ),
                        bottom: BorderSide(
                          color: Color(0xff707070),
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Konto löschen",
                          style:
                              TextStyle(color: Color(0xffFF0000), fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
