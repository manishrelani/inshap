import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Food/DietType.dart';
import 'package:inshape/UI/Food/NutritionScreen.dart';
import 'package:inshape/providers/goals.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({Key key}) : super(key: key);

  @override
  _DietScreenState createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {

  List<String> image = [
    "assets/PlanningImg4.jpg",
    "assets/PlanningImg2.jpg",
    "assets/PlanningImg6.jpg",
    "assets/PlanningImg5.jpg",
  ];
  List<String> text = [
    "Mittagessen",
    "Frühstück",
    "Mittagessen",
    "Frühstück",
  ];

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final goalsProvider = Provider.of<GoalsProvider>(context, listen: false);

    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height * .1;
    final double itemWidth = size.width * .2;
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // AppBar
            Container(
              margin: EdgeInsets.only(
                top: 16.0,
                bottom: 16.0
              ),
              width: double.infinity,
              child: Center(
                child: Text(
                  "Ernährung",
                  style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 18),
                ),
              ),
            ),

            /// recommended plan for diet, can also change this
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectDietTypes(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: size.height * .015,
                  left: size.width * .03,
                  right: size.width * .03,
                ),
                width: double.infinity,
                height: size.height * .23,
                child: items(
                    goalsProvider
                        .goals[profileProvider.profile.goal].thumbnailUrl,
                    goalsProvider.goals[profileProvider.profile.goal].name),
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                top: size.height * .025,
                bottom: size.height * .025,
              ),
              child: Text(
                "Deine Meals",
                style: TextStyle(
                  color: Color(0xFFC8C8C8),
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: size.width * .06,
                  right: size.width * .06,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: itemHeight / itemWidth,
                    crossAxisSpacing: size.width * .08,
                    mainAxisSpacing: size.height * .04,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, int index) =>
                      LayoutBuilder(builder: (ctx, constraint) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NutritionScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,
                        height: size.height * .25,
                        child: items(image[index], text[index]),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget items(img, txt) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: img.toString().contains("http")
                ? CachedNetworkImageProvider(img)
                : AssetImage(
                    img,
                  ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
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
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
      style: NeumorphicStyle(
          color: Color(0xFF16162B),
          depth: 2,
          shadowLightColor: Color(0xFF707070), //Color(0xFF707070),
          shadowDarkColor: Colors.black),
    );
  }
}

