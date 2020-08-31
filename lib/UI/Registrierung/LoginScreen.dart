import 'dart:convert';
import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Backend/Authentication.dart';
import 'package:inshape/Model/response.dart';
import 'package:inshape/TabsPage.dart';
import 'package:inshape/UI/Registrierung/PasswordReset.dart';
import 'package:inshape/UI/Registrierung/SelectGoal.dart';
import 'package:inshape/UI/Registrierung/VerifyEmail.dart';
import 'package:inshape/UI/Registrierung/WelcomeScreen.dart';
import 'package:inshape/Widget/CustomAppBar.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/data_models/profile.dart';
import 'package:inshape/providers/diet_plans.dart';
import 'package:inshape/providers/goals.dart';
import 'package:inshape/providers/muscle_types.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/providers/quotes.dart';
import 'package:inshape/providers/session.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage;
  var isDeviceConnected = false;
  var subscription;
  RegResponse res;
  Auth auth = Auth();

  String emailError = "Please enter your email address",
      passwordError = "Please enter your password";

  bool validateInput(String email, String password) {
    if (email.isEmpty) {
      errorMessage = 'Enter a email address';
      return false;
    }
    if (!email.contains('@')) {
      errorMessage = 'Email address must contain @';
      return false;
    } else if (password.isEmpty) {
      errorMessage = 'Enter password';
      return false;
    } else {
      return true;
    }
  }

  void performLogin(email, pass) async {
    Provider.of<ProfileProvider>(context, listen: false).isLogin = true;
    await auth.login(email, pass).then((res) async {
      if (res.success) {
        if (SessionProvider.jwt != null) {
          print(SessionProvider.jwt);

          final decodedJSON = json.decode(res.data)["payload"];
          Provider.of<WorkoutProvider>(context, listen: false)
              .pullWorkoutTypesFromJSON(decodedJSON["workoutTypes"]);

          Provider.of<MuscleTypesProvider>(context, listen: false)
              .pullFromJSON(decodedJSON["muscleTypes"]);

          Provider.of<QuotesProvider>(context, listen: false)
              .pullFromJSON(decodedJSON["quotes"]);

          Provider.of<DietPlansProvider>(context, listen: false)
              .pullFromJSON(decodedJSON["dietPlans"]);

          await Provider.of<GoalsProvider>(context, listen: false)
              .pullFromJSON(decodedJSON["goals"]);

          final Profile profile =
              await compute(Profile.getFromJSON, decodedJSON["profile"]);

          print(profile);

          Provider.of<ProfileProvider>(context, listen: false).profile =
              profile;

          hideLoader();
          if (profile == null || profile.age == null) {
            Navigator.pushReplacement(
              context,
              AppNavigation.route(SelectGoal(isLogin: true)),
            );
          } else {
            SessionProvider.setFilledProfile();
            Navigator.pushReplacement(
              context,
              AppNavigation.route(TabsPage(isLogin: true)),
            );
          }
        } else {
          hideLoader();
          print('No account was found matching that username and password');
        }
      } else {
        hideLoader();
        if (res.message.toLowerCase().contains("not") &&
            res.message.toLowerCase().contains("verified")) {
          Navigator.pushReplacement(
            context,
            AppNavigation.route(
              VerifyEmail(
                email: emailController.text,
              ),
            ),
          );
        }
        AppToast.show(res.message);
      }
    });
  }

  Future<bool> checkInternet() {
    return DataConnectionChecker().hasConnection;
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(validateEmail);
    passwordController.addListener(validatePassword);
    checkInternet().then((onValue) {
      isDeviceConnected = onValue;

      setState(() {});
    });

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        isDeviceConnected = await DataConnectionChecker().hasConnection;
      } else {
        isDeviceConnected = false;
      }
      setState(() {});
    });
  }

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
    final password = passwordController.text;
    if (password.length > 1) {
      if (password.length > 6) {
        setState(() {
          passwordError = " ";
        });
      } else {
        setState(() {
          passwordError = "Please enter valid password";
        });
      }
    }
  }

  @override
  void dispose() {
   // subscription.cancle();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  /*This is the custom app bar created in the widget
                   folder naming [CustomAppBar] In this you must return
                   something in extra becouse the CustomAppBar Contains
                   Stack and it cannot be null so if you have
                   noting to return in extra simply return a container */
                  CustomAppBar(
                    barTxt: "Einloggen",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(),
                          ),
                        );
                      },
                    ),
                  ),

                  LayoutBuilder(
                    builder: (ctx, constraint) {
                      return Container(
                        margin: EdgeInsets.only(
                          bottom: size.height * .08,
                        ),
                        height: size.height * .27,
                        child: Image.asset("assets/Logo.png"),
                      );
                    },
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
                                  controller: emailController,
                                  enableSuggestions: false,
                                  enableInteractiveSelection: false,
                                  autocorrect: false,
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
                  SizedBox(
                    height: size.height * .04,
                  ),

                  //TextField 2 Starts Here
                  Container(
                    padding: EdgeInsets.only(
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
                                  enableSuggestions: false,
                                  enableInteractiveSelection: false,
                                  autocorrect: false,
                                  controller: passwordController,
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
                                ),
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
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : SizedBox(),

                  //Text
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordReset(),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: size.height * .02,
                        bottom: size.height * .05,
                      ),
                      child: Text(
                        "Passwort vergessen?".toUpperCase(),
                        style: TextStyle(
                          color: Color(0xFFA0A0A0),
                          fontSize: 11,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (isDeviceConnected) {
                        if (validateInput(
                            emailController.text, passwordController.text)) {
                          showLoader();
                          performLogin(
                              emailController.text, passwordController.text);
                        } else
                          AppToast.show(errorMessage);
                      } else
                        AppToast.show("Please check Internet connection");
                    },
                    child: MainButton(
                      txt: "Einloggen",
                      height: size.height * .065,
                      margin: EdgeInsets.only(
                        top: size.height * .035,
                        left: size.width * .06,
                        right: size.width * .06,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
