import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Fitness/AddWorkout/InitAddOwnWorkouts.dart';
import 'package:inshape/UI/Trainingsplan/FavouriteScreen.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/Widget/workout.dart';
import 'package:inshape/providers/favourites.dart';
import 'package:inshape/providers/muscle_types.dart';
import 'package:inshape/providers/training_plan.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:provider/provider.dart';

class DayWiseWorkouts extends StatelessWidget {
  final String trainingPlanId;
  final int day;
  final bool editMode;

   DayWiseWorkouts(
      {Key key, this.trainingPlanId, this.day, this.editMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trainingPlan = Provider.of<TrainingPlansProvider>(context)
        .trainingPlans[trainingPlanId];
        final muscleTypesProvider = Provider.of<MuscleTypesProvider>(context);

//    print(day);
//    print(trainingPlan.goal);

    final workoutsProvider = Provider.of<WorkoutProvider>(context);

    List<String> workouts = [];
    trainingPlan.plans[day].forEach((element) {
      element.workouts.forEach((element) {
        workouts.add(element.workoutId);
      });
    });

//    print("Actual Workouts length: ${workouts.length}");

    Provider.of<FavouritesProvider>(context).excludedWorkoutIds.forEach(
      (element) {
        workouts.remove(element);
      },
    );
//    print("After removing the excluded ones, length: ${workouts.length}");

    List<Widget> children = editMode
        ? List.generate(
            workouts.length,
            (index) => WorkoutEditExerciseWidget(
              onRemove: (String workoutId) => remove(context, workoutId),
              workout: workoutsProvider.workouts[workouts[index]],
            ),
          )
        : List.generate(
            workouts.length,
            (index) => WorkoutExerciseWidget(
              workout: workoutsProvider.workouts[workouts[index]], 
            ),
          );
    if (editMode) {
      children.insert(
          0,
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
            margin: const EdgeInsets.symmetric(horizontal: 8.0,), 
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                   muscleTypesProvider
                  .muscleTypes[trainingPlan 
                      .plans[day][0].name]
                  .name,
                    style: ThemeText.titleText.copyWith(color: AppColors.green),
                    textAlign: TextAlign.center,
                  ),
                )),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.green,
                  ),
//                    onPressed: () => excludeFromMyExercises(context),
                ),
              ],
            ),
          ));
    }

    if (editMode) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                AppNavigation.route(
                  InitAddOwnWorkouts(
                    trainingPlanId: trainingPlanId,
                    day: day,
                  ),
                ),
              );
            },
            splashColor: Colors.transparent,
            child: MainButton(
              txt: "Übung hinzufügen",
              height: 50.0,
              txtColor: AppColors.green,
            ),
          ),
        ),
      );
    }

    return ListView(children: children);
  }

  void remove(BuildContext context, String workoutId) {
    bool _isTempSelected = true;
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Zu dem Workout hinzufugen?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 8.0),
            Text('Willst du dein Workout Plan wirklich bearbeiten?'),
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
            child: Text('Zurucksetzen'),
            onPressed: () {
              Provider.of<FavouritesProvider>(context, listen: false)
                  .excludeAWorkout(day, workoutId, _isTempSelected);
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('Ubernehmen'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}