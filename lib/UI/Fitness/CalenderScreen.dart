import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Fitness/CalenderTab/DayWiseExercisePlan.dart';
import 'package:inshape/Widget/bottom_navigation.dart';
import 'package:inshape/data_models/training_plan.dart';
import 'package:inshape/providers/training_plan.dart';
import 'package:inshape/utils/app_translations.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/week_days.dart';
import 'package:provider/provider.dart';

class CalenderScreen extends StatefulWidget {
  final int day;
  final int trainingPeriod;

  const CalenderScreen({Key key, this.day, this.trainingPeriod = -1})
      : super(key: key);

  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  int index;
 static AppTranslations _localization;

  @override
  void initState() {
    print("Day: ${widget.day}, TrainingPeriod: ${widget.trainingPeriod}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _localization = AppTranslations.of(context);
    if (widget.trainingPeriod == -1) {}

    final trainingPlansProvider = Provider.of<TrainingPlansProvider>(context);

    final TrainingPlan trainingPlan = widget.trainingPeriod == -1
        ? trainingPlansProvider
            .trainingPlans[trainingPlansProvider.recommendedPlan]
        : trainingPlansProvider.trainingPlans.values.firstWhere(
            (element) => element.trainingPeriod == widget.trainingPeriod);

    if (trainingPlan == null || trainingPlan.id == null) {
      return Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    print(trainingPlan.name);

    final tabs = List.generate(
      trainingPlan.trainingPeriod,
      (day) => Tab(
        child: Text("${WeekDays.getDayOfWeek(day + 1)}"),
      ),
    );

    final tabViews = List.generate(
      trainingPlan.trainingPeriod,
      (index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Days(
          trainingPlanId: trainingPlan.id,
          dayIndex: index + 1,
        ),
      ),
    );

    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        initialIndex: widget.day - 1 < 0 ? 0 : widget.day - 1,
        child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
          bottomNavigationBar: BottomNav(index: 1),
          appBar: _getAppBar(tabs, trainingPlan),
          body: TabBarView(
            children: tabViews,
          ),
        ),
      ),
    );
  }

  Widget _getAppBar(List<Tab> tabs, TrainingPlan trainingPlan) => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              print("Pop Button Press");
              Navigator.pop(context);
            }),
        title: Text(
//          "Muskelaufbau 3 Tage trainieren",
          "${trainingPlan.name} ${trainingPlan.trainingPeriod} ${_localization?.localeString("days_training")}",
          textAlign: TextAlign.center,
          style: ThemeText.titleText,
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TabBar(
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.label,
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
              Divider(
                color: Color(0xffffffff),
                height: 1.0,
                thickness: 1.0,
              ),
            ],
          ),
        ),
      );
}
