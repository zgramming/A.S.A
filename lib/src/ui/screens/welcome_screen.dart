import 'package:flutter/material.dart';

import './settings_screen.dart';
import './main_calendar_screen.dart';
import './nearby_activity_screen.dart';

import '../template/splashscreen_template/widgets/splashscreen_image_asset.dart';
import '../variable/config/app_config.dart';
import '../widgets/bottomnavigationbar_custom.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome-screen';
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarCustom(
      imageLogoBuilder: SplashScreenImageAsset(
        locationImage: appConfig.locationImageSplashScreen,
        imageHeight: 12,
      ),
      screens: [
        NearbyActivity(),
        MainCalendarScreen(),
        SettingsScreen(),
      ],
    );
  }
}
