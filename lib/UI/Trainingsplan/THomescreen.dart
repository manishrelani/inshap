import 'package:flutter/material.dart';
import 'package:inshape/utils/colors.dart';

class THomescreen extends StatefulWidget {
  @override
  _THomescreenState createState() => _THomescreenState();
}

class _THomescreenState extends State<THomescreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         backgroundColor: AppColors.primaryBackground,
         body: ListView(
           children: <Widget>[
              
           ],
         ),
      ),
    );
  }
}