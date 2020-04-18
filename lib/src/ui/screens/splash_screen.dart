import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './welcome_screen.dart';

import '../template/splashscreen_template/splashscreen_template.dart';
import '../template/splashscreen_template/widgets/splashscreen_image_asset.dart';
import '../variable/config/app_config.dart';

import '../../providers/main_calendar_provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeNamed = '/splashscreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final mainCalendarProvider =
        Provider.of<MainCalendarProvider>(context, listen: false);
    mainCalendarProvider.updateStatusWhenDatePassed();
  }

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
