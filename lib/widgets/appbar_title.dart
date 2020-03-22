import 'package:flutter/material.dart';
import '../variable/sizes/sizes.dart';

class AppBarTitle extends StatelessWidget {
  final String titleAppBar;

  AppBarTitle({@required this.titleAppBar});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizes.height(context) / 4,
      width: sizes.width(context) / 1.25,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 32.0),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          titleAppBar,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: sizes.width(context),
            fontFamily: 'Lobster',
          ),
        ),
      ),
    );
  }
}
