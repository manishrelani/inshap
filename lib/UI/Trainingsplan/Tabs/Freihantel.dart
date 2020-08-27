import 'package:flutter/material.dart';
import 'package:inshape/Widget/workout.dart';

import 'package:inshape/providers/workouts.dart';
import 'package:provider/provider.dart';

class Freihantel extends StatefulWidget {
  final List muscleList;
  final String workoutTypeId;

  const Freihantel({Key key, this.muscleList, this.workoutTypeId}) : super(key: key);

  @override
  _FreihantelState createState() => _FreihantelState();
}

class _FreihantelState extends State<Freihantel> {
//  bool isPressed = false;
//  bool _isLoading;
//  ApiData apiData = ApiData();
//  List workout;

//  void listWorkOut() async {
//    final targetWorkOut =
//        await apiData.getWorkOutWithParams(widget.workId, widget.muscleList);
//    if (targetWorkOut.error == 'false') {
//      if (mounted) {
//        setState(() {
//          _isLoading = false;
//        });
//      }
//      workout = targetWorkOut.workout;
//      print(workout[0]);
//    }
//  }

  @override
  void initState() {
//    _isLoading = true;
//    listWorkOut();
//    apiData.workOut(widget.workId, widget.muscleList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final workoutsProvider = Provider.of<WorkoutProvider>(context);
    final workouts = workoutsProvider.workouts.entries
        .where((workoutMap) =>
    workoutMap.value.type.contains(widget.workoutTypeId) &&
        workoutMap.value.targetMuscles
            .any((muscle) => widget.muscleList.contains(muscle)))
        .toList();

    return workouts.length == 0
        ? Center(
      child: workoutsProvider.workouts.length > 0
          ? Text(
        'No workouts here',
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      )
          : CircularProgressIndicator(),
    )
        : ListView.builder(
      itemCount: workouts.length,
      itemBuilder: (BuildContext context, int index) {
        return WorkoutExerciseWidget(
            workout: workouts[index].value,
//            favouritesProvider: favouritesProvider
        );
      },
    );
  }
}
