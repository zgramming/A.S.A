import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/app_theme_provider.dart';
import 'ui/screens/add_activity_screen.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/welcome_screen.dart';
import 'ui/variable/colors/color_pallete.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppThemeProvider>(context).isDarkMode;
    return MaterialApp(
      title: 'Organize Your Activity',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: colorPallete.primaryColor,
        accentColor: colorPallete.accentColor,
        fontFamily: 'Cabin',
        brightness: Provider.of<AppThemeProvider>(context).isDarkMode
            ? Brightness.dark
            : Brightness.light,
        cardTheme: CardTheme(elevation: 3),
        bottomSheetTheme: BottomSheetThemeData(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
        ),
        scaffoldBackgroundColor: isDarkMode
            ? colorPallete.scaffoldDarkColor
            : colorPallete.scaffoldColor,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('id', 'ID'),
      ],
      home: SplashScreen(),
      routes: {
        SplashScreen.routeNamed: (context) => SplashScreen(),
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        AddActivityScreen.routeName: (context) => AddActivityScreen(),
      },
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case SplashScreen.routeNamed:
      //       return CupertinoPageRoute(
      //           builder: (_) => SplashScreen(), settings: settings);
      //       break;
      //     case WelcomeScreen.routeName:
      //       return CupertinoPageRoute(
      //           builder: (_) => WelcomeScreen(), settings: settings);
      //       break;
      //     case AddActivityScreen.routeName:
      //       return CupertinoPageRoute(
      //           builder: (_) => AddActivityScreen(), settings: settings);
      //       break;

      //     default:
      //       return null;
      //   }
      // },
    );
  }
}
