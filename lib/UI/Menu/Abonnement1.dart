import 'package:flutter/material.dart';
import 'package:inshape/Model/style.dart';
import 'package:inshape/UI/Menu/Abonnement2.dart';
import 'package:inshape/Widget/MainButton.dart';
import 'package:inshape/utils/colors.dart';

class Abonnement1 extends StatefulWidget {
  @override
  _Abonnement1State createState() => _Abonnement1State();
}

class _Abonnement1State extends State<Abonnement1> {
  @override
  Widget build(BuildContext context) {
    var totalHeight = MediaQuery.of(context).size.height;
    var totalwidth = MediaQuery.of(context).size.width;
    var constVerticalPadding = totalHeight * 0.040;
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
            "Abonnement",
            textAlign: TextAlign.center,
            style: ThemeText.titleText,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.only(
            //left: totalwidth * .024,
            //right: totalwidth * .024,
          ),
          children: <Widget>[
            SizedBox(
              height: totalHeight * 0.010,
            ),
            //First Text

            Center(
                child: Text(
              "Werde ein InShape Pro-Mitglied",
              style: TextStyle(
                fontSize: 13.0,
                color: AppColors.green,
              ),
            )),

            SizedBox(
              height: totalHeight * 0.010,
            ),

            //Second Text
            Wrap(
              children: <Widget>[
                Text(
                  "Unbegrenzter Zugang du allen Workouts und maßgeschneiderte Workoutpläne. ",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),

            SizedBox(
              height: constVerticalPadding,
            ),

            //First Box with green Border
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Abonnement2()));
                },
                child: Stack(
                  children: <Widget>[
                    Card(
                      color: Color(0xFFC8B375),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Container(
                        margin: EdgeInsets.all(1.6),
                        width: totalwidth * 0.88,
                        height: totalHeight * 0.15,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFC8B375).withOpacity(.10),
                              offset: Offset(6.0, 6.0),
                              blurRadius: 16.0,
                            ),
                            BoxShadow(
                              color: Color(0xFFC8B375).withOpacity(0.10),
                              offset: Offset(3.0, 3.0),
                              blurRadius: 16.0,
                            ),
                          ],
                          color: Color(0xFF16162B),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Jährlich - 39,99 € / Jahr",
                              style: TextStyle(
                                fontSize: 13.0,
                                color: AppColors.green,
                              ),
                            ),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text(
                              "3,33 € / Monat, wird jährlich in Rechnung gestellt",
                              style: TextStyle(
                                fontSize: 13.0,
                                color: AppColors.green,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: constVerticalPadding,
            ),

            //Second Box
            Center(
                child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Abonnement2()));
              },
              child: MainButton(
                txt:
                    "7 Tage kostenlos testen\n3,33 € / Monat, wird jährlich in Rechnung gestellt",
                fontsize: 13.0,
                height: totalHeight * 0.15,
                width: totalwidth * 0.88,
                txtColor: AppColors.green,
              ),
            )),

            SizedBox(
              height: constVerticalPadding,
            ),

            //Third Text with green color
            Center(
                child: Text(
              "Geschäftsbedingungen",
              style: TextStyle(
                fontSize: 13.0,
                color: AppColors.green,
              ),
            )),

            SizedBox(
              height: constVerticalPadding - 10,
            ),

            // last Description
            Container(
              //color: Colors.red,
              margin: EdgeInsets.only(
                 left: totalwidth * .012,
                 right: totalwidth * .012,
                
              ),
              child: Text(
                "Dein iTunes-Konto wird mit dem Gesamtbetrag für den Abonnementzeitraum belastet. Sofern du die automatische Verlängerung nicht mindestens 24 Stunden vor Ablauf des Abonnementzeitraums beendest, verlängert sich das Abonnement automatisch zum selben Preis und dein iTunes-Konto wird dementsprechend belastet. Du kannst das Abonnement jederzeit verwalten und die automatische Verlängerung in den Kontoeinstellungen für deine Apple ID deaktivieren. Nicht genutzte Zeiträume einer kostenlosen Testphase verfallen bei der Anmeldung eines Abonnements ohne Testphase.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.7,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),

            SizedBox(
              height: totalHeight * 0.09,
            ),
          ],
        ),
      ),
    );
  }
  Widget content(){
    return Text(
                "Dein iTunes-Konto wird mit dem Gesamtbetrag für den Abonnementzeitraum belastet. Sofern du die automatische Verlängerung nicht mindestens 24 Stunden vor Ablauf des Abonnementzeitraums beendest, verlängert sich das Abonnement automatisch zum selben Preis und dein iTunes-Konto wird dementsprechend belastet. Du kannst das Abonnement jederzeit verwalten und die automatische Verlängerung in den Kontoeinstellungen für deine Apple ID deaktivieren. Nicht genutzte Zeiträume einer kostenlosen Testphase verfallen bei der Anmeldung eines Abonnements ohne Testphase.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white.withOpacity(0.3),
                ),
              );
  }
}
