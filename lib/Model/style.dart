
import 'package:flutter/material.dart';

abstract class ThemeText {
  //Here define all the constant properties
  static const TextStyle greenButtonTextStyle =
      TextStyle(color: Color(0xFFc8b375), fontSize: 18);

  static const TextStyle greenPlaneTextStyle = TextStyle(
    fontSize: 17.0,
    color: Color(0xffc8b375),
  );

  static const TextStyle smallGreenText = TextStyle(
    fontSize: 14.0,
    color: Color(0xffc8b375),
  );

 static const TextStyle largeGreenText = TextStyle(
    fontSize: 32.0,
    color: Color(0xffc8b375),
  );

  static const TextStyle smallWhiteText = TextStyle(
    fontSize: 14.0,
    color: Colors.white
  );

  static const TextStyle planeWhiteText = TextStyle(
    fontSize: 16.0,
    color: Color(0xFFFFFFFF),
  );

  static const TextStyle loadingScreenText = TextStyle(
    fontSize: 19.0,
    color: Color(0xFFFFFFFF),
    wordSpacing: 0.75,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleText = TextStyle(
    fontSize: 18.0, 
    color: Colors.white,
  );

  static const TextStyle stackTitleText = TextStyle(
    fontSize: 17.0, 
    color: Colors.white,
    fontWeight: FontWeight.w600
  );

  static const TextStyle boxTextWhite = TextStyle(
    fontSize: 12.0,   
    color: Colors.white,  
    letterSpacing: 2.75,
  );

}





