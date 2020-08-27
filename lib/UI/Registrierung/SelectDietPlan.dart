import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inshape/Backend/profile.dart';
import 'package:inshape/UI/Registrierung/Loadingscreen.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/data_models/diet_plans.dart';
import 'package:inshape/providers/diet_plans.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/providers/session.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class SelectDietPlan extends StatefulWidget {
  @override
  _SelectDietPlanState createState() => _SelectDietPlanState();
}
 
class _SelectDietPlanState extends State<SelectDietPlan> {
  Set<String> selectedDietPlans = Set<String>();
 // Set<String> selectedDietPlanIds = Set<String>();
 List<String>  selectedDietPlanIds =List<String>();
  String dietId;
  final storage = FlutterSecureStorage();

  Future<void> createUser(ProfileProvider profileProvider) async {
    showLoader();
    print(int.parse(profileProvider.age));
    print(int.parse(profileProvider.weight));
    print(int.parse(profileProvider.height));
    print(profileProvider.gender);
    print(profileProvider.body);
    print(profileProvider.frequency);
    print(profileProvider.expertise);
    print(profileProvider.goalId);
    print(profileProvider.dietId);
    print(profileProvider.selectedWorkouts);
    print(profileProvider.selectedMuscles);

    final response = await UserProfile.createProfile(
        int.parse(profileProvider.age),
        int.parse(profileProvider.weight),
        int.parse(profileProvider.height),
        profileProvider.gender,
        profileProvider.body,
        profileProvider.frequency,
        profileProvider.expertise,
        profileProvider.goalId,
        selectedDietPlanIds, 
        profileProvider.selectedWorkouts,
        profileProvider.selectedMuscles);

    print(response.message);
    hideLoader();
    if (response.error == 'false') {
      SessionProvider.setFilledProfile();
      Navigator.pushReplacement(
        context,
        AppNavigation.route(
          LoadingScreen(isLogin: profileProvider.isLogin),
        ),
      );
    } else {
      AppToast.show('${response.message}');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final dietPlansProvider = Provider.of<DietPlansProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Eigener Plan"),
        centerTitle: true,
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[]
              ..addAll(
                List.generate(
                  dietPlansProvider.dietPlans.length,
                  (index) => Container(
                    margin: EdgeInsets.only(
                      top: size.height * .015,
                      left: size.width * .06,
                      right: size.width * .06,
                    ),
                    width: double.infinity,
                    height: size.height * .15,
                    child: dietItem(
                        dietPlansProvider.dietPlans.values.toList()[index],
                        index),
                  ),
                ),
              )
              ..add(
                GestureDetector(
                  onTap: () {
                    print(selectedDietPlans.toList());
                    profileProvider.dietId = selectedDietPlanIds;
                    print("age:${profileProvider.age},"
                        "No. of Muscles selected: ${profileProvider.selectedMuscles.length}"
                        "No. of workouts selected: ${profileProvider.selectedWorkouts.length}"
                        "Diet id: $selectedDietPlanIds");
                    (dietId == null)
                        ? AppToast.show('Select diet')
                        : createUser(profileProvider);
                  },
                  child: MainButton(
                    txt: "Weiter",
                    height: size.height * .065,
                    margin: EdgeInsets.only(
                      top: size.height * .05,
                      left: size.width * .06,
                      right: size.width * .06,
                    ),
                  ),
                ),
              )
              ..add(SizedBox(height: 32.0)),
          ),
        ),
      ),
    );
  }

  //Image Widgets
  Widget dietItem(DietPlan diet, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          dietId = diet.id;
          if (!selectedDietPlanIds.contains(diet.id)) {
            selectedDietPlans.add(diet.name);
            selectedDietPlanIds.add(diet.id);
          } else {
            selectedDietPlans.remove(diet.name);
            selectedDietPlanIds.remove(diet.id);
          }
        });
//        AppToast.show('${diet.name} is selected');
      },
      child: Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: selectedDietPlanIds.contains(diet.id)
                ? Border.all(color: AppColors.green, width: 2.0)
                : Border.all(width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(13.0)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/PlanningImg${index + 1}.jpg")),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(.2),
                  Colors.black.withOpacity(.4),
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
                    diet.name,
                    style: TextStyle(
                        color: selectedDietPlanIds.contains(diet.id)
                            ? AppColors.green
                            : Colors.white,
                        fontSize: 18),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // todo: get info from the backend
                    AppToast.show(diet.name);
                  },
                  icon: Icon(
                    Icons.info_outline,
                    color: AppColors.green,
                    size: 24,
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
    );
  }
}
