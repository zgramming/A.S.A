import 'dart:async';

import 'package:atur_semua_aktifitas/src/ui/widgets/button_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './welcome_screen.dart';

import '../template/splashscreen_template/splashscreen_template.dart';
import '../template/splashscreen_template/widgets/splashscreen_image_asset.dart';
import '../variable/config/app_config.dart';

class SplashScreen extends StatelessWidget {
  static const routeNamed = '/splashscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenTemplate(
        backgroundColor: Theme.of(context).primaryColor,
        image: SplashScreenImageAsset(
          locationImage: appConfig.locationImageSplashScreen,
          imageHeight: 2.5,
        ),
        navigateAfterSplashScreen: WelcomeScreen(),
      ),
    );
  }
}

class TestingScreen extends StatefulWidget {
  @override
  _TestingScreenState createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  Timer _timer;
  Duration _duration;
  int _count;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    _duration = Duration(seconds: 1);
    _count = 0;
    _timer = Timer.periodic(_duration, (timer) {
      // print(_count);
      return _count++;
    });
    initLocalNotification();
  }

  void initLocalNotification() {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    initializationSettings = InitializationSettings(
      androidInitializationSettings,
      iosInitializationSettings,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  void _showNotification() async {
    await notification();
  }

  Future<void> notification() async {
    var timeDelayed = DateTime.now().add(Duration(seconds: 3));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_Id',
      'Channel Title',
      'Channel body',
      priority: Priority.High,
      importance: Importance.Max,
      ticker: 'ticker',
      color: Colors.yellow,
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(
      timeDelayed.millisecondsSinceEpoch,
      'Hello There',
      'Disini Bodynya',
      timeDelayed,
      notificationDetails,
      payload: 'item X',
    );
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        CupertinoDialogAction(
          child: Text('ok'),
          isDefaultAction: true,
          onPressed: () => print('dialog cupertino'),
        )
      ],
    );
  }

  void _cancelNotification() {
    flutterLocalNotificationsPlugin.cancel(0);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now();
    final dateNowPlus1 = DateTime.now().add(Duration(seconds: 1));
    final convertIntPlus1 = dateNowPlus1.millisecondsSinceEpoch;
    final convertInt = dateNow.millisecondsSinceEpoch;
    print("$convertInt \n $convertIntPlus1");
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ButtonCustom(
              padding: const EdgeInsets.all(8),
              onPressed: _showNotification,
              buttonTitle: 'Testing notification',
            ),
            ButtonCustom(
              padding: const EdgeInsets.all(8),
              onPressed: _cancelNotification,
              buttonTitle: 'Cancel notification',
              buttonColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
