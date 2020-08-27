import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inshape/Backend/ApiData.dart';
import 'package:inshape/TabsPage.dart';
import 'package:inshape/UI/Registrierung/SelectGoal.dart';
import 'package:inshape/UI/Registrierung/WelcomeScreen.dart';
import 'package:inshape/data_models/MusleType.dart';
import 'package:inshape/data_models/diet_plans.dart';
import 'package:inshape/data_models/goal.dart';
import 'package:inshape/data_models/profile.dart';
import 'package:inshape/data_models/quotes.dart';
import 'package:inshape/data_models/workout_type.dart';
import 'package:inshape/providers/diet_plans.dart';
import 'package:inshape/providers/goals.dart';
import 'package:inshape/providers/muscle_types.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/providers/quotes.dart';
import 'package:inshape/providers/session.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/assets.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  static const route = "/";

  checkLogin(BuildContext context) async {
    final loggedIN = await SessionProvider.init();
    debugPrint("User logged in: $loggedIN");

    /// Replacing current screen
    if (loggedIN) {
      final filledProfile = await SessionProvider.isProfileFilled();

      if (filledProfile) {
        /// Pushing to TabsPage i.e., Main page
        Navigator.of(context).pushReplacement(
          AppNavigation.route(
            TabsPage(),
          ),
        );
      } else {
        /// Pushing to InitiatingScreen i.e., Setup things
        _fetchDashboard(context);
      }
    } else {
      Navigator.of(context).pushReplacement(
        AppNavigation.route(
          WelcomeScreen(),
        ),
      );
    }
  }

  bool _dashBoardFetched = false;

  Future<void> _fetchDashboard(BuildContext context) async {
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
      debugPrint("dietPlansMap length: ${dietPlansMap.length}");

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

//        Provider.of<ProfileProvider>(context, listen: false).isWL = false;
//        Provider.of<ProfileProvider>(context, listen: false).isQL = false;
//        Provider.of<ProfileProvider>(context, listen: false).isML = false;
      } catch (err) {
        print(err);
      }

      Navigator.of(context).pushReplacement(
        AppNavigation.route(
          SelectGoal(),
        ),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkLogin(context);
    });

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          height: 150.0,
        ),
      ),
    );
  }
}
