import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'LoginScreen.dart';
import 'RegistrationScreen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _launchURL() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width * .06,
            right: size.width * .06,
          ),
          child: Column(
            children: <Widget>[
              LayoutBuilder(
                builder: (ctx, constraint) {
                  return Container(
                    //color: Colors.red,
                    margin: EdgeInsets.only(
                      top: size.height * .066,
                      bottom: size.height * .08,
                    ),
                    padding: EdgeInsets.only(
                      left: constraint.maxWidth * .20,
                      right: constraint.maxWidth * .16,
                      top: constraint.minHeight * .1,
                      bottom: constraint.minHeight * .1,
                    ),
                    // color: Colors.red,
                    height: size.height * .30,
                    child: Image.asset(
                      "assets/Logo.png",
                      fit: BoxFit.fitHeight,
                    ),
                    // padding: EdgeInsets.only(
                    //   left: constraint.maxWidth * .20,
                    //   right: constraint.maxWidth * .16,
                    //   top: constraint.minHeight * .1,
                    //   bottom: constraint.minHeight * .1,
                    // ),
                    //color: Colors.red,
                  );
                },
              ),
              
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: MainButton(
                  txt: "Einloggen",
                  txtColor: Color(0xFFc8b375),//previous color 50F300
                  height: size.height * .065,
                  margin: EdgeInsets.only(
                    top: size.height * .1,
                    bottom: size.height * .05,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationScreen(),
                    ),
                  );
                },
                child: MainButton(
                  txtColor: Color(0xFFc8b375),//previous color 50F300
                  txt: "Registrieren",
                  height: size.height * .065,
                  margin: EdgeInsets.only(
                    bottom: size.height * .12,
                  ),
                ),
              ),
              
              GestureDetector(
                onTap: () {
                  _launchURL();
                  print("Terms and conditions");
                },
                child: Container(
                  height: size.height * .03,
                  //color:Colors.red,
                  child: Text(
                    "IMPRESSUM AGB DATENSCHUTZ",
                    style: TextStyle(
                      color: Color(0xFFA0A0A0),
                      fontSize: 10,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
