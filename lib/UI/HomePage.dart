//import 'package:flutter/material.dart';
//import 'package:inshape/UI/Fitness/WorkoutScreen.dart';
//import 'package:inshape/UI/Food/DietScreen.dart';
//import 'package:inshape/UI/Menu/ProfileScreen.dart';
//import 'package:inshape/UI/Regeneration/RegenerationScr.dart';
//import 'package:inshape/UI/Trainingsplan/Demo.dart';
//import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
//import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
//import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
//import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  PersistentTabController _controller =
//      PersistentTabController(initialIndex: 0);
//
//  @override
//  Widget build(BuildContext context) {
//    return PersistentTabView(
//      controller: _controller,
//      items: _navBarsItems(),
//      screens: _buildScreens(),
//      showElevation: true,
//      navBarCurve: NavBarCurve.upperCorners,
//      confineInSafeArea: true,
//      handleAndroidBackButtonPress: true,
//      iconSize: 26.0,
//      navBarStyle:
//          NavBarStyle.neumorphic, // Choose the nav bar style with this property
//      backgroundColor: Color(0xff16162B),
//      neumorphicProperties: NeumorphicProperties(
//        curveType: CurveType.flat,
//      ),
//      onItemSelected: (index) {
//        print(index);
//      },
//    );
//  }
//
//  List<Widget> _buildScreens() {
//    return [
//      Demo(),
//      Workoutscreen(),
//      DietScreen(),
//      RegenerationScr(),
//      ProfileScreen(),
//    ];
//  }
//
//  List<PersistentBottomNavBarItem> _navBarsItems() {
//    return [
//      PersistentBottomNavBarItem(
//        icon: FaIcon(FontAwesomeIcons.home),
//        title: ("Home"),
//        activeColor: Color(0xff00F321),
//        inactiveColor: Colors.white,
//        activeContentColor: Color(0xff00F321),
//        isTranslucent: true,
//        translucencyPercentage: 100.0,
//      ),
//      PersistentBottomNavBarItem(
//        icon: FaIcon(FontAwesomeIcons.dumbbell),
//        title: ("Workoutscreen"),
//        activeColor: Color(0xff00F321),
//        inactiveColor: Colors.white,
//        activeContentColor: Color(0xff00F321),
//        isTranslucent: true,
//        translucencyPercentage: 100.0,
//      ),
//      PersistentBottomNavBarItem(
//        icon: FaIcon(FontAwesomeIcons.utensils),
//        title: ("Settings3"),
//        activeColor: Color(0xff00F321),
//        inactiveColor: Colors.white,
//        activeContentColor: Color(0xff00F321),
//        isTranslucent: true,
//        translucencyPercentage: 100.0,
//      ),
//      PersistentBottomNavBarItem(
//        icon: FaIcon(FontAwesomeIcons.bahai),
//        title: ("dumbbell"),
//        activeColor: Color(0xff00F321),
//        inactiveColor: Colors.white,
//        activeContentColor: Color(0xff00F321),
//        isTranslucent: true,
//        translucencyPercentage: 100.0,
//      ),
//      PersistentBottomNavBarItem(
//        icon: FaIcon(FontAwesomeIcons.userAlt),
//        title: ("ProfileScreen"),
//        activeColor: Color(0xff00F321),
//        translucencyPercentage: 100.0,
//        inactiveColor: Colors.white,
//        activeContentColor: Color(0xff00F321),
//        isTranslucent: true,
//      ),
//    ];
//  }
//}
