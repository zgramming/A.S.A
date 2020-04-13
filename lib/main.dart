import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import './src/providers/category_provider.dart';
import './src/providers/app_theme_provider.dart';
import './src/providers/global_provider.dart';
import './src/providers/main_calendar_provider.dart';

import 'src/app.dart';

NotificationAppLaunchDetails notificationAppLaunchDetails;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
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
