import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/Widget/workout.dart';
import 'package:inshape/data_models/workout.dart';
import 'package:inshape/providers/favourites.dart';
import 'package:inshape/providers/training_plan.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  final bool isAddWorkout;
  final String trainingId;
  final int day;

  const FavouriteScreen(
      {Key key, this.isAddWorkout = false, this.trainingId, this.day})
      : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouritesProvider>(context);
    var totalHeight = MediaQuery.of(context).size.height;
//    var totalWidth = MediaQuery.of(context).size.width;
    final workoutsProvider = Provider.of<WorkoutProvider>(context);
    var children = <Widget>[];

    if (widget.isAddWorkout) {
      favProvider.fitnessFavourites.forEach((key) {
        children.add(
          WorkoutExerciseWidget(
            onTap: () =>
                addThisToRecommendedPlan(workoutsProvider.workouts[key]),
            workout: workoutsProvider.workouts[key],
          ),
        );
      });
    } else {
      favProvider.fitnessFavourites.forEach((key) {
        children.add(
          WorkoutExerciseWidget(
            workout: workoutsProvider.workouts[key],  
          ),
        );
      });
    }

    if (children.length == 0) {
      children.add(
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: totalHeight * .4, horizontal: 16.0),
            child: Text(
              'Your favourites list is empty',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Favourites Screen",
          textAlign: TextAlign.center,
          style: ThemeText.titleText,
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: ListView(
          children: children,
        ),
      ),
    );
  }

  bool _isTempSelected = true;

  void addThisToRecommendedPlan(Workout workout) {
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
              onChange: (bool isTempSelected){
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
              Provider.of<TrainingPlansProvider>(context, listen: false)
                  .addThisWorkoutId(
                      widget.trainingId, widget.day, workout, _isTempSelected);
              Navigator.of(context).pop();
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

class TempForever extends StatefulWidget {
  final Function(bool isTempSelected) onChange;

  const TempForever({Key key, this.onChange}) : super(key: key);

  @override
  _TempForeverState createState() => _TempForeverState();
}

class _TempForeverState extends State<TempForever> {
  bool _tempSelected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
        type: MaterialType.canvas,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        color: Colors.grey,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    _tempSelected = true;
                  });
                  if (widget.onChange != null) {
                    widget.onChange(_tempSelected);
                  }
                },
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  color: _tempSelected ? Colors.greenAccent : Colors.grey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Nur fur heute',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    _tempSelected = false;
                  });
                  if (widget.onChange != null) {
                    widget.onChange(_tempSelected);
                  }
                },
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  color: !_tempSelected ? AppColors.green : Colors.grey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Fur immer',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
