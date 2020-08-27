import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/Backend/profile.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/toast.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var whiteTitleFontSize = 17.0;
  bool _editMode = false;

  Widget customTitle(String text, String subText, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: Color(0xffFFFFFF),
              fontSize: whiteTitleFontSize,
            ),
          ),
          Spacer(),
          _editMode
              ? Expanded(
                  child: TextFormField(
                    initialValue: subText,
                    textAlign: TextAlign.right,
                    onChanged: onChanged,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  child: Text(
                    subText,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
          SizedBox(width: 12.0)
        ],
      ),
    );
  }

  String name = "";
  int alter = 0, grobe = 0;

  @override
  void initState() {
    super.initState();
    name =
        Provider.of<ProfileProvider>(context, listen: false).profile.fullName;
    alter = Provider.of<ProfileProvider>(context, listen: false).profile.age;
    grobe = Provider.of<ProfileProvider>(context, listen: false).profile.height;
  }

  var profileProvider;

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);

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
          "Profil",
          textAlign: TextAlign.center,
          style: ThemeText.titleText,
        ),
        actions: <Widget>[
          _editMode
              ? IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () async {
                    if (_editMode) {
                      if (name.length < 2) {
                        AppToast.show("Please enter valid name");
                        return;
                      }
                      if (alter < 10) {
                        AppToast.show("Please enter valid age");
                        return;
                      }
                      if (grobe < 20) {
                        AppToast.show("Please enter valid grobe");
                        return;
                      }

                      profileProvider.profile.fullName = name;
                      profileProvider.profile.age = alter;
                      profileProvider.profile.height = grobe;
                      profileProvider.profile = profileProvider.profile;
                      print(
                          "Name: $name, Alter: $alter, Grobe: $grobe, Gender: ${profileProvider.profile.gender}");
                      showLoader(isModal: true);
                      await UserProfile.updateProfile(
                        age: profileProvider.profile.age,
                        name: profileProvider.profile.fullName,
                        height: profileProvider.profile.height,
                      );
                      hideLoader();
                      AppToast.show("Profile updated");
                    }
                    setState(() {
                      _editMode = !_editMode;
                    });
                  },
                )
              : Container(),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("Hello");
              setState(() {
                _editMode = true;
              });
            },
            child: customTitle("Name", "${profileProvider.profile.fullName}",
                (String value) {
              name = value;
            }),
          ),
          Divider(
            color: Color(0xFF373742),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Geschlecht",
                  style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontSize: whiteTitleFontSize,
                  ),
                ),
                Spacer(),
                Neumorphic(
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(9),
                  ),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    depth: 0.0,
                    color: Color(0xff767680),
                  ),
                  child: NeumorphicToggle(
                    padding: EdgeInsets.all(0.75),
                    style: NeumorphicToggleStyle(
                      animateOpacity: true,
                      backgroundColor: Color(0xFF1E1E36),
                      borderRadius: BorderRadius.circular(9),
                      depth: 10.0,
                      disableDepth: true,
                    ),
                    height: MediaQuery.of(context).size.height * 0.052,
                    width: MediaQuery.of(context).size.width / 2,
                    isEnabled: true,
                    selectedIndex:
                        profileProvider.profile.gender.contains("F") ? 1 : 0,
                    onAnimationChangedFinished: (int index) {
//                      _selectedIndex = index;
                      profileProvider.profile.gender = index == 0 ? "M" : "F";
                      profileProvider.profile = profileProvider.profile;
                    },
                    displayForegroundOnlyIfSelected: true,
                    children: [
                      ToggleElement(
                          background: Center(
                            child: Text(
                              "Männlich",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          foreground: Center(
                            child: Text(
                              "Männlich",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )),
                      ToggleElement(
                          background: Center(
                            child: Text(
                              "Weiblich",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          foreground: Center(
                            child: Text(
                              "Weiblich",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ))
                    ],
                    thumb: Neumorphic(
                      style: NeumorphicStyle(
                        color: Color(0xff16162B),
                        disableDepth: true,
                      ),
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(9.0)),
                    ),
                    onChanged: (value) {
                      profileProvider.profile.gender = value == 0 ? "M" : "F";
                      profileProvider.profile = profileProvider.profile;
                    },
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Color(0xFF373742),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _editMode = true;
              });
            },
            child: customTitle("Alter", "${profileProvider.profile.age} Jahre",
                (String value) {
              alter = int.parse(value.replaceAll("Jahre", ""));
            }),
          ),
          Divider(
            color: Color(0xFF373742),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _editMode = true; 
              });
            },
            child: customTitle("Größe", "${profileProvider.profile.height} cm ",
                (String value) {
              grobe = int.parse(value.replaceAll("cm", ""));
            }),
          ),
          Divider(
            color: Color(0xFF373742),
          ),
        ],
      ),
    ));
  }

  editInfo() async {
    if (_editMode) {
      if (name.length < 2) {
        AppToast.show("Please enter valid name");
        return;
      }
      if (alter < 10) {
        AppToast.show("Please enter valid age");
        return;
      }
      if (grobe < 20) {
        AppToast.show("Please enter valid grobe");
        return;
      }

      profileProvider.profile.fullName = name;
      profileProvider.profile.age = alter;
      profileProvider.profile.height = grobe;
      profileProvider.profile = profileProvider.profile;
      print(
          "Name: $name, Alter: $alter, Grobe: $grobe, Gender: ${profileProvider.profile.gender}");
      showLoader(isModal: true);
      await UserProfile.updateProfile(
        age: profileProvider.profile.age,
        name: profileProvider.profile.fullName,
        height: profileProvider.profile.height,
      );
      hideLoader();
      AppToast.show("Profile updated");
    }
    setState(() {
      _editMode = !_editMode;
    });
  }
}
