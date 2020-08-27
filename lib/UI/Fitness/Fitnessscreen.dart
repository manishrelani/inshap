import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Fitness/ChoosingDaysScreen.dart';
import 'package:inshape/Widget/shimmer.dart';
import 'package:inshape/utils/colors.dart';

class FitnessScreen extends StatefulWidget {
  @override
  _FitnessScreenState createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  @override
  Widget build(BuildContext context) {
    var totalHeight = MediaQuery.of(context).size.height;
    var totalWidth = MediaQuery.of(context).size.width;
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
              onPressed: () {})
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                print("Press Button");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChoosingDaysScreen(),
                  ),
                );
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    height: totalHeight * 0.26,
                    width: totalWidth,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF2C2C42).withOpacity(0.1),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                        color: Color(0xFF16162B),
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  Container(
                    height: totalHeight * 0.26,
                    width: totalWidth,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        errorWidget: (c, d, e) =>
                            Image.asset("assets/DietImg2.png"),
                        placeholder: (c, d) => AppShimmer(
                          height: totalHeight * 0.26,
                          width: totalWidth,
                        ),
                        imageUrl:
                            "https://news.efinancialcareers.com/binaries/content/gallery/efinancial-careers/articles/2019/06/treadmill.jpg",
                      ),
                    ),
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
                    top: 8.0,
                    left: 8.0,
                    child: Text(
                      "Abnehmen",
                      style: ThemeText.stackTitleText,
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: AppColors.green,
                      ),
                      onPressed: () => addToFavourite(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
 
  void addToFavourite() {}
}
