import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './src/app.dart';
import './src/providers/global_provider.dart';
import './src/providers/category_provider.dart';
import './src/providers/app_theme_provider.dart';
import './src/providers/main_calendar_provider.dart';
import './src/function/show_schedule_notification.dart';

ShowNotificationSchedule notificationSchedule;

Future<void> main() async {
  ///! Digunakan Sekali saja untuk inialisasi FLutter Local Notification , Refer From Documentation
  WidgetsFlutterBinding.ensureInitialized();
  notificationSchedule = ShowNotificationSchedule();
  notificationSchedule.initLocalNotification();
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
