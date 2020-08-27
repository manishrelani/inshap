import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF16162B),
      body: Center(
        child: Text(
          "Work Under Progress",
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      ),
    );
  }
}
