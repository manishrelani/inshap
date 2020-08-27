import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Registrierung/SelectGoal.dart';
import 'package:inshape/UI/Registrierung/PlanningScreen.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/navigation.dart';
import 'package:inshape/utils/toast.dart';
import 'package:provider/provider.dart';

class PersonBodyInfo extends StatefulWidget {
  @override
  _PersonBodyInfoState createState() => _PersonBodyInfoState();
}

class _PersonBodyInfoState extends State<PersonBodyInfo> {
  TextEditingController ageController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();

  String gender = "M";
  int num = 2;
  int body = 1;
  String weight;
  String age;
  String height;
  String bodyType;

  // ignore: non_constant_identifier_names
  bool Validate(String height, String weight, String age) {
    if (!(height.length == 0) || !(weight.length == 0) || !(age.length == 0)) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Eigener Plan"),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              AppNavigation.route(
                SelectGoal(isLogin: profileProvider.isLogin),
              ),
            );
          },
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * .025,
                ),

                _maleFemaleSelection(size),
                SizedBox(
                  height: size.height * .03,
                ),
                _allTexts(size),
                _getHeightWeightAgeWidgets(size),
                SizedBox(
                  height: size.height * .03,
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: size.height * .035,
                  ),
                  child: Text(
                    "Welcher Körpertyp bist du?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFC8C8C8),
                    ),
                  ),
                ),

                //Select body continer
                _getBodies(size),
                SizedBox(
                  height: size.height * .015,
                ),

                // TEXT
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * .015,
                    bottom: size.height * .025,
                  ),
                  child: Text(
                    "Wie oft willst du pro Woche trainieren?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFC8C8C8),
                    ),
                  ),
                ),

                _getTrainingWorkoutFrequency(size),

                // Final Button
                GestureDetector(
                  onTap: () => submit(profileProvider),
                  child: MainButton(
                    txt: "Weiter",
                    margin: EdgeInsets.only(
                      top: size.height * .04,
                      bottom: size.height * .04,
                      left: size.width * .06,
                      right: size.width * .06,
                    ),
                    height: size.height * .065,
                  ),
                ),
                Divider(
                  color: Color(0xFF16162B),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTrainingWorkoutFrequency(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[]..addAll(
          List.generate(
            5,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  num = index + 2;
                });
                print("Workout frequency: $num");
              },
              child: Container(
                height: size.height * .06,
                width: size.width * .125,
                child: newTextButton("${index + 2}", !(num == index + 2)),
              ),
            ),
          ),
        ),
    );
  }

  Widget _getBodies(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            body != 1
                ? setState(
                    () {
                      body = 1;
                    },
                  )
                // ignore: unnecessary_statements
                : {};
          },
          child: Container(
            height: size.height * .16,
            width: size.width * .26,
            child: bodyButton(
                "assets/FirstA.png", "assets/FirstB.png", (body == 1), size),
          ),
        ),
        GestureDetector(
          onTap: () {
            body != 2
                ? setState(() {
                    body = 2;
                  })
                // ignore: unnecessary_statements
                : {};
          },
          child: Container(
            height: size.height * .16,
            width: size.width * .26,
            child: bodyButton(
                "assets/SecondB.png", "assets/SecondA.png", (body == 2), size),
          ),
        ),
        GestureDetector(
          onTap: () {
            body != 3
                ? setState(() {
                    body = 3;
                  })
                : Container();
          },
          child: Container(
            height: size.height * .16,
            width: size.width * .26,
            child: bodyButton(
                "assets/ThirdB.png", "assets/ThirdA.png", (body == 3), size),
          ),
        ),
      ],
    );
  }

  Widget _allTexts(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          //color: Colors.red,
          width: size.width * .2,
          child: Text(
            "Wie alt bist du?",
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFC8C8C8),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          //color: Colors.red,
          width: size.width * .2,
          child: Text(
            "Wie groß bist du?",
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFC8C8C8),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          //color: Colors.red,
          width: size.width * .24,
          child: Text(
            "Wie viel wiegst du?",
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFC8C8C8),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _getHeightWeightAgeWidgets(Size size) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * .08,
        right: size.width * .08,
        top: size.height * .03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            children: <Widget>[
              MainButton(
                txt: "",
                height: size.height * .06,
                width: size.width * .2,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: size.width * .035,
                ),
                child: Neumorphic(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                  style: NeumorphicStyle(
                    depth: -5,
                    color: Color(0xFF16162B),
                    shadowDarkColor: Color(0xFF0A0A14),
                    shadowDarkColorEmboss: Color(0xFF0A0A14),
                    shadowLightColorEmboss: AppColors.shadowLightColor,
                  ),
                  child: Container(
                    height: size.height * .057,
                    width: size.width * .12,
                    child: TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                      ],
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      cursorColor: Color(0xFFA0A0A0),
                      textAlign: TextAlign.center,
                      //maxLength: 2,
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                      ),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF4d4d4d),
                            width: .1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              MainButton(
                txt: "",
                height: size.height * .06,
                width: size.width * .2,
              ),
              Row(
                children: <Widget>[
                  Neumorphic(
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                    style: NeumorphicStyle(
                      depth: -5,
                      color: Color(0xFF16162B),
                      shadowDarkColor: Color(0xFF0A0A14),
                      shadowDarkColorEmboss: Color(0xFF0A0A14),
                      shadowLightColorEmboss: AppColors.shadowLightColor,
                    ),
                    child: Container(
                      height: size.height * .057,
                      width: size.width * .12,
                      child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(3),
                        ],
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        cursorColor: Color(0xFFA0A0A0),
                        textAlign: TextAlign.center,
                        //maxLength: 2,
                        style:
                            TextStyle(color: Color(0xFFA0A0A0), fontSize: 14),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF4d4d4d),
                              width: .1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 3),
                    child: Text(
                      "cm",
                      style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              MainButton(
                txt: "",
                height: size.height * .06,
                width: size.width * .2,
              ),
              Row(
                children: <Widget>[
                  Neumorphic(
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                    style: NeumorphicStyle(
                      depth: -5,
                      color: Color(0xFF16162B),
                      shadowDarkColor: Color(0xFF0A0A14),
                      shadowDarkColorEmboss: Color(0xFF0A0A14),
                      shadowLightColorEmboss: AppColors.shadowLightColor,
                    ),
                    child: Container(
                      height: size.height * .057,
                      width: size.width * .12,
                      child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(3),
                        ],
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        cursorColor: Color(0xFFA0A0A0),
                        textAlign: TextAlign.center,
                        //maxLength: 2,
                        style:
                            TextStyle(color: Color(0xFFA0A0A0), fontSize: 14),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF4d4d4d),
                              width: .1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 3),
                    child: Text(
                      "kg",
                      style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Images Buttons pressed widget
  bool isChecked = false;

  Widget bodyButton(
    img,
    img2,
    mode,
    size,
  ) {
    return !mode
        ? AnimatedContainer(
            duration: Duration(seconds: 5),
            child: Neumorphic(
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(10),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          child: Image.asset(
                        img,
                        fit: BoxFit.fill,
                      )),
                      Container(
                          child: Image.asset(
                        img2,
                        fit: BoxFit.fill,
                      )),
                    ],
                  ),
                ),
              ),
              style: NeumorphicStyle(
                color: Color(0xFF16162B),
                depth: 4,
                shadowLightColor: Color(0xFF2B2B41),
                shadowDarkColor: Color(0xFF0A0A14),
              ),
            ),
          )
        : AnimatedContainer(
            duration: Duration(seconds: 5),
            child: Neumorphic(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
              style: NeumorphicStyle(
                depth: -5,
                color: Color(0xFF16162B),
                shadowDarkColor: Color(0xFF0A0A14),
                shadowDarkColorEmboss: Color(0xFF0A0A14),
                shadowLightColorEmboss: AppColors.shadowLightColor,
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: size.width * .11,
                          child: Image.asset(
                            img,
                            fit: BoxFit.fill,
                          )),
                      Container(
                          width: size.width * .09,
                          child: Image.asset(
                            img2,
                            fit: BoxFit.fill,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  //Body 1
  Widget bodyButton1(
    img,
    img2,
    mode,
  ) {
    return !mode
        ? AnimatedContainer(
            duration: Duration(seconds: 5),
            child: Neumorphic(
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(15),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(img),
                ),
              ),
              style: NeumorphicStyle(
                color: Color(0xFF16162B),
                depth: 4,
                shadowLightColor: Color(0xFF2B2B41),
                shadowDarkColor: Color(0xFF0A0A14),
              ),
            ),
          )
        : AnimatedContainer(
            duration: Duration(seconds: 5),
            child: Neumorphic(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
              style: NeumorphicStyle(
                depth: -5,
                color: Color(0xFF16162B),
                shadowDarkColor: Color(0xFF0A0A14),
                shadowDarkColorEmboss: Color(0xFF0A0A14),
                shadowLightColorEmboss: AppColors.shadowLightColor,
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Image.asset(
                    img2,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
  }

  Widget _maleFemaleSelection(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            gender == 'F'
                ? setState(() {
                    gender = 'M';
                  })
                : Container();
          },
          child: Column(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(seconds: 25),
                height: size.height * .12,
                width: size.width * .26,
                child: bodyButton1("assets/MaleIcon0.png",
                    "assets/MaleIcon1.png", gender == 'M'),
              ),
              AnimatedContainer(
                  duration: Duration(seconds: 25),
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    "Mann",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: !(gender == 'M')
                          ? Color(0xFFC8C8C8)
                          : AppColors.green,
                    ),
                  ))
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            gender == 'M'
                ? setState(() {
                    gender = 'F';
                  })
                // ignore: unnecessary_statements
                : {};
          },
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * .12,
                width: size.width * .26,
                child: bodyButton1("assets/FemaleIcon0.png",
                    "assets/FemaleIcon1.png", gender == 'F'),
              ),
              Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    "Frau",
                    style: TextStyle(
                      fontSize: 16,
                      color: !(gender == 'F')
                          ? Color(0xFFC8C8C8)
                          : AppColors.green,
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget newTextButton(txt, mode) {
    return mode
        ? Neumorphic(
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                txt,
                style: TextStyle(
                    color: Color(0xFFC8C8C8), fontSize: 16), //Color(0xFF50F300)
              ),
            ),
            style: NeumorphicStyle(
              color: Color(0xFF16162B),
              depth: 4,
              shadowLightColor: Color(0xFF2B2B41),
              shadowDarkColor: Color(0xFF0A0A14),
            ),
          )
        : Neumorphic(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            style: NeumorphicStyle(
              depth: -5,
              color: Color(0xFF16162B),
              shadowDarkColor: Color(0xFF0A0A14),
              shadowDarkColorEmboss: Color(0xFF0A0A14),
              shadowLightColorEmboss: AppColors.shadowLightColor,
            ),
            child: Center(
              child: Text(
                txt,
                style: TextStyle(color: AppColors.green, fontSize: 16.0),
              ),
            ),
          );
  }

  void submit(ProfileProvider profileProvider) {
    height = heightController.text;
    weight = weightController.text;
    age = ageController.text;
    print(
        "gender:$gender,age:$age,height:$height,weight:$weight,frequency:$num,body:$body,");

    profileProvider.height = height;
    profileProvider.age = age;
    profileProvider.gender = gender;
    profileProvider.weight = weight;
    profileProvider.body = body;
    profileProvider.frequency = num;

    if (heightController.text.isEmpty ||
        weightController.text.isEmpty ||
        ageController.text.isEmpty) {
      AppToast.show(
        'Age, height and weight are required',
      );
    } else if (!weightController.text.contains(RegExp("^[0-9]{1,3}?\$")) ||
        !ageController.text.contains(RegExp("^[0-9]{1,3}?\$")) ||
        !heightController.text.contains(RegExp("^[0-9]{1,3}?\$"))) {
      AppToast.show(
        'please enter valid age,height, and weight',
      );
    } else if (weightController.text.contains(RegExp("^[0-9]{1,3}?\$")) &&
        ageController.text.contains(RegExp("^[0-9]{1,3}?\$")) &&
        heightController.text.contains(RegExp("^[0-9]{1,3}?\$"))) {
          print("Coreect"); 
      Navigator.push(
          context,
          AppNavigation.route(
            PlanningScreen(),
          )); 
    }
  }
}
