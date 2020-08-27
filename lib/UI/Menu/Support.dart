import 'package:inshape/Model/style.dart';
import 'package:flutter/material.dart';
import 'package:inshape/utils/colors.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  final String desc =
      "Hast du Schwierigkeiten bei der Nutzung der App oder fragen? Ruf uns gerne an oder schreib uns eine E-Mail. Wir würden uns freuen wenn wir deine Fragen beantworten können und dir die Nutzung der App erleichtern.";
  @override
  Widget build(BuildContext context) {
    var totalHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor:AppColors.primaryBackground,
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
            "Support",
            textAlign: TextAlign.center,
           style: ThemeText.titleText,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[


            SizedBox(
               height: totalHeight*0.032,      
             ), 
 


             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0),
               child: Wrap(
                  children: <Widget>[
                    Text(
                      desc,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xffEBEBF5).withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
             ),

             SizedBox(
               height: totalHeight*0.040,
             ),
            
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                  "Telefon",
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xffEBEBF5).withOpacity(0.4),
                  ),
                ),
            ),
             SizedBox(
               height: totalHeight*0.010,    
             ), 
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                  "+49 156 853246",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Color(0xff007AFF),
                  ),
                ),
            ),

             SizedBox(
               height: totalHeight*0.020,  
             ), 
            

            Container(
              height: 0.75,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF373742),
            ), 
            SizedBox(
               height: totalHeight*0.020,  
             ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                  "E-Mail",
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xffEBEBF5).withOpacity(0.4),
                  ),
                ),
            ),

             SizedBox(
               height: totalHeight*0.010,    
             ), 

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                  "info@inshape.com",  
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Color(0xff007AFF),
                  ),
                ),
            ),

            SizedBox(
               height: totalHeight*0.020,  
             ),  
             
            Container(
              height: 0.75,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF373742),
            ), 
          ],
        ),
      ),
    );
  }
}