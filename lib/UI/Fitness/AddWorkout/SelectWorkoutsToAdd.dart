import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Trainingsplan/FavouriteScreen.dart';
import 'package:inshape/Widget/bottom_navigation.dart';
import 'package:inshape/Widget/workout.dart';
import 'package:inshape/data_models/training_plan.dart';
import 'package:inshape/data_models/workout.dart';
import 'package:inshape/providers/training_plan.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/app_translations.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:provider/provider.dart';

class SelectWorkoutsToAdd extends StatefulWidget {
  final String trainingPlanId;
  final int day;
  final List<String> selectedWorkouts, selectedMuscleTypes;

  const SelectWorkoutsToAdd(
      {Key key,
      this.trainingPlanId,
      this.day,
      this.selectedWorkouts,
      this.selectedMuscleTypes})
      : super(key: key);

  @override
  _SelectWorkoutsToAddState createState() => _SelectWorkoutsToAddState();
}

class _SelectWorkoutsToAddState extends State<SelectWorkoutsToAdd> {
  AppTranslations _localization;
  @override
  Widget build(BuildContext context) {
    _localization = AppTranslations.of(context);
    final workoutsProvider = Provider.of<WorkoutProvider>(context);
    final trainingPlanProvider = Provider.of<TrainingPlansProvider>(context);
    var trainingPlans = trainingPlanProvider
        .trainingPlans[widget.trainingPlanId].plans[widget.day];

    List<String> showTheseWorkouts = [];

    workoutsProvider.workouts.values.toList().forEach((Workout workout) {
      // should satisfy the workout type
      if (widget.selectedWorkouts.contains(workout.type)) {
        // should satisfy the muscle selected
        if (widget.selectedMuscleTypes.any(
            (muscleType) => widget.selectedMuscleTypes.contains(muscleType))) {
          // shouldn't be already in the training plan
          trainingPlans.forEach((Plan plan) {
            plan.workouts.forEach((WorkoutId workoutId) {
              if (!workoutId.workoutId.contains(workout.id)) {
                showTheseWorkouts.add(workoutId.workoutId);
              }
            });
          });
        }
      }
    });

    showTheseWorkouts = showTheseWorkouts.toSet().toList();

    print("Suggested ${showTheseWorkouts.length}");

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      bottomNavigationBar: BottomNav(index: 1), 
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        title: Text(_localization.localeString("OverView")),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.transparent,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                AppNavigation.route(
                  FavouriteScreen(
                    trainingId: widget.trainingPlanId,
                    day: widget.day,
                    isAddWorkout: true,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.favorite,
              color: AppColors.green,
            ),
          ),
        ],
      ),
      body: showTheseWorkouts.length == 0
          ? Center(
              child: Text(
                _localization.localeString("No_Workout"),
                style: ThemeText.titleText,
              ),
            )
          : ListView.builder(
              itemCount: showTheseWorkouts.length,
              itemBuilder: (context, i) => WorkoutExerciseWidget(
                onTap: () => addThisToRecommendedPlan(
                    workoutsProvider.workouts[showTheseWorkouts[i]]),
                workout: workoutsProvider.workouts[showTheseWorkouts[i]],
              ),
            ),
    );
  }

  bool _isTempSelected = true;

  void addThisToRecommendedPlan(Workout workout) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(_localization.localeString("Add_workout")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 8.0),
            Text(_localization.localeString("Want_Edit_Workout")),
            SizedBox(height: 8.0),
            TempForever(
              onChange: (bool isTempSelected) {
                _isTempSelected = isTempSelected;
              },
            ),
            SizedBox(height: 8.0),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(_localization.localeString("Reset")),
            onPressed: () {
              Provider.of<TrainingPlansProvider>(context, listen: false)
                  .addThisWorkoutId(widget.trainingPlanId, widget.day, workout,
                      _isTempSelected);
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text(_localization.localeString("Take_over")),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
