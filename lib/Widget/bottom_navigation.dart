import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inshape/utils/colors.dart';

import '../TabsPage.dart';

class BottomNav extends StatelessWidget {
  final int index;
  BottomNav({@required this.index});

  final activeColor = AppColors.green;

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
        title: SizedBox(),
        activeIcon: FaIcon(
          FontAwesomeIcons.home,
          color: activeColor,
        ),
        icon: FaIcon(FontAwesomeIcons.home),
      ),
      BottomNavigationBarItem(
        title: SizedBox(),
        activeIcon: FaIcon(
          FontAwesomeIcons.dumbbell,
          color: activeColor,
        ),
        icon: FaIcon(FontAwesomeIcons.dumbbell),
      ),
      BottomNavigationBarItem(
        title: SizedBox(),
        activeIcon: FaIcon(
          FontAwesomeIcons.utensils,
          color: activeColor,
        ),
        icon: FaIcon(FontAwesomeIcons.utensils),
      ),
      BottomNavigationBarItem(
        title: SizedBox(),
        activeIcon: Container(
          child: Image.asset("assets/bahaicol.png"),
        ),
        icon: Container(
          child: Image.asset("assets/bahai.png"),
        ),
      ),
      BottomNavigationBarItem(
        title: SizedBox(),
        activeIcon: FaIcon(
          FontAwesomeIcons.userAlt,
          color: activeColor,
        ),
        icon: FaIcon(FontAwesomeIcons.userAlt),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.primaryBackground,
      items: _navBarsItems(),
      currentIndex: index,
      elevation: 4.0,
      unselectedItemColor: Colors.white,
      selectedItemColor: activeColor,
      onTap: (int i) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (ctx) => TabsPage(
                index: i,
              ),
            ),
            (Route<dynamic> route) => false);
      },
    );
  }
}



