import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import './src/providers/category_provider.dart';
import './src/providers/app_theme_provider.dart';
import './src/providers/global_provider.dart';
import './src/providers/main_calendar_provider.dart';

import './src/ui/screens/add_activity_screen.dart';
import './src/ui/screens/splash_screen.dart';
import './src/ui/screens/welcome_screen.dart';
import './src/ui/variable/colors/color_pallete.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalProvider>(
          create: (_) => GlobalProvider(),
        ),
        ChangeNotifierProvider<MainCalendarProvider>(
          create: (ctx) => MainCalendarProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      ),
      darkTheme: ThemeData.dark(),
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
