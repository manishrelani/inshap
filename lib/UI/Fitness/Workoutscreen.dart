import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Fitness/ChoosingDaysScreen.dart';
import 'package:inshape/UI/Registrierung/SelectGoal.dart';
import 'package:inshape/UI/Trainingsplan/FavouriteScreen.dart';
import 'package:inshape/Widget/shimmer.dart';
import 'package:inshape/providers/goals.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:provider/provider.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  DateTime currentBackPressTime;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final goalsProvider = Provider.of<GoalsProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);

    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: ()async=>onWillPop(), 
      child:SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff16162B),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Fitness",
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color:AppColors.green,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(AppNavigation.route(FavouriteScreen()));
                })
          ],
        ),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return index == 0
                ? _top(totalWidth, totalHeight, goalsProvider, profileProvider)
                : _normal(totalWidth, totalHeight);
          },
        ),
      ),
    ));
  }
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || 
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      
      //Fluttertoast.showToast(msg:"Press again to Exit...");
      var snakbar=SnackBar(content: Text("Press again to Exit..."));
      Scaffold.of(context).showSnackBar(snakbar);
      return Future.value(false);
    }
    return Future.value(true);
  }

  void editMyGoal() {
    Navigator.of(context)
        .push(AppNavigation.route(SelectGoal(isUpdateGoal: true)));
  }

  void selectNoOfDays() {
    Navigator.of(context).push(AppNavigation.route(ChoosingDaysScreen()));
  }

  Widget _top(
    double totalWidth,
    double totalHeight,
    GoalsProvider goalsProvider,
    ProfileProvider profileProvider,
  ) {
    final userGoalId = profileProvider.profile.goal;


    final userGoal = goalsProvider.goals[userGoalId];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: GestureDetector(
        onTap: selectNoOfDays,
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
              imageUrl: userGoal.thumbnailUrl,
            ),
            Container(
              height: totalHeight * 0.26,
              width: totalWidth,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Positioned(
              top: 16.0,
              left: 16.0,
              child: Text(
                "${userGoal.name}",
                style: ThemeText.stackTitleText,
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color:AppColors.green,
                ),
                onPressed: editMyGoal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _normal(double totalWidth, double totalHeight) {
    return //Second edit continer
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: totalHeight * 0.23,
            width: totalWidth,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                errorWidget: (c, d, e) => Image.asset("assets/DietImg2.png"),
                placeholder: (c, d) => AppShimmer(
                  height: totalHeight * 0.23,
                  width: totalWidth,
                ),
                imageUrl:
                    "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB10XIHd.img?h=0&w=720&m=6&q=60&u=t&o=f&l=f&x=1043&y=294",
              ),
            ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            child: Text(
              "Butterfly",
              style: ThemeText.smallWhiteText,
            ),
          ),
          Positioned(
              bottom: 0.0,
              right: 0.0,
              child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color:AppColors.green,
                  ),
                  onPressed: () {})),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Text(
              "Live",
              style: ThemeText.smallGreenText,
            ),
          ),
          Positioned(
            top: -2.0,
            right: 36.0,
            child: Text(
              "•",
              style: ThemeText.largeGreenText,
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutLiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: totalHeight * 0.26,
            width: totalWidth,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                errorWidget: (c, d, e) => Image.asset("assets/DietImg2.png"),
                placeholder: (c, d) => AppShimmer(
                  height: totalHeight * 0.26,
                  width: totalWidth,
                ),
                imageUrl:
                    "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB10XIHd.img?h=0&w=720&m=6&q=60&u=t&o=f&l=f&x=1043&y=294",
              ),
            ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            child: Text(
              "Butterfly",
              style: ThemeText.smallWhiteText,
            ),
          ),
          Positioned(
              bottom: 0.0,
              right: 0.0,
              child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color:AppColors.green,
                  ),
                  onPressed: () {})),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Text(
              "Live",
              style: ThemeText.smallGreenText,
            ),
          ),
          Positioned(
            top: -2.0,
            right: 36.0,
            child: Text(
              "•",
              style: ThemeText.largeGreenText,
            ),
          ),
        ],
      ),
    );
  }
}
