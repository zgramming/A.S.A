import 'package:flutter/material.dart';

class DoubleTapToExit {
  DateTime _currentBackPressTime;
  Future<bool> doubleTapToExit({
    @required GlobalKey<ScaffoldState> scaffoldKey,
  }) async {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      scaffoldKey.currentState.hideCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Tekan Lagi Untuk Keluar"),
          backgroundColor: Colors.black54,
        ),
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}

final doubleTapToExit = DoubleTapToExit();
