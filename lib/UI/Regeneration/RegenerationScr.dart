import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/UI/Regeneration/ProgrammesScr.dart';
import 'package:inshape/providers/regenaration_type.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

class RegenerationScr extends StatefulWidget {
  const RegenerationScr({Key key}) : super(key: key);

  @override
  _RegenerationScrState createState() => _RegenerationScrState();
}

class _RegenerationScrState extends State<RegenerationScr> {
  DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    final regType = Provider.of<RegenerationTypeProvider>(context)
        .regenerationType
        .values
        .toList();
    print("reg $regType");

    List<String> image = [
      "assets/yoga.png",
      "assets/streching.png",
      "assets/meditation.png",
    ];
    // List<String> text = [
    //   "Yoga",
    //   "Stretching",
    //   "Meditation",
    // ];
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: regType.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : WillPopScope(
                onWillPop: () async => onWillPop(),
                child: SafeArea(
                  child: ListView(
                    padding: EdgeInsets.only(
                      left: size.height * .02,
                      right: size.height * .02,
                    ),
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: size.height * .03,
                          bottom: size.height * .02,
                        ),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Regeneration",
                            style: TextStyle(
                                color: Color(0xFFC8C8C8), fontSize: 18),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: regType.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProgramScreen(name: regType[index].name), //Regeneration1Scr(),
                                ), 
                              );
                             
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                top: size.height * .02,
                              ),
                              width: double.infinity,
                              height: size.height * .24,
                              child: items(image[index],
                                  "${regType[index].name[0].toUpperCase()}${regType[index].name.substring(1)}"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ));
  }

  //Image Widgets
  Widget items(img, txt) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              img,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.1),
                Colors.black.withOpacity(.1),
              ],
            ),
          ),
          child: ListTile(
            leading: Text(
              txt,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      style: NeumorphicStyle(
          color: Color(0xFF16162B),
          depth: 2,
          shadowLightColor: Color(0xFF707070), //Color(0xFF707070),
          shadowDarkColor: Colors.black),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;

      //Fluttertoast.showToast(msg:"Press again to Exit...");
      var snakbar = SnackBar(content: Text("Press again to Exit..."));
      Scaffold.of(context).showSnackBar(snakbar);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
