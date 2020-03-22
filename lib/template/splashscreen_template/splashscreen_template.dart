import 'dart:async';
import 'package:flutter/material.dart';
import '../../template/copyright_version_template/copyright_version_template.dart';

class SplashScreenTemplate extends StatefulWidget {
  final int duration;
  final Widget image;
  final Object navigateAfterSplashScreen;
  final Color backgroundColor;

  SplashScreenTemplate({
    this.duration = 3,
    this.backgroundColor = Colors.deepOrange,
    @required this.image,
    @required this.navigateAfterSplashScreen,
  });
  @override
  _SplashScreenTemplateState createState() => _SplashScreenTemplateState();
}

class _SplashScreenTemplateState extends State<SplashScreenTemplate> {
  startTime() async {
    var _duration = Duration(seconds: widget.duration);
    return Timer(_duration, navigationPage);
  }

  navigationPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => widget.navigateAfterSplashScreen),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 11,
            child: Container(
              alignment: Alignment.center,
              child: widget.image,
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: CopyRightVersion(),
            ),
          ),
        ],
      ),
    );
  }
}
