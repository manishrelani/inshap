import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Food/RezepteScreen.dart';
import 'package:inshape/Widget/bottom_navigation.dart';
import 'package:inshape/data_models/diet_plans.dart';
import 'package:inshape/providers/diet_plans.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'package:provider/provider.dart';

class SelectDietTypes extends StatefulWidget {
  final goalType;
  SelectDietTypes({this.goalType});
  @override
  _SelectDietTypesState createState() => _SelectDietTypesState();
}

class _SelectDietTypesState extends State<SelectDietTypes> {
  Set<String> selectedDietPlans = Set<String>();
  Set<String> selectedDietPlanIds = Set<String>();

  @override
  Widget build(BuildContext context) {
    final dietPlans =
        Provider.of<DietPlansProvider>(context).dietPlans.values.toList();
    Provider.of<DietPlansProvider>(context).dietPlans.values.forEach((element) {
      print(element.name);
    });

//    final size = MediaQuery.of(context).size;

    final children =
        List.generate(dietPlans.length, (index) => dietType(dietPlans[index]));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        title: Text(
          "Benutzerdefinierte Diat",
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFC8C8C8),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: ListView(
          children: <Widget>[]
            ..addAll(children)
            ..add(
              GestureDetector(
                onTap: () {
                  print(selectedDietPlans.toList());
                  Navigator.of(context).push(
                    AppNavigation.route(
                      RecipesTabs(
                        selectedDietPlans: selectedDietPlans.toList(),
                        selectedDietPlansIds: selectedDietPlans.toList(),
                        goalType: widget.goalType,
                      ),
                    ),
                  );
                },
                child: newButton("Weiter", true),
              ),
            ),
        ),
      ),
      bottomNavigationBar: BottomNav(index: 2),
    );
  }

  //Image Widgets
  Widget dietType(DietPlan dietPlan) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Todo: remove name thing when the backend is changed to have ID
          // currently it is a String
          if (!selectedDietPlanIds.contains(dietPlan.id)) {
            selectedDietPlans.add(dietPlan.name);
            selectedDietPlanIds.add(dietPlan.id);
          } else {
            selectedDietPlans.remove(dietPlan.name);
            selectedDietPlanIds.remove(dietPlan.id);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, left: 24.0, right: 24.0, bottom: 4.0),
        child: Neumorphic(
          child: Container(
            width: double.infinity,
            height: 90.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: AppColors.green,
                width: selectedDietPlanIds.contains(dietPlan.id) ? 2.0 : 0.0,
                style: BorderStyle.solid,
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: dietPlan.imageUrl.toString().contains("http")
                    ? CachedNetworkImageProvider(dietPlan.imageUrl)
                    : AssetImage(
                        dietPlan.imageUrl,
                      ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.2),
                    Colors.black.withOpacity(.4),
                  ],
                ),
              ),
              child: ListTile(
                leading: Text(
                  dietPlan.name,
                  style: TextStyle(
                      color: selectedDietPlanIds.contains(dietPlan.id)
                          ? Color(0xFFC8B375)
                          : Color(0xFFC8C8C8),
                      fontSize: 18),
                ),
                trailing: IconButton(
                  onPressed: () {
                    AppToast.show(dietPlan.name);
                  },
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.info_outline,
                    color: AppColors.green,
                  ),
                ),
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

  Widget newButton(txt, mode) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 50.0,
          width: double.infinity,
          child: Center(
            child: Text(
              txt,
              style: TextStyle(color: AppColors.green, fontSize: 16),
            ),
          ),
        ),
        style: NeumorphicStyle(
            color: Color(0xFF16162B),
            depth: 4,
          shadowLightColor: Color(0xFF2B2B41),
          shadowDarkColor: Color(0xFF0A0A14)),
      ),
    );
  }
}
