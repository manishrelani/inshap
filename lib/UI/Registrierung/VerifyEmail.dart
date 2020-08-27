import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Backend/Registration.dart';
import 'package:inshape/Model/response.dart';
import 'package:inshape/Widget/CustomAppBar.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'package:ots/ots.dart';
import 'LoginScreen.dart';
import 'RegistrationScreen.dart';

void main() {
  runApp(MaterialApp(home: VerifyEmail(email: 'fayazfz07@gmail.com')));
}

class VerifyEmail extends StatefulWidget {
  final email;

  const VerifyEmail({Key key, this.email}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  String otp;
  RegResponse res, resOtp;

  List<String> otpList = List(6);

  Registration registration = Registration();
  TextEditingController emailController = new TextEditingController();

  FocusNode keyBoard = FocusNode();

  void sendEmailVerification(email) async {
    await showLoader();
    print("verifying email");
    res = await registration.sendEmailVerification(email);
    print(res.message);
    print(res.error);
    print(res.code);
    await hideLoader();
    if (res.error == 'false') {
      AppToast.show(res.message);
    } else {
      AppToast.show(res.message);
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
            child: Text('Done'))
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    emailController.text = widget.email ?? "";
    super.initState();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //CustomAppBar
              CustomAppBar(
                barTxt: "E-Mail verifzieren",
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
                    Navigator.of(context).pushReplacement(
                        AppNavigation.route(RegistrationScreen()));
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
              //Text Bellow the Logo Image.
              //Text 1

              Container(
                //width: size.width * .65,
                margin: EdgeInsets.only(
                    top: size.height * .025, bottom: size.height * .08),
                padding: EdgeInsets.only(
                    left: size.width * .06, right: size.width * .06),
                child: Text(
                  "Um deine Identität zu bestätigen schicken wir dir einen 6-Stelligen Authentifizierungscode an deine E-Mail. Bitte gib dazu deine E-Mail  ein.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
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
                          shadowDarkColor: Colors.black,
                          shadowDarkColorEmboss: Colors.black,
                          shadowLightColorEmboss: Color(0xFF707070),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              cursorColor: Color(0xFFA0A0A0),
                              enabled: false,
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
                  sendEmailVerification(emailController.text);
                },
                child: MainButton(
                  txt: "Code eingeben",
                  height: size.height * .065,
                  margin: EdgeInsets.only(
                    top: size.height * .025,
                    left: size.width * .06,
                    right: size.width * .06,
                  ),
                ),
              ), 

              SizedBox(height: 16.0),

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
                        //primary: false,
                        scrollDirection: Axis.vertical,
                        children: List<Container>.generate(
                          6,
                          (int index) => Container(
                            margin: EdgeInsets.all(size.width * .01),
                            child: Form(child: widgetList[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                // width: size.width * .6,
                margin: EdgeInsets.only(
                  bottom: size.height * .01,
                  top: size.height * .025,
                ),

                child: Text(
                  "Du hast keinen Code erhalten?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
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
                onTap: () async {
                  showLoader();
                  FocusScope.of(context).requestFocus(FocusNode());
                  otp = otpList.join().replaceAll("null", "");
                  resOtp = await registration.verifyOtp(otp, widget.email);
                  hideLoader();
                  if (resOtp.error == 'false') {
                    AppToast.show(resOtp.message);
                    Navigator.pushReplacement(
                      context,
                      AppNavigation.route(
                        LoginScreen(),
                      ),
                    );
                  } else {
                    AppToast.show(resOtp.message);
                  }
                }, 
                child: MainButton( 
                  txt: "Verifizieren",
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
    );
  }

  FocusNode getFocusNode() {
//    switch(code.length){
//      case 0: return focusNode1;
//      case 1: return focusNode2;
//      case 2: return focusNode3;
//      case 3: return focusNode4;
//      case 4: return focusNode5;
//      case 5: return focusNode6;
//      case 6: return keyBoard;
//    }
    return keyBoard;
  }

  int backspacedIndex = -1;

  void handleKey(RawKeyEvent event) {
//    print(event);
    if (event.physicalKey == PhysicalKeyboardKey.backspace) {
//      print(code);
//      print(otpList.join());
//      print(backspacedIndex);
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
//                code = code.replaceRange(kkey - 1, kkey, "");
                otpList[kkey - 1] = "";
//                switch (kkey) {
//                  case 1:
//                    FocusScope.of(context).requestFocus(focusNode1);
//                    break;
//                  case 2:
//                    FocusScope.of(context).requestFocus(focusNode2);
//                    break;
//                  case 3:
//                    FocusScope.of(context).requestFocus(focusNode3);
//                    break;
//                  case 4:
//                    FocusScope.of(context).requestFocus(focusNode4);
//                    break;
//                  case 5:
//                    FocusScope.of(context).requestFocus(focusNode5);
//                    break;
//                  case 6:
//                    FocusScope.of(context).requestFocus(focusNode6);
//                    break;
//                }
//                print("replaced $value $code");
              }
            },
            maxLengthEnforced: false,
            textAlign: TextAlign.center,
            cursorColor: Color(0xFFA0A0A0),
            style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 18),
            decoration: InputDecoration(
//              contentPadding: EdgeInsets.only(left: 2.0, right: 2.0),
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
