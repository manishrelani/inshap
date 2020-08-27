import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Fitness/DayWiseWorkouts.dart';
import 'package:inshape/Widget/bottom_navigation.dart';
import 'package:inshape/providers/training_plan.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/week_days.dart';
import 'package:provider/provider.dart';

class ViewWorkoutsScreen extends StatefulWidget {
//  final List<Plan> planArray;
  final int currentDay;
  final String trainingPlanId;

  ViewWorkoutsScreen({this.currentDay, this.trainingPlanId});

  @override
  _ViewWorkoutsScreenState createState() => _ViewWorkoutsScreenState();
}

class _ViewWorkoutsScreenState extends State<ViewWorkoutsScreen>
    with SingleTickerProviderStateMixin {
//  TabController tabController;
//  List workOut;
  bool editMode = false;

  @override
  void initState() {
//    print(widget.currentDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final trainingPlansProvider = Provider.of<TrainingPlansProvider>(context);
    final trainingPlan =
        trainingPlansProvider.trainingPlans[widget.trainingPlanId];

    final tabs = List.generate(trainingPlan.trainingPeriod,
        (day) => Tab(child: Text("${WeekDays.getDayOfWeek(day + 1)}")));

//    print(trainingPlan.goal);

    final tabViews = List.generate(
      trainingPlan.trainingPeriod,
      (index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: DayWiseWorkouts(
          day: index + 1,
          editMode: editMode,
          trainingPlanId: trainingPlan.id,
//          workOut: trainingPlan.plans[index].,
        ),
      ),
    );

    onWillPop(context) {
      if (editMode) {
        setState(() {
          editMode = false;
          return false;
        });
      } else {
        Navigator.pop(context);
        return true;
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return onWillPop(context);
      },
      child: SafeArea(
        child: DefaultTabController(
          length: tabs.length,
          initialIndex: widget.currentDay - 1 < 0 ? 0 : widget.currentDay - 1,
          child: Scaffold(
              backgroundColor: AppColors.primaryBackground,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      if (editMode) {
                        setState(() {
                          editMode = false;
                        });
                      } else
                        Navigator.pop(context);
                    }),
                title: Text(
                  "${trainingPlan.name}",
                  textAlign: TextAlign.center,
                  style: ThemeText.titleText,
                ),
                actions: <Widget>[
                  widget.trainingPlanId == trainingPlansProvider.recommendedPlan
                      ? Visibility(
                          visible: !editMode,
                          child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  editMode = true;
                                });
                              }),
                        )
                      : SizedBox(),
                ],
                bottom: TabBar(
                  indicatorColor: AppColors.green,
                  labelColor: Colors.white,
                  isScrollable: true,
                  unselectedLabelColor: Colors.white,
                  indicatorPadding: EdgeInsets.all(0.0),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.75,
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    letterSpacing: 0.75,
                    fontWeight: FontWeight.w400,
                  ),
                  tabs: tabs,
                ),
              ),
              body: TabBarView(
                children: tabViews,
              ),
              bottomNavigationBar: BottomNav(
                index: 1,
              )),
        ),
      ),
    );
  }
}
