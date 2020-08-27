import 'package:flutter/material.dart';

/*A utility class for building CustomAppBar

This is the custom app bar created in the widget
folder naming [CustomAppBar] */

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    this.barTxt,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.extra,
  });
  final String barTxt;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget extra;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            margin: margin,
            width: double.infinity,
            child: Center(
              child: Text(
                barTxt,
                style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 18),
              ),
            ),
          ),
          extra==null?Container():extra
        ],
      ),
    );
  }
}
