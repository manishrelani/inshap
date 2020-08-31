import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inshape/Model/response.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/TabsPage.dart';
import 'package:inshape/UI/Menu/GalleryScreen.dart';
import 'package:inshape/UI/Menu/SettingsScreen.dart';
import 'package:inshape/Widget/ProfileDropDouwnButton.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/providers/session.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/toast.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image;
  final picker = ImagePicker();
  bool isLoading = false;
  var url = 'https://inshape-api.cadoangelus.me/profile/upload/avatar';

  getCameraImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
      if (_image != null) {
        uploadAvatar(pickedFile.path);
      }
    });
  }

  Future getGalleryImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
      if (_image != null) {
        uploadAvatar(pickedFile.path);
      }
    });
  }

  Future<bool> selectOption() async {
    return (await showDialog(
            context: context,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: CupertinoAlertDialog(
                title: Text("Select Image Option"),
                content: Container(
                  margin: EdgeInsets.only(top: 5),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        getCameraImage();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Camera",
                        style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontWeight: FontWeight.normal),
                      )),
                  CupertinoDialogAction(
                      textStyle: TextStyle(color: Colors.red),
                      isDefaultAction: true,
                      onPressed: () async {
                        getGalleryImage();
                        Navigator.pop(context);
                      },
                      child: Text("Gallery",
                          style: TextStyle(
                              color: Color(0xFF007AFF),
                              fontWeight: FontWeight.normal))),
                ],
              ),
            ))) ??
        false;
  }

  bool firstPress = false, secondPress = false;
  DateTime currentBackPressTime;

  RegResponse res;

  //text color Highlight
  bool firstColor = false;
  bool secondColor = false;
  bool thirdColor = false;
  bool fourthColor = false;
  bool fifthColor = false;
  bool sixthColor = false;
  bool seventh = false;
  bool eightColor = false;
  bool nineColor = false;
  bool tenColor = false;
  var isDeviceConnected = false;
  var subscription;

  Future<bool> checkInternet() {
    return DataConnectionChecker().hasConnection;
  }

  @override
  void initState() {
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
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancle();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var totalHeight = MediaQuery.of(context).size.height;
    var totalWeight = MediaQuery.of(context).size.width;
    var minVerticalPadding = MediaQuery.of(context).size.height * 0.02;
    final profile = Provider.of<ProfileProvider>(context).profile;
    final temp = Provider.of<ProfileProvider>(context);
    final avtarUrl = (Provider.of<ProfileProvider>(context).profile.avtarUrl);
    // final gallery = Provider.of<ProfileProvider>(context).profile.gallery;
    // final goalsProvider = Provider.of<GoalsProvider>(context);
    // final dietsProvider = Provider.of<DietPlansProvider>(context);

    return WillPopScope(
      onWillPop: () async => onWillPop(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              "Mein Profil",
              textAlign: TextAlign.center,
              style: ThemeText.titleText,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: AppColors.green,
                    size: 26.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileSettings(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: <Widget>[
                    SizedBox(
                      height: minVerticalPadding - 3,
                    ),
                    CircularProfileAvatar(
                      "",
                      child: avtarUrl == null
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1584380931214-dbb5b72e7fd0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=387&q=80',
                            )
                          : CachedNetworkImage(
                              imageUrl: avtarUrl,
                              fit: BoxFit.fill,
                            ),
                      borderColor: Colors.transparent,
                      borderWidth: 0.0,
                      elevation: 4.0,
                      foregroundColor: Colors.green,
                      radius: 68,
                      backgroundColor: AppColors.primaryBackground,
                      onTap: selectOption,
                    ),
                    SizedBox(
                      height: minVerticalPadding,
                    ),
                    Text(
                      "${profile.fullName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        letterSpacing: 0.75,
                      ),
                    ),
                    SizedBox(
                      height: minVerticalPadding,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Laufende Programme",
                        style: ThemeText.greenPlaneTextStyle,
                      ),
                    ),
                    SizedBox(height: minVerticalPadding),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        height: 0.75,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFF373742),
                      ),
                    ),
                    SizedBox(height: minVerticalPadding),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (firstPress == true) {
                            firstPress = false;
                          } else if (firstPress == false) {
                            firstPress = true;
                          }
                        });
                        print("First press");
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: totalHeight * 0.072,
                        width: totalWeight,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF74747C).withOpacity(0.1),
                              offset: Offset(-6.0, -6.0),
                              blurRadius: 16.0,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: Offset(6.0, 6.0),
                              blurRadius: 16.0,
                            ),
                          ],
                          color: Color(0xFF16162B),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Muskeln aufbauen",
                                  //"${goalsProvider.goals[profile.goal].name}",
                                  style: ThemeText.planeWhiteText),
                              firstPress
                                  ? RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(Icons.arrow_forward_ios,
                                          color: Colors.white))
                                  : Icon(Icons.arrow_forward_ios,
                                      color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                    firstPress
                        ? SizedBox(height: minVerticalPadding)
                        : Container(),
                    firstPress
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                ProfileDropDouwnButton(
                                  firstButton: "Inshape",
                                  secondButton: "Definieren",
                                  firstColor: firstColor == true
                                      ? Color(0xffc8b375)
                                      : Colors.white,
                                  firstTab: () {
                                    setState(() {
                                      print("Profile");
                                      print("${temp.profile.workoutTypes}");

                                      firstColor = true;
                                      secondColor = false;
                                      thirdColor = false;
                                      fourthColor = false;
                                      fifthColor = false;
                                      sixthColor = false;
                                      seventh = false;
                                      eightColor = false;
                                      nineColor = false;
                                      tenColor = false;
                                    });
                                  },
                                  secondColor: secondColor == true
                                      ? Color(0xffc8b375)
                                      : Colors.white,
                                  secondTab: () {
                                    setState(() {
                                      print("second true");
                                      firstColor = false;
                                      secondColor = true;
                                      thirdColor = false;
                                      fourthColor = false;
                                      fifthColor = false;
                                      sixthColor = false;
                                      seventh = false;
                                      eightColor = false;
                                      nineColor = false;
                                      tenColor = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ProfileDropDouwnButton(
                                  firstButton: "Abnehmen",
                                  secondButton: "Muskeln aufbauen",
                                  firstColor: thirdColor == true
                                      ? Color(0xffc8b375)
                                      : Colors.white,
                                  secondColor: fourthColor == true
                                      ? Color(0xffc8b375)
                                      : Colors.white,
                                  firstTab: () {
                                    setState(() {
                                      firstColor = false;
                                      secondColor = false;
                                      thirdColor = true;
                                      fourthColor = false;
                                      fifthColor = false;
                                      sixthColor = false;
                                      seventh = false;
                                      eightColor = false;
                                      nineColor = false;
                                      tenColor = false;
                                    });
                                  },
                                  secondTab: () {
                                    setState(() {
                                      firstColor = false;
                                      secondColor = false;
                                      thirdColor = false;
                                      fourthColor = true;
                                      fifthColor = false;
                                      sixthColor = false;
                                      seventh = false;
                                      eightColor = false;
                                      nineColor = false;
                                      tenColor = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 1.0,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(height: minVerticalPadding),
                    GestureDetector(
                      onTap: () {
                        print("Second press");
                        setState(() {
                          if (secondPress == true) {
                            secondPress = false;
                          } else if (secondPress == false) {
                            secondPress = true;
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: totalHeight * 0.072,
                        width: totalWeight,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF74747C).withOpacity(0.1),
                              offset: Offset(-6.0, -6.0),
                              blurRadius: 16.0,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: Offset(6.0, 6.0),
                              blurRadius: 16.0,
                            ),
                          ],
                          color: Color(0xFF16162B),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ernährungsplan",
                                  //"${dietsProvider.dietPlans[profile.dietPlan].name}",
                                  style: ThemeText.planeWhiteText),
                              secondPress
                                  ? RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(Icons.arrow_forward_ios,
                                          color: Colors.white))
                                  : Icon(Icons.arrow_forward_ios,
                                      color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: minVerticalPadding),
                    secondPress
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                ProfileDropDouwnButton(
                                  firstButton: "Mischkost",
                                  secondButton: "Vegetarisch",
                                  firstColor: fifthColor == true
                                      ? Color(0xffc8b375)
                                      : Colors.white,
                                  secondColor: sixthColor == true
                                      ? Color(0xffc8b375)
                                      : Colors.white,
                                  firstTab: () {
                                    setState(() {
                                      firstColor = false;
                                      secondColor = false;
                                      thirdColor = false;
                                      fourthColor = false;
                                      fifthColor = true;
                                      sixthColor = false;
                                      seventh = false;
                                      eightColor = false;
                                      nineColor = false;
                                      tenColor = false;
                                    });
                                  },
                                  secondTab: () {
                                    setState(() {
                                      firstColor = false;
                                      secondColor = false;
                                      thirdColor = false;
                                      fourthColor = false;
                                      fifthColor = false;
                                      sixthColor = true;
                                      seventh = false;
                                      eightColor = false;
                                      nineColor = false;
                                      tenColor = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ProfileDropDouwnButton(
                                  firstButton: "Vegan",
                                  secondButton: "Fisch",
                                  firstColor: seventh == true
                                      ? Color(0xffc8b375)
                                      : Colors.white,
                                  secondColor: eightColor == true
                                      ? Color(0xffc8b375)
                                      : Colors.white,
                                  firstTab: () {
                                    setState(() {
                                      firstColor = false;
                                      secondColor = false;
                                      thirdColor = false;
                                      fourthColor = false;
                                      fifthColor = false;
                                      sixthColor = false;
                                      seventh = true;
                                      eightColor = false;
                                      nineColor = false;
                                      tenColor = false;
                                    });
                                  },
                                  secondTab: () {
                                    setState(() {
                                      firstColor = false;
                                      secondColor = false;
                                      thirdColor = false;
                                      fourthColor = false;
                                      fifthColor = false;
                                      sixthColor = false;
                                      seventh = false;
                                      eightColor = true;
                                      nineColor = false;
                                      tenColor = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ProfileDropDouwnButton(
                                  firstButton: "Geflügel",
                                  secondButton: "Paelo",
                                  firstColor: nineColor == true
                                      ? Color(0xffc8b375)
                                      : Colors.white,
                                  secondColor: tenColor == true
                                      ? Color(0xffc8b375)
                                      : Colors.white,
                                  firstTab: () {
                                    setState(() {
                                      firstColor = false;
                                      secondColor = false;
                                      thirdColor = false;
                                      fourthColor = false;
                                      fifthColor = false;
                                      sixthColor = false;
                                      seventh = false;
                                      eightColor = false;
                                      nineColor = true;
                                      tenColor = false;
                                    });
                                  },
                                  secondTab: () {
                                    setState(() {
                                      firstColor = false;
                                      secondColor = false;
                                      thirdColor = false;
                                      fourthColor = false;
                                      fifthColor = false;
                                      sixthColor = false;
                                      seventh = false;
                                      eightColor = false;
                                      nineColor = false;
                                      tenColor = true;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 1.0,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: minVerticalPadding + 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Ziele",
                        style: ThemeText.greenPlaneTextStyle,
                      ),
                    ),
                    SizedBox(height: minVerticalPadding + 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        height: 0.75,
                        width: totalWeight,
                        color: Color(0xFF373742),
                      ),
                    ),
                    SizedBox(height: minVerticalPadding - 4),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("Anfangsgewicht",
                              style: ThemeText.planeWhiteText),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: totalHeight * 0.072,
                            width: 100,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: totalWeight * 0.18,
                                  child: Neumorphic(
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(12.0)),
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      lightSource: LightSource.topLeft,
                                      color: Color(0xff16162B),
                                      shadowDarkColor: Colors.black,
                                      shadowLightColor: Color(0xFF2F2F4E),
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text("${profile.age}",
                                          style: ThemeText.greenPlaneTextStyle),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text("kg", style: ThemeText.planeWhiteText),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: minVerticalPadding - 4),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: totalHeight * 0.072,
                      width: totalWeight,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF74747C).withOpacity(0.1),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                        color: Color(0xFF16162B),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: <Widget>[
                            Text("Zielgewicht",
                                style: ThemeText.planeWhiteText),
                            Spacer(),
                            Container(
                              width: 100,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: totalWeight * 0.18,
                                    child: Neumorphic(
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(12.0)),
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          lightSource: LightSource.topLeft,
                                          color: Color(0xff16162B),
                                          shadowDarkColor: Colors.black,
                                          shadowLightColor: Color(0xFF2F2F4E),
                                        ),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text("${profile.weight}",
                                              style: ThemeText
                                                  .greenPlaneTextStyle),
                                        )),
                                  ),
                                  Spacer(),
                                  Text("kg", style: ThemeText.planeWhiteText),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: minVerticalPadding + 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Ziele",
                        style: ThemeText.greenPlaneTextStyle,
                      ),
                    ),
                    SizedBox(height: minVerticalPadding + 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        height: 0.75,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFF373742),
                      ),
                    ),
                    SizedBox(height: minVerticalPadding),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: totalHeight * 0.072,
                      width: totalWeight,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF74747C).withOpacity(0.1),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                        color: Color(0xFF16162B),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: <Widget>[
                            Text("Trainingsintervalle pro Woche",
                                style: ThemeText.planeWhiteText),
                            Spacer(),
                            Container(
                              width: 100,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: totalWeight * 0.18,
                                    child: Neumorphic(
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(12.0)),
                                      style: NeumorphicStyle(
                                        shape: NeumorphicShape.flat,
                                        lightSource: LightSource.topLeft,
                                        color: Color(0xff16162B),
                                        shadowDarkColor: Colors.black,
                                        shadowLightColor: Color(0xFF2F2F4E),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                            "${profile.workoutFrequency}",
                                            style:
                                                ThemeText.greenPlaneTextStyle),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: minVerticalPadding),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: totalHeight * 0.072,
                      width: totalWeight,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF74747C).withOpacity(0.1),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                        color: Color(0xFF16162B),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              //width: totalWeight * 0.18,
                              child: Neumorphic(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(12.0)),
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  lightSource: LightSource.topLeft,
                                  color: Color(0xff16162B),
                                  shadowDarkColor: Colors.black,
                                  shadowLightColor: Color(0xFF2F2F4E),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text("02.03.2015",
                                        style: ThemeText.greenPlaneTextStyle),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: minVerticalPadding * 2),
                    GestureDetector(
                      onTap: () {
                        //  print("Button Press");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GalleryScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Container(
                          height: totalHeight * 0.072,
                          child: Neumorphic(
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Gallerie",
                                style: ThemeText.greenButtonTextStyle,
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
                    SizedBox(
                      height: totalHeight * 0.04,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  uploadAvatar(String filename) async {
    if (isDeviceConnected) {
      //  print("Info Data");
      setState(() {
        isLoading = true;
      });
      try {
        var headers = {
          'accept': "application/json",
          'Cookie': SessionProvider.jwt,
          'Content-Type': 'multipart/form-data'
        };
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.headers.addAll(headers);
        request.files
            .add(await http.MultipartFile.fromPath('avatar', filename));
        var res = await request.send();

        print("res: ${res.reasonPhrase}");
        if (res.reasonPhrase == "OK") {
          AppToast.show('Profile Updated');
          Timer(Duration(seconds: 1), () {
            setState(() {
              isLoading = false;
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TabsPage()));
            });
          });
        } else {
          setState(() {
            isLoading = false;

            AppToast.show('Error To upload');
          });
        }
      } catch (e) {
        print(e.toString());
        AppToast.show('something went wrong ${e.toString}');
      }
    } else
      AppToast.show('Please Check internet connection');
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      //Fluttertoast.showToast(msg:"Press again to Exit...");
      var snakbar = SnackBar(content: Text("Press again to Exit..."));
      Scaffold.of(context).showSnackBar(snakbar);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
