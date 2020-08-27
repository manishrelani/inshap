import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Fitness/ChoosingDaysScreen.dart';
import 'package:inshape/data_models/goal.dart';
import 'package:inshape/providers/goals.dart';

import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/constants.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'package:provider/provider.dart';

class SelectGoal1 extends StatefulWidget {
  const SelectGoal1({Key key}) : super(key: key);

  @override
  _SelectGoal1State createState() => _SelectGoal1State();
} 

class _SelectGoal1State extends State<SelectGoal1> {
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,  
        elevation: 0.0,
        title: Text("Fitness"),
        centerTitle: true,
        backgroundColor: AppColors.primaryBackground,
      ),
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
                itemCount: goalsProvider.goals.length,
                itemBuilder: (context, index) {
                  return goalWidget(
                      goalsProvider.goals.values.toList()[index], size);
                })),
      ),
    );
  }

//  goalWidget(
//  goalsProvider.goals.values.toList()[index])
  Widget goalWidget(Goal goal, Size size) {
    return Container(
      margin: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
      width: double.infinity,
      height: size.height * .20,
      child: GestureDetector(
        onTap: () {
          print(goal.name);
          setState(() {
            goalId = goal.id;
            Navigator.of(context)
                .push(AppNavigation.route(ChoosingDaysScreen()));
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
}
