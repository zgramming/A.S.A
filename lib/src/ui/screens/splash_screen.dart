import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './welcome_screen.dart';
import './update_app_screen.dart';

import '../template/splashscreen_template/splashscreen_template.dart';
import '../template/splashscreen_template/widgets/splashscreen_image_asset.dart';
import '../variable/config/app_config.dart';

import '../../providers/global_provider.dart';
import '../../providers/main_calendar_provider.dart';
import '../../function/update_app_playstore.dart';

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
      body: Consumer<GlobalProvider>(
        builder: (_, globalProvider, __) => FutureBuilder(
          // future: updateAppPlaystore.isNeedUpdate("6"),
          future: updateAppPlaystore.isNeedUpdate(globalProvider.projectCode),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                final bool _isNeedUpdate = snapshot.data;
                if (_isNeedUpdate) {
                  return UpdateAppScreen();
                } else {
                  return SplashScreenTemplate(
                    backgroundColor: Theme.of(context).primaryColor,
                    image: SplashScreenImageAsset(
                      locationImage: appConfig.locationImageSplashScreen,
                      imageHeight: 2.5,
                    ),
                    duration: 2,
                    navigateAfterSplashScreen: WelcomeScreen(),
                  );
                }
              }
            }
          },
        ),
      ),
    );
  }
}
