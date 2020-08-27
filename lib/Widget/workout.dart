import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Trainingsplan/WorkoutDetailedScreen.dart';
import 'package:inshape/Widget/shimmer.dart';
import 'package:inshape/data_models/workout.dart';
import 'package:inshape/providers/favourites.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:provider/provider.dart';

const circularLoading = Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(child: CircularProgressIndicator()));

class WorkoutExerciseWidget extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  const WorkoutExerciseWidget({Key key, this.workout, this.onTap})
      : super(key: key);

  goToDetailedPage(BuildContext context) {
    if (onTap != null) {
      onTap();
      return;
    }
    Navigator.push(
      context,
      AppNavigation.route(
        WorkoutDetailedScreen(
          workout: workout,
        ),
      ),
    );
  }

  addToFavourites(BuildContext context) {
    Provider.of<FavouritesProvider>(context, listen: false)
        .addOrRemoveFromFavourite(workout.id, workout);
  }

  @override
  Widget build(BuildContext context) {
    // scales approx to 100.0 for pixel xl 2
    final height = MediaQuery.of(context).size.height * 0.09;
    final favouritesProvider = Provider.of<FavouritesProvider>(context);
    return workout == null || workout.name.length < 1
        // ? circularLoading // to avaoid wiered ui its automatically added  
        ? Container()  
        : InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => goToDetailedPage(context),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF1A1010).withOpacity(0.8),
                    offset: Offset(-3.0, -3.0),
                    blurRadius: 16.0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(6.0, 6.0),
                    blurRadius: 16.0,
                  ),
                ],
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      height: height,
                      width: height,
                      errorWidget: (c, d, e) =>
                          Image.asset("assets/DietImg2.png"),
                      placeholder: (c, d) => AppShimmer(
                        height: height,
                        width: height,
                      ),
                      fit: BoxFit.cover,
                      imageUrl: workout.thumbnailUrl,
                    ),
                  ),
                  SizedBox(width: 24.0),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 8.0),
                        Flexible(
                          flex: 1,
                          child: Text(
                            workout.name,
                            style: ThemeText.titleText,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "3 Saize",
                          style: ThemeText.smallWhiteText,
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      icon: Icon(
                        favouritesProvider.fitnessFavourites
                                .contains(workout.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:AppColors.green,
                      ),
                      onPressed: () => addToFavourites(context),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class WorkoutEditExerciseWidget extends StatelessWidget {
  final Workout workout;
  final Function(String) onRemove;

  const WorkoutEditExerciseWidget({Key key, this.workout, this.onRemove})
      : super(key: key);

  goToDetailedPage(BuildContext context) {
//    Navigator.push(
//      context,
//      AppNavigation.route(
//        WorkoutDetailedScreen(
//          workout: workout,
//        ),
//      ),
//    );
  }

//  excludeFromMyExercises(BuildContext context) {
//    Provider.of<FavouritesProvider>(context, listen: false)
//        .excludeAWorkout(workout.id);
//  }

  @override
  Widget build(BuildContext context) {
    // scales approx to 100.0 for pixel xl 2
    final height = MediaQuery.of(context).size.height * 0.09;
    return workout == null || workout.name.length < 1
        ? Container()
        : Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF1A1010).withOpacity(0.8),
                  offset: Offset(-3.0, -3.0),
                  blurRadius: 16.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(6.0, 6.0),
                  blurRadius: 16.0,
                ),
              ],
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    height: height,
                    width: height,
                    fit: BoxFit.cover,
                    errorWidget: (c, d, e) =>
                        Image.asset("assets/DietImg2.png"),
                    placeholder: (c, d) => AppShimmer(
                      height: height,
                      width: height,
                    ),
                    imageUrl: workout.thumbnailUrl,
                  ),
                ),
                SizedBox(width: 24.0),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      Flexible(
                        flex: 1,
                        child: Text(
                          workout.name,
                          style: ThemeText.titleText,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "3 Saize",
                        style: ThemeText.smallWhiteText,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    icon: Material(
//                      type: MaterialType.circle,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        side: BorderSide(color: AppColors.green),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.clear,
                          size: 16.0,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                    onPressed: () => onRemove(workout.id),
//                    onPressed: () => excludeFromMyExercises(context),
                  ),
                ),
              ],
            ),
          );
  }
}
