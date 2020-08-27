import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/data_models/regenerationWorkout.dart';
import 'package:inshape/providers/reg_favourites.dart';
import 'package:inshape/utils/colors.dart';
import 'package:provider/provider.dart';

class ExerciseScr extends StatefulWidget {
  final RegenerationWorkout regeneration;
  ExerciseScr(this.regeneration);

  @override
  _ExerciseScrState createState() => _ExerciseScrState();
}

class _ExerciseScrState extends State<ExerciseScr> {
  bool isPressed = false;
  CachedVideoPlayerController controller;

  @override
  void initState() {
    controller =
        CachedVideoPlayerController.network(widget.regeneration.videoUrl);
    controller.initialize().then((_) {
      setState(() {
        controller.setLooping(true);
      });
    //  controller.play();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favouritesProvider =
        Provider.of<RegenerationFavouritesProvider>(context);

    var totalHeight = MediaQuery.of(context).size.height;
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
            "Der Vogel",
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  favouritesProvider.regFavourites
                          .contains(widget.regeneration.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: AppColors.green,
                ),
                onPressed: () {
                  setState(() {
                    favouritesProvider
                        .addOrRemoveFromRegFavourite(widget.regeneration.id);
                  });
                })
          ],
        ),
        body: ListView(
          children: <Widget>[
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Wrap(
                children: <Widget>[
                  Text(
                    widget.regeneration.description,
                    style: ThemeText.planeWhiteText,
                  )
                ],
              ),
            ),
            SizedBox(
              height: totalHeight * 0.10,
            ),
          ],
        ),
      ),
    );
  }
}
