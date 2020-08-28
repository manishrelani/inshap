import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/TabsPage.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/Widget/bottom_navigation.dart';
import 'package:inshape/providers/session.dart';
import 'package:inshape/utils/colors.dart';
import 'package:inshape/utils/toast.dart';

class SelectImage extends StatefulWidget {
  @override
  _SelectImageState createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  File _image;
  final picker = ImagePicker();
  bool isLoading = false;
  bool isCropLoading = false;

  var pickedFile;

  Future getCameraImage() async {
    pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) _image = File(pickedFile.path);
      if (_image != null) {
        setState(() {
          print("Loading Start");
          isLoading = true;
        });
      }
    });
  }

  Future getGalleryImage() async {
    pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) _image = File(pickedFile.path);
      if (_image != null) {
        setState(() {
          print("Loading Start");
          isLoading = true;
        });
      }
    });
  }

  Future<bool> selectOption() async {
    return (await showDialog(
            context: context,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: CupertinoAlertDialog(
                title: Text("Select Image Option"),
                content: Container(
                  margin: EdgeInsets.only(top: 5),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        getCameraImage();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Camera",
                        style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontWeight: FontWeight.normal),
                      )),
                  CupertinoDialogAction(
                      textStyle: TextStyle(color: Colors.red),
                      isDefaultAction: true,
                      onPressed: () async {
                        getGalleryImage();
                        Navigator.pop(context);
                      },
                      child: Text("Gallery",
                          style: TextStyle(
                              color: Color(0xFF007AFF),
                              fontWeight: FontWeight.normal))),
                ],
              ),
            ))) ??
        false;
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
                  Navigator.pop(
                    context,
                  );
                }),
            title: Text(
              "Gallerie",
              textAlign: TextAlign.center,
              style: ThemeText.titleText,
            ),
          ),
          body: Center(
            child: isCropLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _image == null
                    ? GestureDetector(
                        onTap: selectOption,
                        child: Icon(
                          Icons.camera_alt,
                          color: Color(0xffC8B375),
                          size: 100.0,
                        ),
                      )
                    : isLoading == false
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.69,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                    )),
                              ),

                              //Button
                              GestureDetector(
                                onTap: () {
                                  if (_image != null) {
                                    setState(() {
                                      isCropLoading = true;
                                      uploadImage(pickedFile.path);
                                    });
                                  }
                                },
                                child: MainButton(
                                  txt: "Speichern",
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  txtColor: Color(0xffC8B375),
                                ),
                              ),
                            ],
                          ),
          ),
          bottomNavigationBar: BottomNav(index: 4)),
    );
  }

  //upload images
  uploadImage(image) async {
    print("Info Data");
    final url = 'https://inshape-api.cadoangelus.me/profile/upload/gallery';

    try {
      var headers = {
        'accept': "application/json",
        'Cookie': SessionProvider.jwt,
        'Content-Type': 'multipart/form-data'
      };
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath('gallery', image));
      var res = await request.send();
     // AppToast.show('${res.reasonPhrase}');
      print("res: ${res.reasonPhrase}");

      if (res.reasonPhrase == 'OK') {
        setState(() {
          AppToast.show('Image Added successfully');
        });
      }
      setState(() {
        isLoading = false;
        isCropLoading = true;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>TabsPage(index: 4,)),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
