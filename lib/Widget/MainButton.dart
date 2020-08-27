import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    this.fontsize,
    this.txt,
    this.txtColor,
    this.height,
    this.width,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
  }) : assert(txt != null);

  final String txt;
  final Color txtColor;
  final double height;
  final double width;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: margin,
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(10),
      ),
      child: Container(
        height: height,
        width: width == null ? double.infinity : width,
        child: Center(
          child: Text(
            txt,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: txtColor == null ? Color(0xFFc8b375) : txtColor,
                fontSize: fontsize == null ? 18.0 : fontsize),
          ),
        ),
      ),
      style: NeumorphicStyle(
          color: Color(0xFF16162B),
          depth: 4,
          shadowLightColor: Color(0xFF2B2B41),
          shadowDarkColor: Color(0xFF0A0A14)),
    );
  }
}

