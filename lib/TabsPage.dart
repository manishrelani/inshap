import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inshape/Backend/ApiData.dart';
import 'package:inshape/UI/Food/NutritionScreen.dart';
import 'package:inshape/UI/HomeScreen/HomeScreen.dart';
import 'package:inshape/UI/Menu/ProfileScreen.dart';
import 'package:inshape/UI/Regeneration/RegenerationScr.dart';
import 'package:inshape/UI/Registrierung/SelectGoal1.dart';
import 'package:inshape/data_models/MusleType.dart';
import 'package:inshape/data_models/diet_plans.dart';
import 'package:inshape/data_models/goal.dart'; 
import 'package:inshape/data_models/profile.dart';
import 'package:inshape/data_models/quotes.dart';
import 'package:inshape/data_models/workout_type.dart';
import 'package:inshape/providers/diet_plans.dart';
import 'package:inshape/providers/favourites.dart';
import 'package:inshape/providers/goals.dart';
import 'package:inshape/providers/muscle_types.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/providers/quotes.dart';
import 'package:inshape/providers/recepie.dart';
import 'package:inshape/providers/recipe_favourite.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/toast.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  static const route = "TabsPage";
  final index;
  final bool isLogin;

  const TabsPage({Key key, this.isLogin = false, this.index}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentScreen = 0;

  final PageStorageBucket _bucket = PageStorageBucket();
  bool _dashBoardFetched = false;

  @override
  void initState() {
    setState(() {
      _currentScreen = widget.index == null ? 0 : widget.index;
    });
    super.initState();
    _fetchDashboard();
  }

  _fetchDashboard() async {
//    if (widget.isLogin) {
//      await Future.delayed(Duration(milliseconds: 50));
//      Provider.of<ProfileProvider>(context, listen: false).isWL = false;
//      Provider.of<ProfileProvider>(context, listen: false).isQL = false;
//      Provider.of<ProfileProvider>(context, listen: false).isML = false;
//      return;
//    }
    if (!_dashBoardFetched
//        && !widget.isLogin
        ) {
      debugPrint(
          'fetching dashboard data as flow is not login, mounted: $mounted');
      _dashBoardFetched = true;
      final response = await ApiData.getDashboard();
      final decoded = json.decode(response);
      if (decoded['error'] == true) {
        AppToast.show('Unable to load dashboard data');
        debugPrint(decoded['message']);
        return;
      }
      final goalsMap =
          await compute(Goal.getGoalsMapFromJSON, decoded['payload']['goals']);
      debugPrint("goalsMap length: ${goalsMap.length}");

      final quotesMap =
          await compute(Quote.fromJSONList, decoded['payload']['quotes']);
      debugPrint("quotesMap length: ${quotesMap.length}");

      final dietPlansMap =
          await compute(DietPlan.fromJSONList, decoded['payload']['dietPlans']);
      debugPrint("dietPlansMap-- length: ${dietPlansMap.length}");

      final muscleTypesMap = await compute(
          MuscleType.fromJSONList, decoded["payload"]["muscleTypes"]);
      debugPrint("muscleTypesMap length: ${muscleTypesMap.length}");

      final workoutTypesMap = await compute(
          WorkoutType.fromJSONList, decoded['payload']['workoutTypes']);
      debugPrint("WorkoutTypes length: ${workoutTypesMap.length}");

      final profile =
          await compute(Profile.getFromJSON, decoded['payload']['profile']);

      try {
        Provider.of<ProfileProvider>(context, listen: false).profile = profile;
        Provider.of<GoalsProvider>(context, listen: false).goals = goalsMap;
        Provider.of<QuotesProvider>(context, listen: false).quotes = quotesMap;
        Provider.of<DietPlansProvider>(context, listen: false).dietPlans =
            dietPlansMap;
        Provider.of<MuscleTypesProvider>(context, listen: false).muscleTypes =
            muscleTypesMap;
        Provider.of<WorkoutProvider>(context, listen: false).workoutTypes =
            workoutTypesMap;

        Provider.of<ProfileProvider>(context, listen: false).isWL = false;
        Provider.of<ProfileProvider>(context, listen: false).isQL = false;
        Provider.of<ProfileProvider>(context, listen: false).isML = false;
      } catch (err) {
        //print(err);
      }
    }
  }

  List<Widget> _buildScreens = [
    HomeScreen(
      key: PageStorageKey('home-screen'),
    ),
    SelectGoal1(
      key: PageStorageKey('goal-screen'),
    ),
    NutritionScreen(
      key: PageStorageKey('Nutrition-screen'),
    ),
    // DietScreen(
    //     key: PageStorageKey('diet-screen')
    // ),
    RegenerationScr(
      key: PageStorageKey('regeneration-screen'),
    ),
    ProfileScreen(
      key: PageStorageKey('profile-screen'),
    ),
  ];

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
    final provider = Provider.of<ProfileProvider>(context);
    Provider.of<RecepiesProvider>(context, listen: false);
    Provider.of<FavouritesProvider>(context, listen: false);
    Provider.of<RecipeFavouritesProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: (provider.isWL || provider.isQL || provider.isML)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PageStorage(
              bucket: _bucket,
              child: _buildScreens[_currentScreen],
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primaryBackground,
        items: _navBarsItems(),
        currentIndex: _currentScreen,
        elevation: 4.0,
        unselectedItemColor: Colors.white,
        selectedItemColor: activeColor,
        onTap: (int i) {
          setState(() {
            _currentScreen = i;
          });
        },
      ),
    );
  }
}
