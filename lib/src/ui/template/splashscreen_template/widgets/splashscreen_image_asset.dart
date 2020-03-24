import 'package:flutter/material.dart';
import '../../../variable/sizes/sizes.dart';

class SplashScreenImageAsset extends StatelessWidget {
  final String locationImage;
  final double imageHeight;

  SplashScreenImageAsset({@required this.locationImage, this.imageHeight = 8});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      locationImage,
      fit: BoxFit.fill,
      height: sizes.height(context) / imageHeight,
    );
  }
}
