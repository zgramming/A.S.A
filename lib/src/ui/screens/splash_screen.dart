import 'package:flutter/cupertino.dart';
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
