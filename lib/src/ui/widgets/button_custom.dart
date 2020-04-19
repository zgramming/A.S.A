import 'package:flutter/material.dart';

import '../variable/colors/color_pallete.dart';
import '../variable/sizes/sizes.dart';

class ButtonCustom extends StatelessWidget {
  final Function onPressed;
  final Color buttonColor;
  final String buttonTitle;
  final double buttonSize;
  final EdgeInsetsGeometry padding;
  ButtonCustom({
    this.onPressed,
    this.buttonColor,
    this.buttonTitle = "Selesai",
    this.buttonSize = 1,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: sizes.width(context) / buttonSize,
      child: RaisedButton(
        onPressed: onPressed,
        textTheme: ButtonTextTheme.primary,
        color: buttonColor ?? colorPallete.buttonDynamicColor(context),
        child: FittedBox(
          child: Text(
            buttonTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
