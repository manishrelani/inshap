import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Registrierung/SelectDietPlan.dart';
import 'package:inshape/providers/muscle_types.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/toast.dart';
import 'package:provider/provider.dart';

class PlanningScreen extends StatefulWidget {
  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  int expertise = 1;
  // Buttons pressed widget
  bool isChecked = false;

  bool isPressed1 = true;
  bool isPressed10 = true;
  bool isPressed11 = true;
  bool isPressed12 = true;
  bool isPressed13 = true;
  bool isPressed14 = true;
  bool isPressed15 = true;
  bool isPressed2 = true;
  bool isPressed3 = true;
  bool isPressed4 = true;
  bool isPressed5 = true;
  bool isPressed6 = true;
  bool isPressed8 = true;
  bool isPressed9 = true;
  bool selectAllMuscles = true;
  var selectedMuscles = List();
  var selectedWorkouts = List();

  @override
  void initState() {
    super.initState();
  }

  bool validate(List mt, List wt) {
    if (mt.length == 0 || wt.length == 0) {
      return false;
    }
    return true;
  }

  Widget newButton(txt, mode) {
    return mode
        ? Neumorphic(
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                txt,
                style: TextStyle(
                    color: Color(0xFFC8C8C8), fontSize: 13), //Color(0xFF50F300)
              ),
            ),
            style: NeumorphicStyle(
                color: Color(0xFF16162B),
                depth: 4,
                shadowLightColor: Color(0xFF2B2B41),
                shadowDarkColor: Color(0xFF0A0A14)),
          )
        : Neumorphic(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            style: NeumorphicStyle(
              depth: -8,
              color: Color(0xFF16162B),
              shadowDarkColor: Color(0xFF0A0A14),
              shadowDarkColorEmboss: Color(0xFF0A0A14),
              shadowLightColorEmboss: AppColors.shadowLightColor,
            ),
            child: Center(
              child: Text(
                txt,
                style: TextStyle(color: Color(0xFFC8B375), fontSize: 13),
              ),
            ),
          );
  }

  // Button widget
  Widget button(txt, color) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(color: color, fontSize: 18), //Color(0xFF50F300)
        ),
      ),
      style: NeumorphicStyle(
          color: Color(0xFF16162B),
          depth: 4,
          shadowLightColor: Color(0xFF2B2B41),
          shadowDarkColor: Color(0xFF0A0A14)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

//    final profileProvider = Provider.of<ProfileProvider>(context);
    final workoutsProvider = Provider.of<WorkoutProvider>(context);
    final muscleTypesProvider = Provider.of<MuscleTypesProvider>(context);
    final workoutTypes = workoutsProvider.workoutTypes.values.toList();
    final muscleTypes = muscleTypesProvider.muscleTypes.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Eigener Plan"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Text below AppBar
              Container(
                margin: EdgeInsets.only(
                    top: size.height * .05, bottom: size.height * .02),
                child: Text(
                  "Wähle soviel aus wie du willst",
                  style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 14),
                ),
              ),

              // Buttons Started here
              Container(
                margin: EdgeInsets.only(
                  left: size.width * .05,
                  right: size.width * .05,
                ),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    //Buttons in Row 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Button 1
                        GestureDetector(
                          onTap: () {
                            if (this.isPressed1 == true) {
                              selectedWorkouts.add(workoutTypes[0].id);
                              setState(() {
                                isPressed1 = false;
                              });
                            } else if (this.isPressed1 == false) {
                              try {
                                selectedWorkouts.remove(workoutTypes[0].id);
                              } catch (e) {
                                print(e);
                              }
                              setState(() {
                                isPressed1 = true;
                              });
                            }
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .2,
                            child: newButton(workoutTypes[0].name, isPressed1),
                          ),
                        ),

                        // Button 2
                        GestureDetector(
                          onTap: () {
                            if (this.isPressed2 == true) {
                              selectedWorkouts.add(workoutTypes[1].id);
                              setState(() {
                                isPressed2 = false;
                              });
                            } else if (this.isPressed2 == false) {
                              setState(() {
                                try {
                                  selectedWorkouts.remove(workoutTypes[1].id);
                                } catch (e) {
                                  print(e);
                                }
                                isPressed2 = true;
                              });
                            }
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .3,
                            child: newButton(workoutTypes[1].name, isPressed2),
                          ),
                        ),

                        // Button 3
                        GestureDetector(
                          onTap: () {
                            if (this.isPressed3 == true) {
                              selectedWorkouts.add(workoutTypes[2].id);
                              setState(() {
                                isPressed3 = false;
                              });
                            } else if (this.isPressed3 == false) {
                              setState(() {
                                try {
                                  selectedWorkouts.remove(workoutTypes[2].id);
                                } catch (e) {
                                  print(e);
                                }
                                isPressed3 = true;
                              });
                            }
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .3,
                            child: newButton(workoutTypes[2].name, isPressed3),
                          ),
                        ),
                      ],
                    ),

                    // Text Bellow row 1
                    Container(
                      margin: EdgeInsets.only(
                        top: size.height * .05,
                        bottom: size.height * .03,
                      ),
                      child: Text(
                        "Wie schätzt du dich selber ein?",
                        style:
                            TextStyle(color: Color(0xFFC8C8C8), fontSize: 18),
                      ),
                    ),

                    // Button in row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // Button 4
                        GestureDetector(
                          onTap: () {
                            // ignore: unnecessary_statements
                            expertise != 1
                                ? setState(() {
                                    expertise = 1;
                                  })
                                : Container();
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .22,
                            child: newButton("Beginner", !(expertise == 1)),
                          ),
                        ),

                        // Button 6
                        GestureDetector(
                          onTap: () {
                            // ignore: unnecessary_statements
                            expertise != 2
                                ? setState(() {
                                    expertise = 2;
                                    // ignore: unnecessary_statements
                                  })
                                : Container();
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .26,
                            child: newButton("Expert", !(expertise == 2)),
                          ),
                        ),
                      ],
                    ),

                    // Text below row 2
                    Container(
                      margin: EdgeInsets.only(
                        top: size.height * .07,
                        // bottom: size.height * .03,
                      ),
                      child: Text(
                        "Was willst du stärken?",
                        style:
                            TextStyle(color: Color(0xFFC8C8C8), fontSize: 18),
                      ),
                    ),

                    // Text 2
                    Container(
                      margin: EdgeInsets.only(
                        // top: size.height * .07,
                        bottom: size.height * .02,
                      ),
                      child: Text(
                        "Wähle mindestens eins oder mehr ",
                        style:
                            TextStyle(color: Color(0xFFC8C8C8), fontSize: 10),
                      ),
                    ),

                    // Button bellow text
                    GestureDetector(
                      onTap: () {
                        if (!selectAllMuscles) {
                          setState(() {
                            isPressed8 = true;
                            isPressed9 = true;
                            isPressed10 = true;
                            isPressed11 = true;
                            isPressed12 = true;
                            isPressed13 = true;
                            isPressed14 = true;
                            isPressed15 = true;
                            selectAllMuscles = true;
                            // remove all from the list
                            selectedMuscles.clear();
                          });
                        } else {
                          setState(() {
                            isPressed8 = false;
                            isPressed9 = false;
                            isPressed10 = false;
                            isPressed11 = false;
                            isPressed12 = false;
                            isPressed13 = false;
                            isPressed14 = false;
                            isPressed15 = false;
                            selectAllMuscles = false;
                            print(muscleTypes.length);
                            selectedMuscles.clear();
                            muscleTypes.forEach((element) {
                              selectedMuscles.add(element.id);
                            });
                            AppToast.show("Selected all muscles");
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: size.height * .04),
                        height: size.height * .043,
                        width: size.width * .32,
                        child: newButton("Ganzkörper", selectAllMuscles),
                      ),
                    ),

                    // Row 3 buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        // Button 8
                        GestureDetector(
                          onTap: () {
                            if (this.isPressed8 == true) {
                              selectedMuscles.add(muscleTypes[0].id);
                              setState(() {
                                isPressed8 = false;
                              });
                            } else if (this.isPressed8 == false) {
                              setState(() {
                                selectedMuscles.remove(muscleTypes[0].id);
                                isPressed8 = true;
                              });
                            }
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .3,
                            child: newButton(muscleTypes[0].name, isPressed8),
                          ),
                        ),

                        // Button 9
                        GestureDetector(
                          onTap: () {
                            if (this.isPressed9 == true) {
                              selectedMuscles.add(muscleTypes[1].id);
                              setState(() {
                                isPressed9 = false;
                              });
                            } else if (this.isPressed9 == false) {
                              setState(() {
                                selectedMuscles.remove(muscleTypes[1].id);
                                isPressed9 = true;
                              });
                            }
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .3,
                            child: newButton(muscleTypes[1].name, isPressed9),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: size.height * .03,
                    ),
                    // Row 4 Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        // Button 10
                        GestureDetector(
                          onTap: () {
                            if (this.isPressed10 == true) {
                              selectedMuscles.add(muscleTypes[2].id);
                              setState(() {
                                isPressed10 = false;
                              });
                            } else if (this.isPressed10 == false) {
                              setState(() {
                                selectedMuscles.remove(muscleTypes[2].id);
                                isPressed10 = true;
                              });
                            }
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .3,
                            child: newButton(muscleTypes[2].name, isPressed10),
                          ),
                        ),

                        // Button 11
                        GestureDetector(
                          onTap: () {
                            if (this.isPressed11 == true) {
                              setState(() {
                                selectedMuscles.add(muscleTypes[3].id);
                                isPressed11 = false;
                              });
                            } else if (this.isPressed11 == false) {
                              setState(() {
                                selectedMuscles.remove(muscleTypes[3].id);
                                isPressed11 = true;
                              });
                            }
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .3,
                            child: newButton(muscleTypes[3].name, isPressed11),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: size.height * .03,
                    ),

                    // Row 5 Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        // Button 12
                        GestureDetector(
                          onTap: () {
                            if (this.isPressed12 == true) {
                              selectedMuscles.add(muscleTypes[4].id);
                              setState(() {
                                isPressed12 = false;
                              });
                            } else if (this.isPressed12 == false) {
                              setState(() {
                                selectedMuscles.remove(muscleTypes[4].id);
                                isPressed12 = true;
                              });
                            }
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .3,
                            child: newButton(muscleTypes[4].name, isPressed12),
                          ),
                        ),

                        // Button 13
                        GestureDetector(
                          onTap: () {
                            if (this.isPressed13 == true) {
                              selectedMuscles.add(muscleTypes[5].id);
                              setState(() {
                                isPressed13 = false;
                              });
                            } else if (this.isPressed13 == false) {
                              setState(() {
                                selectedMuscles.remove(muscleTypes[5].id);
                                isPressed13 = true;
                              });
                            }
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .3,
                            child: newButton(muscleTypes[5].name, isPressed13),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),

                    /* Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        // Button 12
                        GestureDetector(
                          onTap: () {
                            if (this.isPressed14 == true) {
                              setState(() {
                                selectedMuscles.add(muscleTypes[6].id);
                                isPressed14 = false;
                              });
                            } else if (this.isPressed14 == false) {
                              setState(() {
                                selectedMuscles.remove(muscleTypes[6].id);
                                isPressed14 = true;
                              });
                            }
                          },
                          child: Container(
                            height: size.height * .04,
                            width: size.width * .3,
                            child: newButton(muscleTypes[6].name, isPressed14),   
                          ),
                        ),

                     
                      ],
                    ), */
                    // Final Button
                    GestureDetector(
                      onTap: () {
//                        print(selectedMuscles);
//                        print(selectedWorkouts);

                        Provider.of<ProfileProvider>(context, listen: false)
                            .selectedWorkouts = selectedWorkouts;
                        Provider.of<ProfileProvider>(context, listen: false)
                            .selectedMuscles = selectedMuscles;
                        Provider.of<ProfileProvider>(context, listen: false)
                            .expertise = expertise;

                        validate(selectedMuscles, selectedWorkouts)
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectDietPlan()))
                            : AppToast.show(
                                'Please select at-least one muscle and workout');
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: size.width * .06,
                          right: size.width * .06,
                        ),
                        margin: EdgeInsets.only(
                          top: size.height * .03,
                          bottom: size.height * .03,
                        ),
                        width: double.infinity,
                        height: size.height * .065,
                        child: button(
                          "Weiter",
                          Color(0xFFC8B375),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Buttons pressed widget

  // Widget newButton(txt, mode) {
  //   newButton(),
  //   return mode
  //       ? Neumorphic(
  //           boxShape: NeumorphicBoxShape.roundRect(
  //             BorderRadius.circular(10),
  //           ),
  //           child: Center(
  //             child: Text(
  //               txt,
  //               style: TextStyle(
  //                   color: Color(0xFFC8C8C8), fontSize: 13), //Color(0xFF50F300)
  //             ),
  //           ),
  //           style: NeumorphicStyle(
  //               color: Color(0xFF16162B),
  //               depth: 2,
  //               shadowLightColor: Color(0xFF707070),
  //               shadowDarkColor: Colors.black),
  //         )
  //       : Neumorphic(
  //           boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
  //           style: NeumorphicStyle(
  //             depth: -2,
  //             color: Color(0xFF16162B),
  //             shadowDarkColor: Colors.black,
  //             shadowDarkColorEmboss: Colors.black,
  //             shadowLightColorEmboss: Color(0xFF707070),
  //           ),
  //           child: Center(
  //             child: Text(
  //               txt,
  //               style: TextStyle(color:AppColors.green, fontSize: 13),
  //             ),
  //           ),
  //         );
  // }

//   // Button widget
//   Widget button(txt, color) {
//     return Neumorphic(
//       boxShape: NeumorphicBoxShape.roundRect(
//         BorderRadius.circular(10),
//       ),
//       child: Center(
//         child: Text(
//           txt,
//           style: TextStyle(color: color, fontSize: 18),
//         ),
//       ),
//       style: NeumorphicStyle(
//           color: Color(0xFF16162B),
//           depth: 3,
//           shadowLightColor: Color(0xFF707070),
//           shadowDarkColor: Colors.black),
//     );
//   }
}
