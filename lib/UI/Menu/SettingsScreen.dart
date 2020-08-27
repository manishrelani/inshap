import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Menu/Abonnement.dart';
import 'package:inshape/UI/Menu/Abonnement1.dart';
import 'package:inshape/UI/Menu/Abonnement2.dart';
import 'package:inshape/UI/Menu/EditProfile.dart';
import 'package:inshape/UI/Menu/KontoScreen.dart';
import 'package:inshape/UI/Menu/Support.dart';
import 'package:inshape/UI/Menu/UberInShape.dart';
import 'package:inshape/UI/SplashScreen.dart';
import 'package:inshape/providers/session.dart';
import 'package:inshape/utils/colors.dart';
import 'package:ots/ots.dart';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  var whitetitlefontSize = 17.0;
  final storage = FlutterSecureStorage();

  // Perform Action Here
  buttonWithBackAction(String text) {
    switch (text) {
      case "Profil":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditProfile()));
        break;
      case "Konto":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => KontoScreen()));
        break;
      case "Abonnement":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Abonnement()));
        break;
      case "Support":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Support()));
        break;
      case "Über InShape":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UberInShape()));
        break;
      case "InShape bewerten":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Abonnement1()));
        break;
      case "AGB und Datenschutz":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Abonnement2()));
        break;

      default:
    }
  }

  Widget custumTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("Button Press");
              buttonWithBackAction(text);
            },
            child: Row(
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
          ),
          Container(
            height: 0.75,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF373742),
          ),
        ],
      ),
    );
  }

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
          "Einstellungen",
          textAlign: TextAlign.center,
          style: ThemeText.titleText,
        ),
      ),
      body: ListView(
        children: <Widget>[
          custumTitle("Profil"),
          custumTitle("Konto"),
          custumTitle("Abonnement"),
          custumTitle("Support"),
          custumTitle("Über InShape"),
          custumTitle("InShape bewerten"),
          custumTitle("AGB und Datenschutz"),
          SizedBox(
            height: totalHeight * 0.22,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: GestureDetector(
              onTap: () async {
                showLoader();
                await SessionProvider.clear();
                hideLoader();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SplashScreen.route,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
              },
              child: Container(
                height: totalHeight * 0.065,
                width: totalwidth,
                child: Neumorphic(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Ausloggen",
                        style: TextStyle(color: AppColors.green, fontSize: 22),
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
    ));
  }
}
