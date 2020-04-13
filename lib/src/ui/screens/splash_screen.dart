import 'dart:async';

import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
    _duration = Duration(seconds: 1);
    _count = 0;
    _timer = Timer.periodic(_duration, (timer) {
      print(_count);
      return _count++;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
