import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inshape/Backend/Authentication.dart';
import 'package:inshape/Model/notes.dart';
import 'package:inshape/Model/response.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/data_models/workout.dart';
import 'package:inshape/providers/favourites.dart';
import 'package:inshape/providers/session.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inshape/utils/toast.dart';

class WorkoutDetailedScreen extends StatefulWidget {
  final Workout workout;
  final Notes notes;

  WorkoutDetailedScreen({this.workout, this.notes});

  @override
  _WorkoutDetailedScreenState createState() => _WorkoutDetailedScreenState();
}

class _WorkoutDetailedScreenState extends State<WorkoutDetailedScreen> {
  bool isPressed = false;
  bool isAddNotes = false;
  CachedVideoPlayerController controller;

  Auth auth = Auth();
  RegResponse res2;
  bool isLoading = false;
  List responseData;
  List note = [];
  TextEditingController notesController = TextEditingController();
  @override
  void initState() {
    getAllNotes();

    print(" workots: ${widget.workout.reps[0].value}");

    controller = CachedVideoPlayerController.network(widget.workout.videoUrl);
    controller.initialize().then((_) {
      setState(() {
        controller.setLooping(true);
      });
    });
    super.initState();
  }

  getAllNotes() async {
    setState(() {
      isLoading = true;
    });
    String url = 'https://inshape-api.cadoangelus.me/note';
    final response = await http.get(url, headers: {
      'accept': "application/json",
      'Content-Type': 'application/json',
      'Cookie': SessionProvider.jwt,
    });

    responseData = json.decode(response.body)['payload']['notes'];
    responseData.forEach((element) {
      if (element["workoutId"] == widget.workout.id) {
        note.add(element);
        print("Note: ${note.toList()}");
      }
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
    }
  }

  addNotes(workoutId, text) async {
    final uri = 'https://inshape-api.cadoangelus.me/note';
    final headers = {
      'accept': "application/json",
      'Content-Type': 'application/json',
      'Cookie': SessionProvider.jwt,
    };
    Map<String, dynamic> body = {"workoutId": workoutId, "text": text};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      setState(() {
        isPressed = false;
        isAddNotes = false;
        AppToast.show('Notes added successfully');
        getAllNotes();
      });
    }
  }

  Future<http.Response> deleteNotes(String id) async {
    var response = await http.delete(
      'https://inshape-api.cadoangelus.me/note/5eeb350fa9b4900488c27376/',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': SessionProvider.jwt,
        'noteId': id,
      },
    );
    if (response.statusCode == 200) {
      AppToast.show('Notes Deleted successfully');
      setState(() {
        getAllNotes();
      });
    }
    return response;
  }

  updateNotes(text) async {
    final uri = '';
    final headers = {
      'accept': "application/json",
      'Content-Type': 'application/json',
      'Cookie': SessionProvider.jwt,
    };
    Map<String, dynamic> body = {"text": text};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    http.Response response = await http.patch(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      getAllNotes();
      setState(() {
        AppToast.show('Notes Updated successfully');
        //  isNotes = false;
        //  isLoading = false;
      });
    }
    print(response.statusCode);
    print(response.body);
  }

  @override
  void dispose() {
    notesController.clear();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var totalHeight = MediaQuery.of(context).size.height;
    final favProvider = Provider.of<FavouritesProvider>(context);
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
                Navigator.pop(context);
              }),
          title: Text(
            "${widget.workout.name}",
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
          actions: <Widget>[
            IconButton(
                splashColor: Colors.transparent,
                icon: Icon(
                  favProvider.fitnessFavourites.contains(widget.workout.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: AppColors.green,
                ),
                onPressed: () {
                  favProvider.addOrRemoveFromFavourite(
                      widget.workout.id, widget.workout);
                })
          ],
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  //Vidoe box
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.value.isPlaying
                            ? controller.pause()
                            : controller.play();
                      });
                    },
                    child: Container(
                        height: 250,
                        child: controller.value != null &&
                                controller.value.initialized
                            ? Stack(
                                children: [
                                  SizedBox.expand(
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: SizedBox(
                                        height: 250,
                                        width: 300,
                                        child: CachedVideoPlayer(controller),
                                      ),
                                    ),
                                  ),
                                  /*  AspectRatio(
                                    child: CachedVideoPlayer(controller),
                                    aspectRatio: 250,
                                  ), */
                                  if (!controller.value.isPlaying)
                                    Center(
                                        child: Icon(
                                      Icons.play_circle_outline,
                                      size: 50,
                                    )),
                                ],
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )),
                  ),
                  SizedBox(
                    height: totalHeight * 0.01,
                  ),

                  SizedBox(
                    height: totalHeight * 0.025,
                  ),

                  Visibility(
                    visible: !isPressed,
                    child: GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        height: totalHeight * 0.07,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Trainingsnotizbuch",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xffC8B375),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        if (note.isEmpty) {
                          setState(() {
                            isAddNotes = true;
                            isPressed = true;
                            print("1");
                          });
                        } else {
                          setState(() {
                            isAddNotes = false;
                            isPressed = true;
                            print("2");
                          });
                        }
                      },
                    ),
                  ),

                  SizedBox(
                    height: totalHeight * 0.020,
                  ),

                  isPressed
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            "Notizen",
                            style: ThemeText.planeWhiteText,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            "Erklärung der Übung",
                            style: ThemeText.planeWhiteText,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 0.75,
                      color: AppColors.green,
                    ),
                  ),
                  Visibility(
                    visible: isPressed,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: isAddNotes == false
                            ? Neumorphic(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(10)),
                                style: NeumorphicStyle(
                                    color: Color(0xFF16162B),
                                    depth: 3,
                                    shadowLightColor: Color(0xFF707070),
                                    shadowDarkColor: Colors.black),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      itemCount: note.length,
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 6.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                color: Colors.white12,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 6.0),
                                                child: Wrap(
                                                  children: [
                                                    Text(
                                                      note[index]['text'],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: Color(0xFFC8B375),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isAddNotes = true;
                                              });
                                            })
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : Card(
                                color: Colors.white24,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    autofocus: true,
                                    controller: notesController,
                                    maxLines: 8,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Enter Notes here",
                                      hintStyle: TextStyle(
                                        color: Colors.white54,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              )),
                  ),
                  Visibility(
                    visible: !isPressed,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            '${widget.workout.description}',
                            style: ThemeText.planeWhiteText,
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: totalHeight * 0.04,
                  ),

                  isAddNotes == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (notesController.text.isEmpty) {
                                    AppToast.show('Text is required');
                                  } else {
                                    isLoading = true;

                                    addNotes(widget.workout.id,
                                        notesController.text);

                                    notesController.clear();
                                    note.clear();
                                  }
                                });
                              },
                              child: MainButton(
                                height: totalHeight * .065,
                                txt: "Notizen hinzufügen",
                                txtColor: Color(0xFFC8B375),
                              )),
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }
}
