import 'package:flutter/material.dart';

class ShowSnackBarMessage {
  void showSnackBarMessage({
    @required BuildContext context,
    @required String message,
    int duration = 2,
    bool isError = true,
  }) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError
            ? Theme.of(context).errorColor
            : Theme.of(context).primaryColor,
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
      ),
    );
  }
}

final showSnackbarMessage = ShowSnackBarMessage();
