import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Fitness/AddWorkout/SelectWorkoutsToAdd.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/Widget/bottom_navigation.dart';
import 'package:inshape/data_models/workout_type.dart';
import 'package:inshape/providers/muscle_types.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/app_translations.dart';
import 'package:inshape/utils/assets.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'package:provider/provider.dart';

class InitAddOwnWorkouts extends StatefulWidget {
  final String trainingPlanId;
  final int day;

  const InitAddOwnWorkouts({Key key, this.trainingPlanId, this.day})
      : super(key: key);

  @override
  _InitAddOwnWorkoutsState createState() => _InitAddOwnWorkoutsState();
}

class _InitAddOwnWorkoutsState extends State<InitAddOwnWorkouts> {
  AppTranslations _localization;
  bool isPressed1 = true;
  bool isPressed2 = true;
  bool isPressed3 = true;
  List<String> selectedWorkouts = [];

  bool armeChecked = false;
  bool chestChecked = false;
  bool bauchChecked = false;
  bool shoulderChecked = false;
  bool ruckenChecked = false;
  bool beineChecked = false;

  List<String> selectedMuscleTypesList = [];

  @override
  Widget build(BuildContext context) {
    _localization = AppTranslations.of(context);
    var totalHeight = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    final workoutsProvider = Provider.of<WorkoutProvider>(context);
    final muscleTypesProvider = Provider.of<MuscleTypesProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      bottomNavigationBar: BottomNav(index: 1),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        title: Text(_localization.localeString("OverView")),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                _workoutTypes(
                    workoutsProvider.workoutTypes.values.toList(), size),
                SizedBox(
                  height: 8.0,
                ),
                Divider(
                  thickness: 1.5,
                  color: AppColors.green,
                ),
                SizedBox(
                  height: 8.0,
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
                          selectedMuscleTypesList.add(muscleTypesProvider
                              .muscleTypes.values
                              .toList()[0]
                              .id);
                        } else {
                          selectedMuscleTypesList.remove(muscleTypesProvider
                              .muscleTypes.values
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
                          selectedMuscleTypesList.add(muscleTypesProvider
                              .muscleTypes.values
                              .toList()[1]
                              .id);
                        } else {
                          selectedMuscleTypesList.remove(muscleTypesProvider
                              .muscleTypes.values
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
                          selectedMuscleTypesList.add(muscleTypesProvider
                              .muscleTypes.values
                              .toList()[2]
                              .id);
                        } else {
                          selectedMuscleTypesList.remove(muscleTypesProvider
                              .muscleTypes.values
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
                          selectedMuscleTypesList.add(muscleTypesProvider
                              .muscleTypes.values
                              .toList()[3]
                              .id);
                        } else {
                          selectedMuscleTypesList.remove(muscleTypesProvider
                              .muscleTypes.values
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
                          selectedMuscleTypesList.add(muscleTypesProvider
                              .muscleTypes.values
                              .toList()[4]
                              .id);
                        } else {
                          selectedMuscleTypesList.remove(muscleTypesProvider
                              .muscleTypes.values
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
                          selectedMuscleTypesList.add(muscleTypesProvider
                              .muscleTypes.values
                              .toList()[5]
                              .id);
                        } else {
                          selectedMuscleTypesList.remove(muscleTypesProvider
                              .muscleTypes.values
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

                SizedBox(
                  height: 24.0,
                ),

                GestureDetector(
                  onTap: () {
                    if (selectedWorkouts.length == 0) {
                      AppToast.show(_localization.localeString("Select_atleast_Workout"));
                      return;
                    }
                    if (selectedMuscleTypesList.length == 0) {
                      AppToast.show(_localization.localeString("Select_atleast_muscle"));
                      return;
                    }
                    print(selectedWorkouts);
                    Navigator.of(context).push(
                      AppNavigation.route(
                        SelectWorkoutsToAdd(
                          day: widget.day,
                          trainingPlanId: widget.trainingPlanId,
                          selectedMuscleTypes: selectedMuscleTypesList,
                          selectedWorkouts: selectedWorkouts,
                        ),
                      ),
                    );
                  },
                  child: Container(
                      height: size.height * .06,
                      width: size.width * 0.8,
                      child: MainButton(
                        height: size.height * .05,
                        txt: _localization.localeString("Further"),
                        txtColor: Color(0xFFC8B375),
                      )),
                ),
                SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget _workoutTypes(List<WorkoutType> workoutTypes, Size size) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Button 1
          GestureDetector(
            onTap: () {
              if (this.isPressed1 == true) {
                selectedWorkouts.add(workoutTypes[0].id);
                setState(() {
                  isPressed1 = false;
                });
              } else if (this.isPressed1 == false) {
                try {
                  selectedWorkouts.remove(workoutTypes[0].id);
                } catch (e) {
                  print(e);
                }
                setState(() {
                  isPressed1 = true;
                });
              }
            },
            child: Container(
              height: size.height * .04,
              width: size.width * .2,
              child: newbutton(workoutTypes[0].name, isPressed1),
            ),
          ),

          // Button 2
          GestureDetector(
            onTap: () {
              if (this.isPressed2 == true) {
                selectedWorkouts.add(workoutTypes[1].id);
                setState(() {
                  isPressed2 = false;
                });
              } else if (this.isPressed2 == false) {
                setState(() {
                  try {
                    selectedWorkouts.remove(workoutTypes[1].id);
                  } catch (e) {
                    print(e);
                  }
                  isPressed2 = true;
                });
              }
            },
            child: Container(
              height: size.height * .04,
              width: size.width * .3,
              child: newbutton(workoutTypes[1].name, isPressed2),
            ),
          ),

          // Button 3
          GestureDetector(
            onTap: () {
              if (this.isPressed3 == true) {
                selectedWorkouts.add(workoutTypes[2].id);
                setState(() {
                  isPressed3 = false;
                });
              } else if (this.isPressed3 == false) {
                setState(() {
                  try {
                    selectedWorkouts.remove(workoutTypes[2].id);
                  } catch (e) {
                    print(e);
                  }
                  isPressed3 = true;
                });
              }
            },
            child: Container(
              height: size.height * .04,
              width: size.width * .3,
              child: newbutton(workoutTypes[2].name, isPressed3),
            ),
          ),
        ],
      );

  Widget newbutton(String txt, bool selected) {
    return selected
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
                depth: 2,
                shadowLightColor: Color(0xFF707070),
                shadowDarkColor: Colors.black),
          )
        : Neumorphic(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            style: NeumorphicStyle(
              depth: -2,
              color: Color(0xFF16162B),
              shadowDarkColor: Colors.black,
              shadowDarkColorEmboss: Colors.black,
              shadowLightColorEmboss: Color(0xFF707070),
            ),
            child: Center(
              child: Text(
                txt,
                style: TextStyle(color: AppColors.green, fontSize: 13),
              ),
            ),
          );
  }

  Widget newbutton1(String txt, bool selected) {
    return selected
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
                depth: 2,
                shadowLightColor: Color(0xFF707070),
                shadowDarkColor: Colors.black),
          )
        : Neumorphic(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            style: NeumorphicStyle(
              depth: -2,
              color: Color(0xFF16162B),
              shadowDarkColor: Colors.black,
              shadowDarkColorEmboss: Colors.black,
              shadowLightColorEmboss: Color(0xFF707070),
            ),
            child: Center(
              child: Text(
                txt,
                style: TextStyle(color: AppColors.green, fontSize: 13),
              ),
            ),
          );
  }
}
