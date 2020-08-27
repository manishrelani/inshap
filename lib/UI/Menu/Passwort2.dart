import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Model/language_model.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/utils/ShareManager.dart';
import 'package:inshape/utils/application.dart';
import 'package:inshape/utils/colors.dart';

class Passwort2 extends StatefulWidget {
  @override
  _Passwort2State createState() => _Passwort2State();
}

class _Passwort2State extends State<Passwort2> {
  bool firstIsChecked = false;
  bool secondIsChecked = false;
  bool thirdIsChecked = false;
  bool fourthIsChecked = false;
  bool fifthIsChecked = false;
  var whitetitlefontSize = 17.0;
  static final List<String> langList = application.supportedLanguages;
  static final List<String> langCodesList = application.supportedLanguagesCodes;
  List<LanguageModel> listLangauge = new List();
  String languageName = "", languageCode = "";

  loadLangaugeList(String setCode) {
    for (int i = 0; i < langList.length; i++) {
      String name = langList[i];
      String code = langCodesList[i];

      if (code == setCode) {
        setState(() {
          languageName = name;
          languageCode = code;
        });
      }

      listLangauge.add(new LanguageModel(name, code));
    }
  }

  @override
  void initState() {
    super.initState();

    ShareMananer.getLanguageSetting().then((value) {
      setState(() {
        languageName = value["language"];
        print(languageName);
        loadLangaugeList(value["language"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.primaryBackground,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    print("Pop Button Press");
                    Navigator.pop(context);
                  }),
              title: Text(
                "Sprache ändern",
                textAlign: TextAlign.center,
                style: ThemeText.titleText,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ListView.separated(
                  separatorBuilder: ((context, index) {
                    return Container(
                      height: 0.75,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xFF373742),
                    );
                  }),
                  itemCount: listLangauge.length,
                  itemBuilder: (context, index) {
                    return switchButton(index);
                  }),
              //second Toggele Button

              //third Toggele Button
              /*   Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Französisch",
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: whitetitlefontSize,
                              ),
                            ),
                            Spacer(),
                            Neumorphic(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20)),
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    depth: 0.0,
                                    lightSource: LightSource.topLeft,
                                    color: Color(0xff16162B)),
                                child: NeumorphicSwitch(
                                  height: 28.5,
                                  value: thirdIsChecked,
                                  style: NeumorphicSwitchStyle(
                                      inactiveTrackColor: Color(0xFF343547),
                                      activeTrackColor: AppColors.green,
                                      activeThumbColor: Colors.white,
                                      thumbShape: NeumorphicShape.flat),
                                  onChanged: (value) {
                                    setState(() {
                                      thirdIsChecked = value;
                                    });
                                  },
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 0.75,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFF373742),
                      ),
                    ],
                  ),

                  //fourth Toggele Button
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Italienisch",
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: whitetitlefontSize,
                              ),
                            ),
                            Spacer(),
                            Neumorphic(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20)),
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    depth: 0.0,
                                    lightSource: LightSource.topLeft,
                                    color: Color(0xff16162B)),
                                child: NeumorphicSwitch(
                                  height: 28.5,
                                  value: fourthIsChecked,
                                  style: NeumorphicSwitchStyle(
                                      inactiveTrackColor: Color(0xFF343547),
                                      activeTrackColor: AppColors.green,
                                      activeThumbColor: Colors.white,
                                      thumbShape: NeumorphicShape.flat),
                                  onChanged: (value) {
                                    setState(() {
                                      fourthIsChecked = value;
                                    });
                                  },
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 0.75,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFF373742),
                      ),
                    ],
                  ),

                  //fifth Toggele Button
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Portugiesisch (Brasilien)",
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: whitetitlefontSize,
                              ),
                            ),
                            Spacer(),
                            Neumorphic(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20)),
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    depth: 0.0,
                                    lightSource: LightSource.topLeft,
                                    color: Color(0xff16162B)),
                                child: NeumorphicSwitch(
                                  height: 28.5,
                                  value: fifthIsChecked,
                                  style: NeumorphicSwitchStyle(
                                      inactiveTrackColor: Color(0xFF343547),
                                      activeTrackColor: AppColors.green,
                                      activeThumbColor: Colors.white,
                                      thumbShape: NeumorphicShape.flat),
                                  onChanged: (value) {
                                    setState(() {
                                      fifthIsChecked = value;
                                    });
                                  },
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 0.75,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFF373742),
                      ), */
            )));
  }

  Widget switchButton(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            listLangauge[index].name,
            style: TextStyle(
              color: Color(0xffFFFFFF),
              fontSize: whitetitlefontSize,
            ),
          ),
          Spacer(),
          Neumorphic(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  depth: 0.0,
                  lightSource: LightSource.topLeft,
                  color: Color(0xff16162B)),
              child: NeumorphicSwitch(
                height: 28.5,
                value: listLangauge[index].name == languageName ? true : false,
                style: NeumorphicSwitchStyle(
                    inactiveTrackColor: Color(0xFF343547),
                    activeTrackColor: AppColors.green,
                    activeThumbColor: Colors.white,
                    thumbShape: NeumorphicShape.flat),
                onChanged: (value) {
                  setState(() {
                    application
                        .onLocaleChanged(Locale(listLangauge[index].code));
                    ShareMananer.setLanguageSetting(listLangauge[index].code);
                    languageName = listLangauge[index].name;
                    languageCode = listLangauge[index].code;
                    //  Phoenix.rebirth(context);
                  });
                },
              ))
        ],
      ),
    );
  }
}
