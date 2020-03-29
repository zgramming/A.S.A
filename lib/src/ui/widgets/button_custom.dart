import 'package:flutter/material.dart';

import '../variable/colors/color_pallete.dart';
import '../variable/sizes/sizes.dart';

class ButtonCustom extends StatelessWidget {
  final Function onPressed;
  final Color buttonColor;
  final String buttonTitle;
  final double buttonSize;
  ButtonCustom({
    this.onPressed,
    this.buttonColor = Colors.grey,
    this.buttonTitle = "Selesai",
    this.buttonSize = 1,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizes.width(context) / buttonSize,
      child: RaisedButton(
        onPressed: onPressed,
        textTheme: ButtonTextTheme.primary,
        color: colorPallete.buttonDynamicColor(context),
        child: Text(
          buttonTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
