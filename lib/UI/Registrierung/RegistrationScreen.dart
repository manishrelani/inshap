import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Backend/Registration.dart';
import 'package:inshape/Model/response.dart';
import 'package:inshape/UI/Registrierung/VerifyEmail.dart';
import 'package:inshape/UI/Registrierung/WelcomeScreen.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'package:ots/ots.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String errorMessage;
  Registration registration = Registration();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String emailError = "Please enter your email address",
      passwordError = "Please enter your password",
      confirmPasswordError = "Please re-enter your password";

  validateEmail() {
    final email = emailController.text;
    if (email.length > 1) {
      if (email.length > 4 && email.contains("@") && email.contains(".")) {
        setState(() {
          emailError = " ";
        });
      } else {
        setState(() {
          emailError = "Please enter valid email address";
        });
      }
    }
  }

  validatePassword() {
    final pass = passwordController.text;
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
      final confirmPassword = confirmPasswordController.text;
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
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
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

  bool validateUser(
      String email, String pass, String mob, String conPass, String fullName) {
    if (fullName.isEmpty) {
      errorMessage = 'Enter all valid fields';
      return false;
    } else if (email.isEmpty) {
      errorMessage = 'Email required';
      return false;
    } 
    // else if (!pass.contains(RegExp('[^A-Za-z0-9]'))) { 
    //   errorMessage =  'Password must contain Alpha numerical characters , special characters & case sensitive';
    //   return false;
    // } 
    // stupid logic
//    else if (!email.endsWith(".com")) {
//      errorMessage = 'Enter a valid email address';
//      return false;
//    }git
    else if (mob.isEmpty) {
      errorMessage = 'Mobile required';
      return false;
    }  else if(!mob.contains(RegExp('[0-9]{10}'))) { 
        errorMessage = 'Mobile number is not valid';  
         return false;  
    } else if (pass.isEmpty) {  
      errorMessage = 'Password required';
      return false;
    } else if (!pass.contains(RegExp('[^A-Za-z0-9]')) ||
        !pass.contains(RegExp(r'[0-9]'))) {
      errorMessage = 'Password must contain "@",a number and a capital letter';
      return false; 
    } else if (conPass.isEmpty) {
      errorMessage = 'Confirm password';
      return false;
    } else if (!conPass.contains(pass)) {
      errorMessage = "Passwords do not match";
      return false;
    } else {
      return true;
    }
  }

  Widget showDialogBox(message) {
    return CupertinoAlertDialog(
      title: Text('ERROR'),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Done'),
        )
      ],
    );
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
                            builder: (context) => WelcomeScreen(),
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
  void initState() {
    super.initState();
    emailController.addListener(validateEmail);
    passwordController.addListener(validatePassword);
    confirmPasswordController.addListener(validateConfirmPassword);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Registrieren"),
          backgroundColor: AppColors.primaryBackground,
          centerTitle: true,
          leading: IconButton(
            padding: EdgeInsets.only(left: 3),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFC8C8C8),
              size: size.height * .035,
            ),
            onPressed: () {
              // going back to welcome screen
              // Navigator.of(context).pushReplacement(
              //   AppNavigation.route(
              //     WelcomeScreen(),
              //   ),
              // );
              _onWillPop();
            },
          ),
        ),
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                children: <Widget>[
                  //CustomAppBar
                  LayoutBuilder(
                    builder: (ctx, constraint) {
                      return Container(
                        // padding: EdgeInsets.only(
                        //   left: constraint.maxWidth * .24,
                        //   right: constraint.maxWidth * .2,
                        //   top: constraint.minHeight * .1,
                        //   bottom: constraint.minHeight * .1,
                        // ),
                        // color: Colors.red,
                        height: size.height * .25,
                        child: Image.asset("assets/Logo.png"),
                      );
                    },
                  ),

                  //TextField 1 Started Here

                  Container(
                    margin: EdgeInsets.only(
                      left: size.width * .06,
                      right: size.width * .06,
                      top: 16.0,
                      bottom: 16.0,
                    ),
                    height: size.height * 0.10,
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
                                children: [
                                  TextField(
                                    maxLength: 60,
                                    buildCounter: (BuildContext context,
                                            {int currentLength,
                                            int maxLength,
                                            bool isFocused}) =>
                                        null,
                                    keyboardType: TextInputType.text,
                                    controller: fullNameController,
                                    cursorColor: Color(0xFFA0A0A0),
                                    textCapitalization:
                                        TextCapitalization.words,
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
                                  ),
                                ],
                              )),
                        ),
                        MainButton(
                          height: size.height * .05,
                          txt: "Benutzername",
                          txtColor: Color(0xFFC8C8C8),
                        )
                      ],
                    ),
                  ),

                  //TextField 2
                  Container(
                    margin: EdgeInsets.only(
                      left: size.width * .06,
                      right: size.width * .06,
                      top: 16.0,
                      bottom: 16.0,
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
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
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
                          txt: "E-Mail",
                          txtColor: Color(0xFFC8C8C8),
                        )
                      ],
                    ),
                  ),

                  emailError.length > 3
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Text(
                            emailError,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : SizedBox(),

                  //TextField 3 Starts Here
                  Container(
                    margin: EdgeInsets.only(
                      left: size.width * .06,
                      right: size.width * .06,
                      top: 16.0,
                      bottom: 16.0,
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
                                  maxLength: 15,
                                  buildCounter: (BuildContext context,
                                          {int currentLength,
                                          int maxLength,
                                          bool isFocused}) =>
                                      null,
                                  keyboardType: TextInputType.phone,
                                  controller: mobileController,
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
                          txt: "Handynummer",
                          txtColor: Color(0xFFC8C8C8),
                        )
                      ],
                    ),
                  ),
                  //TextField 4
                  Container(
                    margin: EdgeInsets.only(
                      left: size.width * .06,
                      right: size.width * .06,
                      top: 16.0,
                      bottom: 16.0,
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
                                  maxLength: 15,
                                  buildCounter: (BuildContext context,
                                          {int currentLength,
                                          int maxLength,
                                          bool isFocused}) =>
                                      null,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: passwordController,
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
                        )
                      ],
                    ),
                  ),

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

                  //TextField 5
                  Container(
                    margin: EdgeInsets.only(
                      left: size.width * .06,
                      right: size.width * .06,
                      top: 16.0,
                      bottom: 16.0,
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
                                  maxLength: 15,
                                  buildCounter: (BuildContext context,
                                          {int currentLength,
                                          int maxLength,
                                          bool isFocused}) =>
                                      null,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: confirmPasswordController,
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
                        )
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

                  //Final Bitton
                  GestureDetector(
                    onTap: register,
                    child: MainButton(
                      txt: "Weiter",
                      height: size.height * .065,
                      margin: EdgeInsets.only(
                        top: size.height * .03,
                        left: size.width * .06,
                        right: size.width * .06,
                        bottom: size.height * .03,
                      ),
                    ),
                  ),
                  Divider()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (validateUser(
        emailController.text,
        passwordController.text,
        mobileController.text,
        confirmPasswordController.text,
        fullNameController.text)) {
      showLoader();
      RegResponse reg = await registration.register(
          emailController.text,
          fullNameController.text,
          passwordController.text,
          mobileController.text);

      hideLoader();
//      print(reg.error);
//      print(reg.message);
//      print(reg.code);
      if ((reg.error == 'false')) {
        Navigator.pushReplacement(
          context,
          AppNavigation.route(
            VerifyEmail(
              email: emailController.text,
            ),
          ),
        );
      } else {
        AppToast.show(reg.message);
      }
    } else {
      AppToast.show(
        errorMessage,
      );
    }
  }
}
