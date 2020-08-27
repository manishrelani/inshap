import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Backend/workout.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Trainingsplan/Tabs/Eigengewicht.dart';
import 'package:inshape/UI/Trainingsplan/Tabs/Freihantel.dart';
import 'package:inshape/UI/Trainingsplan/Tabs/Gerte.dart';
import 'package:inshape/data_models/workout_type.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

import 'FavouriteScreen.dart';

class OwnPlanScreen extends StatefulWidget {
  final List muscle;
  final List<WorkoutType> workoutTypes;

  OwnPlanScreen({this.muscle, this.workoutTypes});

  @override
  _OwnPlanScreenState createState() => _OwnPlanScreenState();
}

class _OwnPlanScreenState extends State<OwnPlanScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  bool isPressed = false;
  int index = 0;

  @override
  void initState() {
    print(widget.workoutTypes.length);
    print(widget.workoutTypes);
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {
        index = tabController.index;
      });
    });
  }

//  final _bucket = PageStorageBucket();

  bool _fetchedData = false;

  _fetchData() async {
    print("fetching workouts");
    _fetchedData = true;
    Provider.of<WorkoutProvider>(context, listen: false)
        .pullWorkouts(await WorkoutsAPI.getWorkOutWithParams(
      muscle: widget.muscle,
      workoutType: widget.workoutTypes[0].id,
    ));

    Provider.of<WorkoutProvider>(context, listen: false)
        .pullWorkouts(await WorkoutsAPI.getWorkOutWithParams(
      muscle: widget.muscle,
      workoutType: widget.workoutTypes[1].id,
    ));

    Provider.of<WorkoutProvider>(context, listen: false)
        .pullWorkouts(await WorkoutsAPI.getWorkOutWithParams(
      muscle: widget.muscle,
      workoutType: widget.workoutTypes[2].id,
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (!_fetchedData) {
      _fetchData();
    }
    var width = MediaQuery.of(context).size.width / 3.3;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
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
            "Eigener Plan",
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
          actions: <Widget>[
            IconButton(
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.favorite_border,
                  color: AppColors.green,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouriteScreen(),
                      ),
                    );
                  });
                })
          ],
          bottom: TabBar(
            indicator: BoxDecoration(),
            onTap: (int i) {
              // Color(0xff121212);
              setState(() {
                index = i;
              });
            },
            isScrollable: false,
            controller: tabController,
            tabs: List.generate(widget.workoutTypes.length, (i) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 6.0),
                color: Colors.transparent,
                width: width,
                height: MediaQuery.of(context).size.height * 0.05,
                child: newTextButton(
                  '${widget.workoutTypes[i].name}',
                  !(index == i),
                ),
              );
            }),
          ),
        ),
        body: _getBody(width),
      ),
    );
  }

  Widget _getBody(double width) {
    return widget.workoutTypes.length == 0
        ? Center(child: CircularProgressIndicator())
        : TabBarView(
            controller: tabController,
            children: <Widget>[
              Gerte(
                key: PageStorageKey('gerte-screen-${UniqueKey()}'),
                muscleList: widget.muscle,
                workoutTypeId: widget.workoutTypes[0].id,
              ),
              Freihantel(
                key: PageStorageKey('gerte-screen-${UniqueKey()}'),
                muscleList: widget.muscle,
                workoutTypeId: widget.workoutTypes[1].id,
              ),
              Eigengewicht(
                key: PageStorageKey('gerte-screen-${UniqueKey()}'),
                muscleList: widget.muscle,
                workoutTypeId: widget.workoutTypes[2].id,
              ),
            ],
          );
  }

  Widget newTextButton(txt, mode) {
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
                  style: TextStyle(
                      color: Color(0xFFC8C8C8),
                      fontSize: 13), //Color(0xFF50F300)
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
                depth: -2,
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
}
