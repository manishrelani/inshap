import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
void main() => runApp(MaterialApp(
      home: Test(),
    ));

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  bool _toggle = false;

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: InkWell(
            onTap: () { 
              setState(() {
                _toggle = !_toggle; 
              });
            },
            child: SizedBox( 
              height: 300.0,
              width: 140.0,
              child: Stack(
                children: <Widget>[
                 /*  Positioned(
                    top: 0.0,
                    left: 42.0,
                    child: Image.asset(_toggle
                        ? AppAssets.male_head
                        : AppAssets.male_head_outline),
                  ),

                  // chest
                  Positioned(
                    top: _toggle ? 45.0 : 44.0,
                    left: _toggle ? 39.0 : 41.0,
                    child: Image.asset(_toggle
                        ? AppAssets.male_chest
                        : AppAssets.male_chest_outline),
                  ),

                  // arms
                  Positioned(
                    top: 50.0,
                    child: Image.asset(_toggle
                        ? AppAssets.male_arms
                        : AppAssets.male_arms_outline),
                  ),

                  // stomach
                  Positioned(
                    top: 73.0,
                    left: 38.0,
                    child: Image.asset(_toggle
                        ? AppAssets.male_stomach
                        : AppAssets.male_stomach_outline),
                  ),

                  // legs
                  Positioned(
                    top: 122.0,
                    left: 28.0,
                    child: Image.asset(_toggle
                        ? AppAssets.male_legs
                        : AppAssets.male_legs_outline),
                  ), */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
