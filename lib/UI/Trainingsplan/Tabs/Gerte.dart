import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Trainingsplan/WorkoutDetailedScreen.dart';
import 'package:inshape/Widget/shimmer.dart';
import 'package:inshape/Widget/workout.dart';
import 'package:inshape/data_models/workout.dart';
import 'package:inshape/providers/favourites.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

class Gerte extends StatefulWidget {
  final List muscleList;
  final String workoutTypeId;

  const Gerte({Key key, this.muscleList, this.workoutTypeId}) : super(key: key);

  @override
  _GerteState createState() => _GerteState();
}

class _GerteState extends State<Gerte> {
  bool isPressed = false;
  List workout;

  @override
  void initState() {
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
//                  favouritesProvider: favouritesProvider
              );
            },
          );
  }
}

class WorkoutWidget extends StatelessWidget {
  final Workout workout;
  final FavouritesProvider favouritesProvider;

  const WorkoutWidget(
      {Key key,
//      @required this.id,
      @required this.workout,
      @required this.favouritesProvider})
      : super(key: key);

  addToFavourites(String workoutId, dynamic workout) {

    favouritesProvider.addOrRemoveFromFavourite(workoutId, workout);
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,
      shadowColor: Color(0xFF2C2C42).withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutDetailedScreen(
                workout: workout,
              ),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              height: totalHeight * 0.26,
              width: totalWidth,
              fit: BoxFit.cover,
              errorWidget: (c, d, e) => Image.asset("assets/DietImg2.png"),
              placeholder: (c, d) => AppShimmer(
                height: totalHeight * 0.26,
                width: totalWidth,
              ),
              imageUrl: workout.thumbnailUrl,
            ),
            Positioned(
              top: 16.0,
              left: 16.0,
              child: Text(
                "${workout.name}",
                style: ThemeText.stackTitleText,
              ),
            ),
            Positioned(
              bottom: 8.0,
              right: 0.0,
              child: IconButton(
                icon: Icon(
                  favouritesProvider.fitnessFavourites.contains(workout.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: AppColors.green,
                ),
                onPressed: () => addToFavourites(workout.id, workout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
