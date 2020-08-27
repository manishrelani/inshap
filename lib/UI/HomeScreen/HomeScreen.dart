import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Backend/workout.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Fitness/CalenderScreen.dart';
import 'package:inshape/UI/Trainingsplan/Ownplanscreen.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/Widget/shimmer.dart';
import 'package:inshape/providers/goals.dart';
import 'package:inshape/providers/muscle_types.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/providers/quotes.dart';
import 'package:inshape/providers/training_plan.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/app_translations.dart';
import 'package:inshape/utils/assets.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppTranslations _localization;
  DateTime currentBackPressTime;
  bool armeChecked = false;
  bool chestChecked = false;
  bool shoulderChecked = false;
  bool calvesChecked = false;
  bool ruckenChecked = false;
  bool beineChecked = false;
  bool bauchChecked = false;
  bool isChecked = false;

  var selectedMuscleTypesList = List();
  bool _isLoading;

  @override
  void initState() {
    _isLoading = false;

    super.initState();
  }

  bool _fetchedData = false;

  _fetchWorkouts() async {
    if (Provider.of<WorkoutProvider>(context, listen: false).workouts.length <
        100) {
      print("_fetching workouts data");
      Provider.of<WorkoutProvider>(context, listen: false)
          .pullWorkouts(await WorkoutsAPI.getWorkoutData());
    }
  }

  @override
  Widget build(BuildContext context) {
    _localization = AppTranslations.of(context);
    Provider.of<TrainingPlansProvider>(context, listen: false);
    var totalHeight = MediaQuery.of(context).size.height;
    var totalWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    final profileProvider = Provider.of<ProfileProvider>(context);
    final quotesProvider = Provider.of<QuotesProvider>(context);
    final muscleTypesProvider = Provider.of<MuscleTypesProvider>(context);
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final goalsProvider = Provider.of<GoalsProvider>(context);
    //  print("muscles:- ${muscleTypesProvider.muscleTypes.values}");

    if (!_fetchedData) {
      _fetchedData = true;
      _fetchWorkouts();
    }

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
                "Hey, ${profileProvider.profile == null || profileProvider.profile.fullName == null ? "user" : profileProvider.profile.fullName}",
                style: ThemeText.titleText,
              ),
            ),
            body: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _getQuotesWidget(
                              totalHeight, totalWidth, quotesProvider),
                          SizedBox(
                            height: 24.0,
                          ),
                          Text(
                            _localization?.localeString("Main"),
                            style: ThemeText.titleText,
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          _getRecommendedWidget(totalHeight, totalWidth,
                              profileProvider, goalsProvider),
                          SizedBox(
                            height: totalHeight * 0.03,
                          ),

                          SizedBox(
                            height: totalHeight * 0.03,
                          ),
                          Text(
                            "Bearbeite deinen eigenen Plan",
                            style: ThemeText.titleText,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          _getMaleFemaleBody(),
                          SizedBox(
                            height: 16.0,
                          ),

                          //First Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              // Button 1
                              GestureDetector(
                                onTap: () {
                                  if (!chestChecked) {
                                    selectedMuscleTypesList.add(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[0]
                                            .id);
                                  } else {
                                    selectedMuscleTypesList.remove(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[0]
                                            .id);
                                  }
                                  setState(() {
                                    chestChecked = !chestChecked;
                                  });
                                },
                                child: Container(
                                  height: size.height * .04,
                                  width: size.width * .3,
                                  child: newbutton(
                                      "${muscleTypesProvider.muscleTypes.values.toList()[0].name}",
                                      !chestChecked),
                                ),
                              ),

                              // Button 2
                              GestureDetector(
                                onTap: () {
                                  if (!ruckenChecked) {
                                    selectedMuscleTypesList.add(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[1]
                                            .id);
                                  } else {
                                    selectedMuscleTypesList.remove(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[1]
                                            .id);
                                  }
                                  setState(() {
                                    ruckenChecked = !ruckenChecked;
                                  });
                                },
                                child: Container(
                                  height: size.height * .04,
                                  width: size.width * .3,
                                  child: newbutton(
                                      "${muscleTypesProvider.muscleTypes.values.toList()[1].name}",
                                      !ruckenChecked),
                                ),
                              ),

                              // Button 3
                            ],
                          ),
                          SizedBox(
                            height: totalHeight * 0.03,
                          ),

                          //Second Rw
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              // Button 3
                              GestureDetector(
                                onTap: () {
                                  if (!shoulderChecked) {
                                    selectedMuscleTypesList.add(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[2]
                                            .id);
                                  } else {
                                    selectedMuscleTypesList.remove(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[2]
                                            .id);
                                  }
                                  setState(() {
                                    shoulderChecked = !shoulderChecked;
                                  });
                                },
                                child: Container(
                                  height: size.height * .04,
                                  width: size.width * .3,
                                  child: newbutton(
                                      "${muscleTypesProvider.muscleTypes.values.toList()[2].name}",
                                      !shoulderChecked),
                                ),
                              ),

                              // Button 4
                              GestureDetector(
                                onTap: () {
                                  if (!armeChecked) {
                                    selectedMuscleTypesList.add(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[3]
                                            .id);
                                  } else {
                                    selectedMuscleTypesList.remove(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[3]
                                            .id);
                                  }
                                  setState(() {
                                    armeChecked = !armeChecked;
                                  });
                                },
                                child: Container(
                                  height: size.height * .04,
                                  width: size.width * .3,
                                  child: newbutton(
                                      "${muscleTypesProvider.muscleTypes.values.toList()[3].name}",
                                      !armeChecked),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: totalHeight * 0.03,
                          ),

                          //Third Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              // Button 5
                              GestureDetector(
                                onTap: () {
                                  if (!beineChecked) {
                                    selectedMuscleTypesList.add(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[4]
                                            .id);
                                  } else {
                                    selectedMuscleTypesList.remove(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[4]
                                            .id);
                                  }
                                  setState(() {
                                    beineChecked = !beineChecked;
                                  });
                                },
                                child: Container(
                                  height: size.height * .04,
                                  width: size.width * .3,
                                  child: newbutton(
                                      "${muscleTypesProvider.muscleTypes.values.toList()[4].name}",
                                      !beineChecked),
                                ),
                              ),

                              // Button 6
                              GestureDetector(
                                onTap: () {
                                  if (!bauchChecked) {
                                    selectedMuscleTypesList.add(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[5]
                                            .id);
                                  } else {
                                    selectedMuscleTypesList.remove(
                                        muscleTypesProvider.muscleTypes.values
                                            .toList()[5]
                                            .id);
                                  }
                                  setState(() {
                                    bauchChecked = !bauchChecked;
                                  });
                                },
                                child: Container(
                                  height: size.height * .04,
                                  width: size.width * .3,
                                  child: newbutton(
                                      "${muscleTypesProvider.muscleTypes.values.toList()[5].name}",
                                      !bauchChecked),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: totalHeight * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              // Button 7
                              GestureDetector(
                                onTap: () {
                                  print(selectedMuscleTypesList);
                                  selectedMuscleTypesList.length == 0
                                      ? AppToast.show("Select muscle")
                                      : Navigator.push(
                                          context,
                                          AppNavigation.route(
                                            OwnPlanScreen(
                                              workoutTypes: workoutProvider
                                                  .workoutTypes.values
                                                  .toList(),
                                              muscle: selectedMuscleTypesList,
                                            ),
                                          ),
                                        );
                                },
                                child: Container(
                                  height: size.height * .09,
                                  width: size.width * 0.9,
                                  child: MainButton(
                                    txt: "Weiter",
                                    height: size.height * .065,
                                    margin: EdgeInsets.only(
                                      top: size.height * .035,
                                      left: size.width * .06,
                                      right: size.width * .06,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: totalHeight * 0.04,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }

  _getMaleFemaleBody() {
    return Container(
      height: 275,
      // color: Colors.red,
      width: 275,
      child: LayoutBuilder(
        builder: (context, constrain) {
          return Stack(
            children: <Widget>[
              Container(
                child: Image.asset(AppAssets.full_body),
              ),
              chestChecked ? Image.asset(AppAssets.chest) : SizedBox(),
              beineChecked ? Image.asset(AppAssets.beine) : SizedBox(),
              bauchChecked ? Image.asset(AppAssets.bauch) : SizedBox(),
              ruckenChecked ? Image.asset(AppAssets.rucken) : SizedBox(),
              shoulderChecked ? Image.asset(AppAssets.schultern) : SizedBox(),
              armeChecked ? Image.asset(AppAssets.arm) : SizedBox(),
            ],
          );
        },
      ),
    );
  }

  Widget _getQuotesWidget(
      double totalHeight, double totalWidth, QuotesProvider quotesProvider) {
    return SizedBox(
      height: 160.0,
      child: PageIndicatorContainer(
        length: 3,
        child: PageView(
          children: List.generate(
            quotesProvider.quotes.length,
            (index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 32.0),
                height: 140.0,
                width: totalWidth,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF3A3A5A).withOpacity(0.3),
                        offset: Offset(-6.0, -6.0),
                        blurRadius: 8.0,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(6.0, 6.0),
                        blurRadius: 8.0,
                      ),
                    ],
                    color: Color(0xFF16162B),
                    borderRadius: BorderRadius.circular(20.0)),
                child:
                    boxText(quotesProvider.quotes.values.toList()[index].text),
              );
            },
          ),
        ),
        align: IndicatorAlign.bottom,
        indicatorSpace: 20.0,
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        indicatorColor: Colors.grey,
        indicatorSelectorColor: Colors.white,
        shape: IndicatorShape.circle(size: 8.0),
      ),
    );
  }

  Widget newbutton(txt, mode) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      child: mode
          ? Neumorphic(
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  txt,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              style: NeumorphicStyle(
                color: Color(0xFF16162B),
                depth: 4,
                shadowLightColor: Color(0xFF2B2B41),
                shadowDarkColor: Color(0xFF0A0A14),
              ),
            )
          : Neumorphic(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
              style: NeumorphicStyle(
                depth: -5,
                color: Color(0xFF16162B),
                shadowDarkColor: Color(0xFF0A0A14),
                shadowDarkColorEmboss: Color(0xFF0A0A14),
                shadowLightColorEmboss: AppColors.shadowLightColor,
              ),
              child: Center(
                child: Text(
                  txt,
                  style: TextStyle(color: AppColors.green, fontSize: 13),
                ),
              ),
            ),
    );
  }

  Widget boxText(var text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: ThemeText.boxTextWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRecommendedWidget(double totalHeight, double totalWidth,
      ProfileProvider profileProvider, GoalsProvider goalsProvider) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          AppNavigation.route(
            CalenderScreen(
              day: 1,
            ),
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Container(
            height: totalHeight * 0.26,
            width: totalWidth,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF74747C).withOpacity(0.2),
                  offset: Offset(-6.0, -6.0),
                  blurRadius: 16.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(6.0, 6.0),
                  blurRadius: 16.0,
                ),
              ],
              borderRadius: BorderRadius.circular(12.0),
              color: Color(0xFF16162B),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                  placeholder: (context, data) => AppShimmer(
                        height: totalHeight * 0.26,
                        width: totalWidth,
                      ),
                  fit: BoxFit.cover,
                  imageUrl: goalsProvider.goals[profileProvider.profile.goal].thumbnailUrl == null ? "https://images.unsplash.com/photo-1434682881908-b43d0467b798?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=753&q=80" :  goalsProvider.goals[profileProvider.profile.goal].thumbnailUrl ),
            ),
          ),
          Container(
            height: totalHeight * 0.26,
            width: totalWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.black38,
            ),
          ),
          Positioned(
            top: 8.0,
            left: 8.0,
            right: 8.0,
            child: Wrap(
              children: <Widget>[
                Text(
                  " ${goalsProvider.goals[profileProvider.profile.goal].name} ${profileProvider.profile.workoutFrequency} Tage die woche",
                  style: ThemeText.titleText,
                )
              ],
            ),
          ),
        ],
      ),
    );
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
