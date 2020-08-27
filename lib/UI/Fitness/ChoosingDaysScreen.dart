import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Backend/ApiData.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/Model/training.dart';
import 'package:inshape/UI/Fitness/CalenderScreen.dart';
import 'package:inshape/UI/Trainingsplan/FavouriteScreen.dart';
import 'package:inshape/Widget/bottom_navigation.dart';
import 'package:inshape/utils/app_translations.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';

class ChoosingDaysScreen extends StatefulWidget {
  @override
  _ChoosingDaysScreenState createState() => _ChoosingDaysScreenState();
}

class _ChoosingDaysScreenState extends State<ChoosingDaysScreen> {
  AppTranslations _localization;
  Training training;
  ApiData apiData;
  List planArray;

  @override
  void initState() {
    super.initState();
  }

  List daysImages = [
    'assets/Days/1.png',
    'assets/Days/2.png',
    'assets/Days/3.png',
    'assets/Days/4.png',
    'assets/Days/5.png',
    'assets/Days/6.png',
  ];

  @override
  Widget build(BuildContext context) {
     _localization = AppTranslations.of(context);
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        bottomNavigationBar: BottomNav(index: 1),
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
            _localization.localeString("building_muscle"),
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: AppColors.green,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(AppNavigation.route(FavouriteScreen()));
              },
            )
          ],
        ),
        body: _getBody2(width),
      ),
    );
  }

  Widget _getBody2(double width) {
    final size = width * 0.40;
    List<Widget> children = [];

    children.addAll(
      List.generate(
        5,
        (index) => customBox(index + 2, size),
      ),
    );

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runSpacing: 32.0,
            spacing: 32.0,
            children: children,
          ),
        ),
      ),
    );
  }

  void handleTap() {}

  Widget customBox(int day, double size) {
    return NeumorphicButton(
      margin: const EdgeInsets.all(0.0),
      padding: const EdgeInsets.all(0.0),
      onPressed: () {
        print(day);
        Navigator.push(
          context,
          AppNavigation.route(
            CalenderScreen(
              day: 1,
              trainingPeriod: day,
            ),
          ),
        );
      },
      drawSurfaceAboveChild: false,
      style: NeumorphicStyle(
        depth: 2.0,
        lightSource: LightSource.bottomRight,
         shadowLightColor: Colors.grey,
        color: Colors.transparent, 
        shape: NeumorphicShape.flat,
      ),
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16.0)),
      child: Card(
        clipBehavior: Clip.antiAlias, 
        margin: const EdgeInsets.all(0.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          elevation: 16.0,
        shadowColor: Colors.black38,
         color: Colors.grey.withOpacity(0.4),    
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: <Widget>[
               Positioned.fill(
                  top: 16.0,
                  child:Image(
                           fit: BoxFit.contain,  
                           width: 150.0,
                              height: 150.0, 
                            image: AssetImage("assets/Days/$day.png"),    
                          ),
                  ),
                
                    
              
              Positioned(
                top: 16.0,
                left: 16.0,
                child: Text(
                  "$day ${_localization.localeString("days")}",
                  style: ThemeText.planeWhiteText.apply(
                    fontSizeFactor: 1.25,
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
