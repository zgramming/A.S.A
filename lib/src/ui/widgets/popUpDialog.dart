import 'package:flutter/material.dart';

class PopUpDialog extends StatelessWidget {
  final String title;
  final String titleSecondary;
  final String titlePrimary;
  final Function onTap;
  PopUpDialog({
    this.title = '',
    this.titleSecondary = 'Batal',
    this.titlePrimary = 'Hapus',
    @required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(titleSecondary),
        ),
        FlatButton(
          onPressed: onTap,
          color: Theme.of(context).accentColor,
          child: Text(titlePrimary),
        ),
      ],
    );
  }
}
