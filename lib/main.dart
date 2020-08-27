import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inshape/TabsPage.dart';
import 'package:inshape/UI/Registrierung/PersonBodyInfo.dart';
import 'package:inshape/UI/SplashScreen.dart';
import 'package:inshape/providers/diet_plans.dart';
import 'package:inshape/providers/goals.dart';
import 'package:inshape/providers/muscle_types.dart';
import 'package:inshape/providers/profile.dart';
import 'package:inshape/providers/favourites.dart';
import 'package:inshape/providers/quotes.dart';
import 'package:inshape/providers/recepie.dart';
import 'package:inshape/providers/recipe_favourite.dart';
import 'package:inshape/providers/reg_favourites.dart';
import 'package:inshape/providers/regenaration_type.dart';
import 'package:inshape/providers/training_plan.dart';
import 'package:inshape/providers/workouts.dart';
import 'package:inshape/utils/ShareManager.dart';
import 'package:inshape/utils/app_translations_delegate.dart';
import 'package:inshape/utils/application.dart';
import 'package:inshape/utils/colors.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavouritesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WorkoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TrainingPlansProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GoalsProvider(),
        ),  
        ChangeNotifierProvider(
          create: (context) => MuscleTypesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => QuotesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DietPlansProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RecepiesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegenerationTypeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegenerationFavouritesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RecipeFavouritesProvider(),
        ),
      ],
      child: OTS(
        showNetworkUpdates: false,
        loader: CircularProgressIndicator(),
        child: InShapeApp(),
      ),
    ),
  );
}

class InShapeApp extends StatefulWidget {
  @override
  _InShapeAppState createState() => _InShapeAppState();
}

class _InShapeAppState extends State<InShapeApp> {
  Locale locale;
  AppTranslationsDelegate _newLocaleDelegate;
  String languageCode = "";

  onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ShareMananer.getLanguageSetting().then((onValue) {
      setState(() {
        languageCode = onValue["language"].toString();
        print(languageCode);
      });

      if (languageCode == "" || languageCode == "null") {
        ShareMananer.setLanguageSetting("de");
        setState(() {
          languageCode = "de";
          print(languageCode);
        });
      }

      _newLocaleDelegate =
          AppTranslationsDelegate(newLocale: Locale(languageCode));
      application.onLocaleChanged = onLocaleChange;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final initialRoute = "/";
    final routes = {
      SplashScreen.route: (context) => SplashScreen(),
      "abc": (context) => PersonBodyInfo(),
      TabsPage.route: (context) => TabsPage(),
    };
    return languageCode != ""
        ? MaterialApp(
            initialRoute: initialRoute,
            routes: routes,
            title: 'InShape',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              _newLocaleDelegate,
              //provides localised strings
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: application.supportedLocales(),
          )
        : Container(
            color: AppColors.primaryBackground,
          );
  }
}


