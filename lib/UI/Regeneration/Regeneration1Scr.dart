import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Regeneration/ProgrammesScr.dart';
import 'package:inshape/utils/colors.dart';

class Regeneration1Scr extends StatefulWidget {
  @override
  _Regeneration1ScrState createState() => _Regeneration1ScrState();
}

class _Regeneration1ScrState extends State<Regeneration1Scr> {
  List<String> image = [
    "assets/regen2.jpg",
    "assets/regen3.jpg",
  ];

  List<String> text = [
    "Morgenroutine",
    "Regeneration evening",
  ];

  List<String> textside = [
    "Live",
    "21:00",
  ];
  bool isPressed = false;
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
          title: Text(
            "Regeneration",
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            isPressed
                ? IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: AppColors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        print("Button Press");
                        isPressed = false;
                      });
                    })
                : IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: AppColors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        print("Button Press");
                        isPressed = true;
                      });
                    })
          ],
        ),
        body: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                index == 0
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: totalWidth * .03,
                          right: totalWidth * .03,
                          bottom: totalHeight * .04,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            print("Botton press");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProgrammesScr(),
                              ),
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: totalHeight * 0.25,
                                width: totalWidth,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xFF2C2C42).withOpacity(0.1),
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
                                height: totalHeight * 0.25,
                                width: totalWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/regen1.jpg"),
                                  ),
                                ),
                              ),
                              Container(
                                height: totalHeight * 0.25,
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
                                  "Muskeln aufbauen",
                                  style: ThemeText.stackTitleText,
                                ),
                              ),
                              Positioned(
                                  bottom: 0.0,
                                  right: 0.0,
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: AppColors.green,
                                      ),
                                      onPressed: () {})),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),

                //Second edit continer
                Padding(
                  padding: EdgeInsets.only(
                    left: totalWidth * .09,
                    right: totalWidth * .09,
                    bottom: totalHeight * .03,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: totalHeight * 0.24,
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
                        height: totalHeight * 0.24,
                        width: totalWidth,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage(image[index]),
                          ),
                        ),
                      ),
                      Container(
                        height: totalHeight * 0.24,
                        width: totalWidth,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      Positioned(
                        bottom: 8.0,
                        left: 8.0,
                        child: Text(
                          text[index],
                          style: ThemeText.smallWhiteText,
                        ),
                      ),
                      Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.green,
                              ),
                              onPressed: () {})),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: Text(
                          textside[index],
                          style: ThemeText.smallGreenText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
