import 'package:flutter/material.dart';
import 'package:inshape/Widget/MainButton.dart';

class ProfileDropDouwnButton extends StatelessWidget {
  final String firstButton;
  final String secondButton;
  final Function firstTab;
  final Function secondTab;
  final Color firstColor;
  final Color secondColor;

  ProfileDropDouwnButton(
      {this.firstButton,
      this.secondButton,
      this.firstTab,
      this.secondTab,
      this.firstColor,
      this.secondColor});
  @override
  Widget build(BuildContext context) {
    var totalHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: firstTab,
            child: MainButton(
              fontsize: 14,
              height: totalHeight * 0.055,
              txt: firstButton == null ? "" : firstButton,
              txtColor: firstColor,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: secondTab,
            child: MainButton(
              fontsize: 14,
              height: totalHeight * 0.055,
              txt: secondButton == null ? "" : secondButton,
              txtColor: secondColor , 
            ),
          ),
        ),
      ],
    );
  }
}
