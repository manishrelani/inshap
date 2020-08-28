import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Backend/Authentication.dart';
import 'package:inshape/Model/response.dart';
import 'package:inshape/UI/Registrierung/LoginScreen.dart';
import 'package:inshape/UI/Registrierung/PasswordReset.dart';
import 'package:inshape/Widget/CustomAppBar.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NewPassword extends StatefulWidget {
  final email;
  final otp;
  NewPassword({this.email, this.otp});
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool _isLoading = false;
  String otp;
  RegResponse res;

  Auth auth = Auth();
  TextEditingController passwordController1 = new TextEditingController();
  TextEditingController passwordController2 = new TextEditingController();

  String confirmPasswordError = "Please re-enter your password";
  String passwordError = "Please enter your password";

  @override
  void initState() {
    super.initState();
    passwordController2.addListener(validateConfirmPassword);
    passwordController1.addListener(validatePassword);
  }

  validatePassword() {
    final pass = passwordController1.text;
    if (!pass.contains(RegExp('[^A-Za-z0-9]')) ||
        !pass.contains(RegExp(r'[A-Z]')) ||
        !pass.contains(RegExp(r'[0-9]'))) {
      setState(() {
        passwordError =
            "Password must contain Alpha numerical characters , special characters & case sensitive";
      });
    } else {
      setState(() {
        passwordError = " ";
      });
      final confirmPassword = passwordController2.text;
      if (pass == confirmPassword) {
        setState(() {
          confirmPasswordError = " ";
        });
      } else {
        setState(() {
          confirmPasswordError = "Passwords do not match";
        });
      }
    }
  }

  validateConfirmPassword() {
    final password = passwordController1.text;
    final confirmPassword = passwordController2.text;
    if (password == confirmPassword) {
      setState(() {
        confirmPasswordError = " ";
      });
    } else {
      setState(() {
        confirmPasswordError = "Passwords do not match";
      });
    }
  }

  resetPassword(email, otp, pass) async {
    debugPrint(email);
    debugPrint(otp);
    debugPrint(pass);
    final uri = 'https://inshape-api.cadoangelus.me/auth/reset/';
    final headers = {
      'accept': "application/json",
      'Content-Type': 'application/json'
    };
    Map<String, dynamic> body = {
      "email": email.toString(),
      "otp": otp.toString(),
      "password": pass.toString()
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    http.Response response = await http.put(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
        AppToast.show('Password updated successfully');
        _isLoading = false;
        Navigator.pushReplacement(
          context,
          AppNavigation.route(
            LoginScreen(),
          ),
        );
      });
    }
    print(response.statusCode);
    print(response.body);
  }

  //Handle Back Button
  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: CupertinoAlertDialog(
                title: Text("Leave Page?"),
                content: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    "Are you sure you want to leave?",
                    style: TextStyle(
                      color: Color(0xff383838),
                    ),
                  ),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PasswordReset(),
                          ),
                        );
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontWeight: FontWeight.normal),
                      )),
                  CupertinoDialogAction(
                    textStyle: TextStyle(color: Colors.red),
                    isDefaultAction: true,
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ))) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => _onWillPop(),
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          child: _isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      //CustomAppBar
                      CustomAppBar(
                        barTxt: "Identität authentifizieren",
                        margin: EdgeInsets.only(
                          top: size.height * .02,
                        ),
                        extra: IconButton(
                          padding: EdgeInsets.only(left: 3),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFFC8C8C8),
                            size: size.height * .035,
                          ),
                          onPressed: () {
                            _onWillPop();
                          },
                        ),
                      ),
                      //Logo Image

                      LayoutBuilder(
                        builder: (ctx, constraint) {
                          return Container(
                            padding: EdgeInsets.only(
                              left: constraint.maxWidth * .24,
                              right: constraint.maxWidth * .2,
                              top: constraint.minHeight * .1,
                              bottom: constraint.minHeight * .1,
                            ),
                            //color: Colors.red,
                            height: size.height * .27,
                            child: Image.asset("assets/Logo.png"),
                          );
                        },
                      ),

                      //Text Bellow the Logo Image.

                      Container(
                        margin: EdgeInsets.only(
                            top: size.height * .08, bottom: size.height * .1),
                        padding: EdgeInsets.only(
                            left: size.width * .06, right: size.width * .07),
                        child: Text(
                          "Bitte gib nun dein neues Passwort ein. Benutze bitte kein Passwort was du schonmal verwendet hast.",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                        ),
                      ),

                      //TextField 1 Started Here
                      Container(
                        margin: EdgeInsets.only(
                          left: size.width * .06,
                          right: size.width * .06,
                        ),
                        height: size.height * .1,
                        width: double.infinity,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: Neumorphic(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(10)),
                                style: NeumorphicStyle(
                                  depth: -5,
                                  color: Color(0xFF16162B),
                                  shadowDarkColor: Color(0xFF0A0A14),
                                  shadowDarkColorEmboss: Color(0xFF0A0A14),
                                  shadowLightColorEmboss:
                                      AppColors.shadowLightColor,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextField(
                                      controller: passwordController1,
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: true,
                                      cursorColor: Color(0xFFA0A0A0),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFA0A0A0),
                                      ),
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF707070),
                                            width: .01,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            MainButton(
                              height: size.height * .05,
                              txt: "Passwort",
                              txtColor: Color(0xFFC8C8C8),
                            ),
                          ],
                        ),
                      ),

                      passwordError.length > 3
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                passwordError,
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : SizedBox(),

                      SizedBox(
                        height: size.height * .02,
                      ),
                      //TextField 2 Started Here

                      Container(
                        margin: EdgeInsets.only(
                          left: size.width * .06,
                          right: size.width * .06,
                        ),
                        height: size.height * .1,
                        width: double.infinity,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: Neumorphic(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(10)),
                                style: NeumorphicStyle(
                                  depth: -5,
                                  color: Color(0xFF16162B),
                                  shadowDarkColor: Color(0xFF0A0A14),
                                  shadowDarkColorEmboss: Color(0xFF0A0A14),
                                  shadowLightColorEmboss:
                                      AppColors.shadowLightColor,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextField(
                                      controller: passwordController2,
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: true,
                                      cursorColor: Color(0xFFA0A0A0),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFA0A0A0),
                                      ),
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF707070),
                                            width: .01,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            MainButton(
                              height: size.height * .05,
                              txt: "Passwort wiederholen",
                              txtColor: Color(0xFFC8C8C8),
                            ),
                          ],
                        ),
                      ),

                      confirmPasswordError.length > 3
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                confirmPasswordError,
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : SizedBox(),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLoading = true;
                          });
                          if (passwordController1.text ==
                              passwordController2.text) {
                            if (passwordController1.text.isEmpty) {
                              AppToast.show('Please enter password');
                              setState(() {
                                _isLoading = false;
                              });
                            } else if (!passwordController1.text
                                    .contains(RegExp('[^A-Za-z0-9]')) ||
                                !passwordController1.text
                                    .contains(RegExp(r'[0-9]'))) {
                              AppToast.show(
                                  'Password must contain "@",a number and a capital letter');
                              setState(() {
                                _isLoading = false;
                              });
                            } else {
                              print("Done");
                              resetPassword(widget.email, widget.otp,
                                  passwordController1.text);
                            }
                          } else {
                            AppToast.show('Confirm password same as password');
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        child: MainButton(
                          txt: "Passwort ändern",
                          height: size.height * .065,
                          margin: EdgeInsets.only(
                            top: size.height * .08,
                            bottom: size.height * .08,
                            left: size.width * .06,
                            right: size.width * .06,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
