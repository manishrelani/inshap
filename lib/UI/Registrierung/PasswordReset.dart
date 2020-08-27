import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Backend/Authentication.dart';
import 'package:inshape/Model/response.dart';
import 'package:inshape/UI/Registrierung/LoginScreen.dart';
import 'package:inshape/UI/Registrierung/NewPassword.dart';
import 'package:inshape/Widget/CustomAppBar.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/toast.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  int backspacedIndex = -1;
  List<String> otpList = List(6);
  String otp;
  bool _isLoading;
  Auth auth = Auth();
  RegResponse res, res2;
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  TextEditingController controller4 = new TextEditingController();
  TextEditingController controller5 = new TextEditingController();
  TextEditingController controller6 = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController currController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
  }

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  void sendRestEmail(email) async {
    res = await auth.sendResetPassOtp(email).then((res) {
      print(res.message);
      print(res.error);
      print(res.code);
      setState(() {
        _isLoading = false;
      });
      if (res.error == 'false') {
        AppToast.show(res.message);
      } else {
        AppToast.show(res.message);
      }
    }).whenComplete(() {});
  }

  //Reset Password
  Future<void> verifyResetEmailOtp(email, otp) async {
    print("email: $email");
    print("otp: $otp");
    try {
      res2 = await auth.verifyResetPassOtp(email, otp).then((res2) {
        print(res2.code);
        if (res2.error == 'false') {
          AppToast.show(res2.message);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NewPassword(email: emailController.text, otp: otp),
            ),
          );
        } else if (res2.code == "FUV03") {
          AppToast.show("Incorrect OTP");
          setState(() {
            _isLoading = false;
          });
        } else if (res2.code == "FUV02") {
          AppToast.show("Email Address does not exist");
          setState(() {
            _isLoading = false;
          });
        } else {
          AppToast.show(res2.message);
          setState(() {
            _isLoading = false;
          });
        }
      }).whenComplete(() {});
    } catch (e) {
      print("Error occure");
      print(e.toString());
    }
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
                    )),
                actions: <Widget>[
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
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
                      child: Text("No",
                          style: TextStyle(
                              color: Color(0xFF007AFF),
                              fontWeight: FontWeight.normal))),
                ],
              ),
            ))) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    //List of TextField

    List<Widget> widgetList = [
      getPinField(key: "1", focusNode: focusNode1),
      getPinField(key: "2", focusNode: focusNode2),
      getPinField(key: "3", focusNode: focusNode3),
      getPinField(key: "4", focusNode: focusNode4),
      getPinField(key: "5", focusNode: focusNode5),
      getPinField(key: "6", focusNode: focusNode6),
    ];

    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height * .1;
    final double itemWidth = size.width * .2;
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : WillPopScope(
              onWillPop: _onWillPop,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      //CustomAppBar
                      CustomAppBar(
                        barTxt: "Passwort zurücksetzen",
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
                            // color: Colors.red,
                            height: size.height * .27,
                            child: Image.asset("assets/Logo.png"),
                          );
                        },
                      ),

                      //Text, Bellow the Logo Image.
                      Container(
                        margin: EdgeInsets.only(
                          top: size.height * .025,
                          left: size.width * .06,
                          right: size.width * .06,
                        ),
                        child: Text(
                          "Um deine Identität zu bestätigen schicken wir dir einen 6-Stelligen Authentifizierungscode an deine E-Mail. Bitte gib",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: size.height * .08),
                        child: Text(
                          "dazu deine E-Mail  ein.",
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
                                      autofocus: true,
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
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

                      //Button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLoading = true;
                          });
                          sendRestEmail(emailController.text);
                        },
                        child: MainButton(
                          margin: EdgeInsets.only(
                            top: size.height * .025,
                            left: size.width * .06,
                            right: size.width * .06,
                          ),
                          height: size.height * .065,
                          txt: "Code eingeben",
                          txtColor: Color(0xFFC8B375),
                        ),
                      ),

                      //OTP Textfields

                      Container(
                        margin: EdgeInsets.only(
                            left: size.width * .12, top: size.height * .01),
                        child: RawKeyboardListener(
                          onKey: handleKey,
                          focusNode: getFocusNode(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GridView.count(
                                childAspectRatio: itemHeight / itemWidth,
                                crossAxisCount: 7,
                                mainAxisSpacing: size.height * 1,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: List<Container>.generate(
                                  6,
                                  (int index) => Container(
                                    margin: EdgeInsets.all(size.width * .01),
                                    child: widgetList[index],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          bottom: size.height * .01,
                          top: size.height * .025,
                        ),
                        child: Text(
                          "Du hast keinen Code erhalten?",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          //Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: size.width * .06, right: size.width * .07),
                          child: Text(
                            "E-Mail erneut schicken",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF007AFF),
                              fontSize: 10,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                      // Button
                      GestureDetector(
                        onTap: () {
                          print("Button press");
                          setState(() {
                            _isLoading = true;
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                          otp = otpList.join().replaceAll("null", "");
                          verifyResetEmailOtp(emailController.text, otp);
                        },
                        child: MainButton(
                          txt: "Verifizieren",
                          txtColor: Color(0xFFC8B375),
                          height: size.height * .065,
                          margin: EdgeInsets.only(
                            top: size.height * .03,
                            left: size.width * .06,
                            right: size.width * .06,
                          ),
                        ),
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  FocusNode keyBoard = FocusNode();
  FocusNode getFocusNode() {
    return keyBoard;
  }

  void handleKey(RawKeyEvent event) {
    if (event.physicalKey == PhysicalKeyboardKey.backspace) {
      switch (backspacedIndex) {
        case 1:
          FocusScope.of(context).requestFocus(focusNode1);
          break;
        case 2:
          FocusScope.of(context).requestFocus(focusNode2);
          break;
        case 3:
          FocusScope.of(context).requestFocus(focusNode3);
          break;
        case 4:
          FocusScope.of(context).requestFocus(focusNode4);
          break;
        case 5:
          FocusScope.of(context).requestFocus(focusNode5);
          break;
        case 6:
          FocusScope.of(context).requestFocus(focusNode6);
          break;
        default:
          FocusScope.of(context).requestFocus(focusNode1);
          break;
      }
    }
  }

  String code = "";
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();

  Widget getPinField({String key, FocusNode focusNode}) => SizedBox(
        height: 40.0,
        width: 35.0,
        child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(10),
          ),
          style: NeumorphicStyle(
            depth: -3,
            color: Color(0xFF16162B),
            shadowDarkColor: Colors.black,
            shadowDarkColorEmboss: Colors.black,
            shadowLightColorEmboss: Color(0xFF707070),
          ),
          child: TextField(
//            key: UniqueKey(),
            key: Key(key),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            focusNode: focusNode,
            expands: false,
            autofocus: key.contains("1") ? true : false,
//            controller: controller1,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onChanged: (String value) {
//              print("changed $value $code");
              if (value.length == 1) {
//                code += value;
//                switch (code.length) {
                final kkey = int.parse(key);
                otpList[kkey - 1] = value;
                print("Key: $key appended $value ${otpList.join()}");
                switch (kkey) {
                  case 1:
                    FocusScope.of(context).requestFocus(focusNode2);
                    break;
                  case 2:
                    FocusScope.of(context).requestFocus(focusNode3);
                    break;
                  case 3:
                    FocusScope.of(context).requestFocus(focusNode4);
                    break;
                  case 4:
                    FocusScope.of(context).requestFocus(focusNode5);
                    break;
                  case 5:
                    FocusScope.of(context).requestFocus(focusNode6);
                    break;
                  default:
                    FocusScope.of(context).requestFocus(FocusNode());
                    break;
                }
              } else if (value.length == 0) {
                // remove code at current position
                final kkey = int.parse(key);
                backspacedIndex = kkey - 1;
              }
            },
            maxLengthEnforced: false,
            textAlign: TextAlign.center,
            cursorColor: Color(0xFFA0A0A0),
            style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 18),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              counter: SizedBox(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFFFFFF),
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      );
}
