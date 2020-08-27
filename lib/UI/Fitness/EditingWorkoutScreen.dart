import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Fitness/EditWorkoutBox.dart';
import 'package:inshape/utils/colors.dart';


class EditingWorkoutScreen extends StatefulWidget {
  @override
  _EditingWorkoutScreenState createState() => _EditingWorkoutScreenState();
}

class _EditingWorkoutScreenState extends State<EditingWorkoutScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 7, vsync: this);
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
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
                print("Pop Button Press");
                Navigator.pop(context);
              }),
          title: Text(
            "Muskelaufbau Brust & Bizeps",
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
                  setState(() {
                    print("Button Press");
                  });
                })
          ],
        ),
        body: ListView(
          children: <Widget>[
            TabBar(
              indicatorColor:AppColors.green,
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
              controller: tabController,
              tabs: <Widget>[
                Tab(child: Text("Mo")),
                Tab(child: Text("Di")),
                Tab(child: Text("Mi")),
                Tab(child: Text("Do")),
                Tab(child: Text("Fr")),
                Tab(child: Text("Sa")),
                Tab(child: Text("So")),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.75,
              color: AppColors.green,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),   
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  EditWorkoutBox(),
                  EditWorkoutBox(),
                  EditWorkoutBox(),
                  EditWorkoutBox(),
                  EditWorkoutBox(),
                  EditWorkoutBox(),
                  EditWorkoutBox(),                 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
