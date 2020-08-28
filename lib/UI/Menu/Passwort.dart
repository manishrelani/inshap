import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:inshape/Backend/profile.dart';
import 'package:inshape/Model/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/toast.dart';
import 'package:ots/ots.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController newPasswordVerification = TextEditingController();

  String oldPasswordError = "Please enter old password";
  String error = "Please enter new password";
  String passwordError = " ";
  String confirmPasswordError = " ";

  validatePassword() {
    final pass = newPassword.text;
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
      final confirmPassword = newPasswordVerification.text;
      if (pass == confirmPassword) {
        setState(() {
          confirmPasswordError = "";
        });
      } else {
        setState(() {
          confirmPasswordError = "Passwords do not match";
        });
      }
    }
  }

  validateConfirmPassword() {
    final password = newPassword.text;
    final confirmPassword = newPasswordVerification.text;
    if (password == confirmPassword) {
      setState(() {
        confirmPasswordError = "";
      });
    } else {
      setState(() {
        confirmPasswordError = "Passwords do not match";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    oldPassword.addListener(() {
      if (oldPassword.text.length > 0) {
        setState(() {
          oldPasswordError = "";
        });
      } else {
        setState(() {
          oldPasswordError = "Please enter old password";
        });
      }
    });

    newPassword.addListener(validatePassword);
    newPasswordVerification.addListener(validateConfirmPassword);
  }

  // @override
  // void initState() {
  //   oldPassword.addListener(() {
  //     if (oldPassword.text.length > 6) {
  //       setState(() {
  //         oldPasswordError = "";
  //       });
  //     } else {
  //       setState(() {
  //         oldPasswordError = "Please enter valid old password";
  //       });
  //     }
  //   });
  //   newPasswordVerification.addListener(() {
  //     if (newPassword.text.length > 6 &&
  //         newPasswordVerification.text == newPassword.text) {
  //       setState(() {
  //         error = "";
  //       });
  //     } else {
  //       setState(() {
  //         error = "New password and verify password doesn\'t match";
  //       });
  //     }
  //   });
  //   super.initState();
  // }

  //Handle Back Button
  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: CupertinoAlertDialog(
                title: Text("Password updated successfully"),
                content: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                actions: <Widget>[
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontWeight: FontWeight.normal),
                      )),
                ],
              ),
            ))) ??
        false;
  }

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
            "Passwort ändern",
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                obscureText: true,
                controller: oldPassword,
                cursorColor: AppColors.green,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    hintText: "Old Passwort",
                    hintStyle: TextStyle(
                      color: Color(0xffFFFFFF).withOpacity(0.6),
                      fontSize: 17,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.green,
                      ),
                    )),
              ),
              SizedBox(height: 16.0),
              Text('$oldPasswordError',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: 16.0),
              TextField(
                obscureText: true,
                controller: newPassword,
                keyboardType: TextInputType.emailAddress,
                cursorColor: AppColors.green,
                maxLength: 15,
                buildCounter: (BuildContext context,
                        {int currentLength, int maxLength, bool isFocused}) =>
                    null,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    hintText: "Neues Passwort",
                    hintStyle: TextStyle(
                      color: Color(0xffFFFFFF).withOpacity(0.6),
                      fontSize: 17,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.green,
                      ),
                    )),
              ),
              SizedBox(height: 2.0),
              passwordError.length > 3
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        passwordError,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 16.0),
              TextFormField(
                obscureText: true,
                controller: newPasswordVerification,
                maxLength: 15,
                keyboardType: TextInputType.emailAddress,
                buildCounter: (BuildContext context,
                        {int currentLength, int maxLength, bool isFocused}) =>
                    null,
                cursorColor: AppColors.green,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    hintText: "Neues Passwort verification",
                    hintStyle: TextStyle(
                      color: Color(0xffFFFFFF).withOpacity(0.6),
                      fontSize: 17,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.green,
                      ),
                    )),
              ),
              SizedBox(height: 16.0),
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

              // Text('$error',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(color: Colors.white)),
              SizedBox(height: 64.0),
              InkWell(
                onTap: () {
                  if (!newPassword.text.contains(RegExp('[^A-Za-z0-9]')) ||
                      !newPassword.text.contains(RegExp(r'[A-Z]')) ||
                      !newPassword.text.contains(RegExp(r'[0-9]'))) {
                    AppToast.show(
                        "Password must contain Alpha numerical characters , special characters & case sensitive");
                  } else {
                    updatePassword();
                  }
                },
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Neumorphic(
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Passwort speichern",
                          style:
                              TextStyle(color: AppColors.green, fontSize: 22),
                        ),
                      ),
                    ),
                    style: NeumorphicStyle(
                      color: Color(0xFF16162B),
                      depth: 4,
                      shadowLightColor: Color(0xFF2B2B41),
                      shadowDarkColor: Color(0xFF0A0A14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePassword() async {
    if (oldPassword.text.length > 0  && confirmPasswordError.length <= 0) {
      FocusScope.of(context).requestFocus(FocusNode());
      showLoader(isModal: true);
      String response =
          await UserProfile.updatePassword(oldPassword.text, newPassword.text);
      hideLoader();
      debugPrint(response);
      oldPassword.clear();
      newPassword.clear();
      newPasswordVerification.clear();
      setState(() {
        passwordError="";
        oldPasswordError="";
      });
      var jsonResponse = json.decode(response);
      //if (jsonResponse['error'] == true) {
      print("${jsonResponse['message']}");
      if (jsonResponse['message'] == 'DB update operation success') {
        _onWillPop();
      } else {
        AppToast.show("${jsonResponse['message']}");
      }
    }
  }
}
