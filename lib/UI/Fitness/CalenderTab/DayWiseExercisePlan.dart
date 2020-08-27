import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Fitness/ViewEditWorkoutsScreen.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/Widget/scroll_bar.dart';
import 'package:inshape/Widget/shimmer.dart';
import 'package:inshape/providers/muscle_types.dart';
import 'package:inshape/providers/training_plan.dart';
import 'package:inshape/utils/app_translations.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:provider/provider.dart';

class Days extends StatefulWidget {
  final int dayIndex;
  final String trainingPlanId;

  const Days({Key key, this.dayIndex, this.trainingPlanId}) : super(key: key);

  @override
  _DaysState createState() => _DaysState();
}

class _DaysState extends State<Days> {
  int dayExerciseIndex = 0;
  AppTranslations _localization;

  Widget moreExercisesOfTheDay(int index, String thumbnailUrl) {
    var size = MediaQuery.of(context).size;
    
//    print(thumbnailUrl);
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   dayExerciseIndex = index;
        // });

        // swap days here
        Provider.of<TrainingPlansProvider>(context, listen: false)
            .swapDays(widget.dayIndex, index, widget.trainingPlanId);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFF74747C).withOpacity(0.1),
                offset: Offset(-6.0, -4.0),
                blurRadius: 8.0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: Offset(6.0, 4.0),
                blurRadius: 8.0,
              ),
            ],
//            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(
              imageUrl: thumbnailUrl,
//              color: Colors.blue,
              errorWidget: (c, d, e) => Image.asset("assets/DietImg2.png"),
              placeholder: (c, d) => AppShimmer(
                width: size.width * 0.30,
                height: size.height * 0.13,
              ),
              fit: BoxFit.cover,
              width: size.width * 0.30,
              height: size.height * 0.16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _localization = AppTranslations.of(context);
    var size = MediaQuery.of(context).size;
    final trainingPlansProvider = Provider.of<TrainingPlansProvider>(context);
    final trainingPlan =
        trainingPlansProvider.trainingPlans[widget.trainingPlanId];
//    print(trainingPlan.plans[widget.dayIndex].toList());
    final muscleTypesProvider = Provider.of<MuscleTypesProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //First Title Text
          SizedBox(height: 4.0),
          Text(
            _localization.localeString("Recommended"),
            style: ThemeText.titleText,
          ),

          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: Card(
//              color: Color(0xff00F321),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: BorderSide(
                  color: AppColors.green,
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(2),
                height: size.height * 0.36,
                width: size.width,
//                color: Colors.indigo,
                child: CachedNetworkImage(
                  errorWidget: (c, d, e) => Image.asset(
                    "assets/DietImg2.png",
                    fit: BoxFit.cover,
                  ),
                  placeholder: (c, d) => AppShimmer(
                    height: size.height * 0.36,
                    width: size.width,
                  ),
                  fit: BoxFit.fill,
                  imageUrl: muscleTypesProvider
                      .muscleTypes[trainingPlan
                          .plans[widget.dayIndex][dayExerciseIndex].name]
                      .thumbnailUrl,
                ),
              ),
            ),
          ),

          Center(
            child: Text(
              muscleTypesProvider
                  .muscleTypes[trainingPlan
                      .plans[widget.dayIndex][dayExerciseIndex].name]
                  .name,
              textAlign: TextAlign.center,
              style: ThemeText.greenPlaneTextStyle,
            ),
          ),
          SizedBox(
            height: 24.0,
          ),

          Text(
            _localization.localeString("Other_daily_goals"),
            style: ThemeText.titleText,
          ),

          SizedBox(
            height: 12.0,
          ),
          // Recommended things
          MyScrollbar(
            child: Container(
              height: size.height * 0.13,
              width: size.width,
              margin: const EdgeInsets.only(bottom: 12.0),
              child: trainingPlan.plans.length - 1 < 1
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return moreExercisesOfTheDay(
                            index,
                            muscleTypesProvider
                                .muscleTypes[trainingPlan.plans[index][0].name]
                                .thumbnailUrl);
                      },
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: trainingPlan.plans.length,
                      itemBuilder: (BuildContext context, int index) {
                        return index == dayExerciseIndex
                            ? SizedBox()
                            : moreExercisesOfTheDay(
                                index,
                                muscleTypesProvider
                                    .muscleTypes[
                                        trainingPlan.plans[index][0].name]
                                    .thumbnailUrl);
                      },
                    ),
            ),
          ),



          SizedBox(
            height: 32.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  AppNavigation.route(
                    ViewWorkoutsScreen(
                      trainingPlanId: widget.trainingPlanId,
                      currentDay: widget.dayIndex,
                    ),
                  ),
                );
              },
              child: MainButton(
                txt: _localization.localeString("Further"),
                height: MediaQuery.of(context).size.height * 0.06,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
        ],
      ),
    );
  }
}
