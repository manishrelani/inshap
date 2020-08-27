import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inshape/utils/colors.dart';

class EditdietScr extends StatefulWidget {
  @override
  _EditdietScrState createState() => _EditdietScrState();
}

class _EditdietScrState extends State<EditdietScr> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(
                left: size.width * .03,
                right: size.width * .02,
              ),
              height: size.height * .06,
              child: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF505057),
                  labelStyle: TextStyle(fontSize: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    // borderSide: BorderSide(color: Colors.black38),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    //borderSide: BorderSide(color: Colors.black87),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFFFFFFF),
                    size: size.height * .03,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        top: size.height * .015,
                        left: size.width * .03,
                        right: size.width * .02,
                      ),
                      height: size.height * .125,
                      child: Neumorphic(
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * .015,
                            bottom: size.height * .015,
                          ),
                          child: LayoutBuilder(
                            builder: (ctx, constraint) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    height: constraint.maxHeight * 1,
                                    width: constraint.maxWidth * .2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Marinierter Mozzarella",
                                        style: TextStyle(
                                            color: Color(0xFFE0E0E0),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        height: constraint.maxHeight * .7,
                                        width: constraint.maxWidth * .55,
                                        child: Text(
                                          "Sed posuere consecteturest at lobortis. Donamcorper nulla non metus auctor.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    FontAwesomeIcons.timesCircle,
                                    color: AppColors.green,
                                    size: 16,
                                  )
                                ],
                              );
                            },
                          ),
                        ), //Text("data",style: TextStyle(color: Colors.white),),
                        style: NeumorphicStyle(
                            color: Color(0xFF181818),
                            depth: 1.5,
                            shadowLightColor: Color(0xFF707070),
                            shadowDarkColor: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}