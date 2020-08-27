import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Backend/profile.dart';
import 'package:inshape/UI/Registrierung/PersonBodyInfo.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/data_models/goal.dart';
import 'package:inshape/providers/goals.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/providers/training_plan.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/constants.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class SelectGoal extends StatefulWidget {
  final bool isUpdateGoal;
  final bool isLogin;

  const SelectGoal({Key key, this.isUpdateGoal = false, this.isLogin = false})
      : super(key: key);

  @override
  _SelectGoalState createState() => _SelectGoalState();
}

class _SelectGoalState extends State<SelectGoal> {
  String goalId;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final goalsProvider = Provider.of<GoalsProvider>(context);

    var children = List.generate(
        goalsProvider.goals.length,
        (index) =>
            goalWidget(goalsProvider.goals.values.toList()[index], size));

    if (children.length == 0) {
      children.add(Center(child: CircularProgressIndicator()));
    }

    return WillPopScope(
      onWillPop: () async => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Was ist dein Ziel?"),
          centerTitle: true,
          backgroundColor: AppColors.primaryBackground,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              if (widget.isUpdateGoal) {
                Navigator.of(context).pop();
                return;
              }
              //AppToast.show("You must setup your profile to continue");
              _onWillPop();
            },
          ),
        ),
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                  children: <Widget>[]
                    ..addAll(children)
                    ..add(
                      GestureDetector(
                        onTap: continueSelectingTheGoal,
                        child: MainButton(
                          txtColor: Color(0xffC8b375),
                          txt: "Weiter",
                          height: size.height * .065,
                          margin: EdgeInsets.only(
                            top: size.height * .05,
                            bottom: size.height * .05,
                            left: size.width * .05,
                            right: size.width * .05,
                          ),
                        ),
                      ),
                    )),
            ),
          ),
        ),
      ),
    );
  }

//  goalWidget(
//  goalsProvider.goals.values.toList()[index])
  Widget goalWidget(Goal goal, Size size) {
    return Container(
      margin: EdgeInsets.only(
        top: size.height * .01,
        left: size.width * .01,
        right: size.width * .01,
        bottom: size.height * .01,
      ),
      width: double.infinity,
      height: size.height * .20,
      child: GestureDetector(
        onTap: () {
          print(goal.name);
          setState(() {
            goalId = goal.id;
          });
          // AppToast.show('${goal.name} is selected');
        },
        child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: goalId == goal.id
                  ? Border.all(color: AppColors.green, width: 2.0)
                  : Border.all(width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(13.0)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  goal.thumbnailUrl ?? Constants.defaultPicture,
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.1),
                    Colors.black.withOpacity(.30),
                  ],
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 14, top: 8),
                    child: Text(
                      goal.name,
                      style: TextStyle(
                          color: goalId == goal.id
                              ? AppColors.green
                              : Colors.white,
                          fontSize: 18),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AppToast.show(goal.name);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        right: 14,
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: AppColors.green,
                        size: 24.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          style: NeumorphicStyle(
              color: Color(0xFF16162B),
              depth: 3,
              shadowLightColor: Colors.black, //Color(0xFF707070),
              shadowDarkColor: Colors.black),
        ),
      ),
    );
  }

  //Handle Back Button
  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: CupertinoAlertDialog(
                title: Text("You must setup your profile to continue"),
                content: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                actions: <Widget>[
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => WelcomeScreen(),
                        //   ),
                        // );
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontWeight: FontWeight.normal),
                      )),
                  // CupertinoDialogAction(
                  //     textStyle: TextStyle(color: Colors.red),
                  //     isDefaultAction: true,
                  //     onPressed: () async {
                  //       Navigator.pop(context);
                  //     },
                  //     child: Text("No",
                  //         style: TextStyle(
                  //             color: Color(0xFF007AFF),
                  //             fontWeight: FontWeight.normal))),
                ],
              ),
            ))) ??
        false;
  }

  Future<void> continueSelectingTheGoal() async {
    if (goalId == null) {
      AppToast.show('Select the goal');
      return;
    }
    if (widget.isUpdateGoal) {
      updateGoal();
    } else {
      Provider.of<ProfileProvider>(context, listen: false).goalId = goalId;
      Navigator.pushReplacement(
        context,
        AppNavigation.route(
          PersonBodyInfo(
//            isLogin: widget.isLogin,
//            goal: goalId,
              ),
        ),
      );
    }
  }

  void updateGoal() async {
    showLoader();
    final response = await UserProfile.updateProfile(goal: goalId);
    hideLoader();

    if (response.error == 'false') {
      // no error here
      Provider.of<ProfileProvider>(context, listen: false)
          .updateProfileGoal(goalId);
      Provider.of<TrainingPlansProvider>(context, listen: false)
          .forceGetRecommendedPlans();
      AppToast.show('Your goal updated successfully');
      Navigator.of(context).pop();
    } else {
      AppToast.show(
        'Failed to update the goal',
      );
    }
  }
}
