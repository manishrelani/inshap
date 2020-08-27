import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Widget/shimmer.dart';
import 'package:inshape/utils/colors.dart';
import 'ProgrammesScreen.dart';

class EditWorkoutBox extends StatefulWidget {
  @override
  _EditWorkoutBoxState createState() => _EditWorkoutBoxState();
}

class _EditWorkoutBoxState extends State<EditWorkoutBox> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            "Brust & Trizeps",
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.edit,
              color:AppColors.green,
            ),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            addAutomaticKeepAlives: true,
            itemCount: 20,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print("Button Press");
                 
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.16,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF1A1010).withOpacity(0.8),
                            offset: Offset(-3.0, -3.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(32.0),
                                    child: CachedNetworkImage(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.13,
                                      width: MediaQuery.of(context).size.width *
                                          0.24,
                                      errorWidget: (c, d, e) => Image.asset("assets/DietImg2.png"),
                                      placeholder: (c, d) => AppShimmer(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.13,
                                        width: MediaQuery.of(context).size.width *
                                            0.24,
                                      ),
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "https://cdn.cnn.com/cnnnext/dam/assets/200430045928-britney-spears-home-gym-large-169.jpg",
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    width: MediaQuery.of(context).size.width *
                                        0.24,
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * 0.46,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3.0),
                                    child: Wrap(
                                      children: <Widget>[
                                        Text(
                                          "Brustpresse",
                                          style: ThemeText.titleText,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3.0),
                                    child: Wrap(
                                      children: <Widget>[
                                        Text(
                                          "3 Sätze",
                                          style: ThemeText.smallWhiteText,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: AppColors.green,
                                ),
                                onPressed: () {}),
                          )
                        ],
                      )),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              print("Übung hinzufügen Press");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChooseFromAll()));  
              // Navigate to ProgrammesScreen
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.065,
              width: MediaQuery.of(context).size.width,
              child: Neumorphic(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Übung hinzufügen",
                      style: ThemeText.greenButtonTextStyle,
                    ),
                  ),
                ),
                style: NeumorphicStyle(
                    color: Color(0xFF16162B),
                    depth: 3,
                    shadowLightColor: Color(0xFF474141),
                    shadowDarkColor: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.04,
        )
      ],
    );
  }
}
