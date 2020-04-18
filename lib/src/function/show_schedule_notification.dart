import 'package:atur_semua_aktifitas/src/ui/variable/colors/color_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class ShowNotificationSchedule {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings _androidInitializationSettings;
  IOSInitializationSettings _iosInitializationSettings;
  InitializationSettings _initializationSettings;

  Future<void> showNotificationSchedule({
    @required DateTime dateTimeShowNotification,
    @required int idNotification,
    @required String titleNotification,
    @required String bodyNotification,
    @required String payloadNotification,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      idNotification.toString(),
      titleNotification,
      bodyNotification,
      priority: Priority.Max,
      importance: Importance.Max,
      color: colorPallete.primaryColor,
      ongoing: true,
      ticker: 'ticker',
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await _flutterLocalNotificationsPlugin.schedule(
      idNotification,
      titleNotification,
      bodyNotification,
      dateTimeShowNotification,
      notificationDetails,
      payload: payloadNotification,
    );
  }

  Future<void> cancelNotificationById(int idNotification) async {
    await _flutterLocalNotificationsPlugin.cancel(idNotification);
  }

  Future<void> cancelAllNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  ///! Should Be Initialize First Before used flutter local notification
  void initLocalNotification() async {
    _androidInitializationSettings = AndroidInitializationSettings('app_icon');
    _iosInitializationSettings = IOSInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    _initializationSettings = InitializationSettings(
      _androidInitializationSettings,
      _iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      _initializationSettings,
      onSelectNotification: _onSelectNotification,
    );
  }

  Future _onDidReceiveLocalNotification(
    int id,
    String title,
    String body,
    String payload,
  ) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        CupertinoDialogAction(
          child: Text('ok'),
          isDefaultAction: true,
          onPressed: () => print('dialog cupertino || $payload'),
        )
      ],
    );
  }

  Future<void> _onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }
}

final showNotificationSchedule = ShowNotificationSchedule();
