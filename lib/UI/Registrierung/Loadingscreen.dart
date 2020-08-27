import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/TabsPage.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LoadingScreen extends StatefulWidget {
  final bool isLogin;

  const LoadingScreen({Key key, this.isLogin = false}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController _controller;
  String i;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(_controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation objects value
          i = animation.value.toStringAsFixed(0);
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var totalHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Super !\nDein Plan wird erstellt.",
                  textAlign: TextAlign.center,
                  style: ThemeText.loadingScreenText,
                ),
                Neumorphic(
                    padding: EdgeInsets.all(25.0),
                    boxShape: NeumorphicBoxShape.circle(),
                    style: NeumorphicStyle(
                      depth: 8,
                      oppositeShadowLightSource: false,
                      color: Color(0xFF16162B),
                      disableDepth: true,
                    ),
                    child: Neumorphic(
                      boxShape: NeumorphicBoxShape.circle(),
                      style: NeumorphicStyle(
                        depth: -8,
                        oppositeShadowLightSource: false,
                        color: Color(0xFF16162B),
                        shadowDarkColorEmboss: Color(0xFF29293A),
                        shadowDarkColor: Colors.orange,
                        shadowLightColor: Colors.yellow,
                        shadowLightColorEmboss: Color(0xFF333344),
                      ),
                      child: SizedBox(
                        height: size.height * .5,
                        width: size.width * .8,
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              CircularPercentIndicator(
                                radius: 200.0,
                                lineWidth: 13.0,
                                animation: true,
                                animationDuration: 3000,
                                percent: 1,
                                addAutomaticKeepAlive: true,
                                animateFromLastPercent: true,
                                backgroundColor:
                                    Color(0xFF1F1F38).withOpacity(0.3),
                                progressColor: AppColors.green,
                                center: Text(
                                  "$i%",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    // shadows: [
                                    //   Shadow(
                                    //       offset: Offset(3, 3),
                                    //       color: Colors.black38,
                                    //       blurRadius: 10),
                                    //   Shadow(
                                    //       offset: Offset(-3, -3),
                                    //       color: Colors.white.withOpacity(0.4),
                                    //       blurRadius: 10)
                                    // ],
                                    color: AppColors.green,
                                  ),
                                ),
                              ),
                              CircularPercentIndicator(
                                radius: 235.0,
                                lineWidth: 5.0,
                                animation: true,
                                animationDuration: 3000,
                                percent: 1,
                                addAutomaticKeepAlive: true,
                                animateFromLastPercent: true,
                                backgroundColor:
                                    Color(0xFF1F1F38).withOpacity(0.3),
                                progressColor: AppColors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      AppNavigation.route(
                        TabsPage(
                          isLogin: widget.isLogin,
                        ),
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
                            "Weiter",
                            style: ThemeText.greenButtonTextStyle,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
