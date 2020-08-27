import 'package:inshape/Model/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/utils/colors.dart';

class UberInShape extends StatefulWidget {
  @override
  _UberInShapeState createState() => _UberInShapeState();
}

class _UberInShapeState extends State<UberInShape> {
  var whitetitlefontSize = 16.0; 

  Widget custumTitle(String text, var colorName) {
    return GestureDetector(
      onTap: () {
        print("Button Press");
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: Text(
                text,
                style: TextStyle(
                  color: colorName,
                  fontSize: whitetitlefontSize,
                ),
              ),
            ),
            Container(
              height: 0.75,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF373742),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          "Über InShape",
          textAlign: TextAlign.center,
          style: ThemeText.titleText,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  //top: size.height * .01,
                  bottom: size.height * .0, 
                ),
                height: size.height * .27,  
                child: Image.asset("assets/Logo.png"),
              );
            },
          ),
          custumTitle("InShape GmbH", Color(0xffFFFFFF)),
          custumTitle("+49 156 853246", Color(0xff007AFF)), 
          custumTitle("info@inshape.com", Color(0xff007AFF)),
          custumTitle("Emmichstraße 6b", Color(0xffFFFFFF)),
          custumTitle("80993 München", Color(0xffFFFFFF)),  

        ],
      ),
    ));
  }
}