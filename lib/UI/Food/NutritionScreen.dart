import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Food/DietType.dart';
import 'package:inshape/utils/colors.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({Key key}) : super(key: key);
  @override
  _NutritionScreen createState() => _NutritionScreen();
}

class _NutritionScreen extends State<NutritionScreen> {
  DateTime currentBackPressTime;
  List<String> image = [
    "assets/NutritionImg1.jpg",
    "assets/NutritionImg2.jpg",
    "assets/NutritionImg3.jpg",
  ];
  List<String> goal = [
    "Muskelaufbau",
    "Abnehmen",
    "InShape",
  ]; 

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: WillPopScope(
          onWillPop: () async => onWillPop(),
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.only(
                left: size.width * .03,
                right: size.width * .03,
              ),
              children: <Widget>[
                // AppBar
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: size.height * .02,
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Ziel ändern",
                          style:
                              TextStyle(color: Color(0xFFC8C8C8), fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectDietTypes(goalType: goal[index]),
                          ),
                        );
                        /* switch (index) {
                          case 0:
                            {}
                        } */ 
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: size.height * .02,
                        ),
                        width: double.infinity,
                        height: size.height * .25,
                        child: items(image[index], goal[index]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }

  //Image Widgets
  Widget items(img, txt) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              img,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.01),
                Colors.black.withOpacity(.3),
              ],
            ),
          ),
          child: ListTile(
            leading: Text(
              txt,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      style: NeumorphicStyle(
          color: Color(0xFF16162B),
          depth: 3,
          shadowLightColor: Colors.black, //Color(0xFF707070),
          shadowDarkColor: Colors.black),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;

      //Fluttertoast.showToast(msg:"Press again to Exit...");
      var snakbar = SnackBar(content: Text("Press again to Exit..."));
      Scaffold.of(context).showSnackBar(snakbar);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
