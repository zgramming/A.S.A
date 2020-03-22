import 'dart:ui';
import 'package:flutter/material.dart';

class ColorPallete {
  Brightness getAppTheme(BuildContext context) => Theme.of(context).brightness;
  Color white = Color(0xFFFFFFFF);
  Color black = Color(0xFF000000);
  Color transparent = Color(0x00000000);

  /// Grey
  Color grey = Color(0xFFeaeaea);
  Color greyTransparent = Color(0xFFBDBDBD);

  ///Primary Color
  Color primaryColor = Color(0xff00adb5);

  ///Accent Color
  Color accentColor = Color(0xff4d089a);

  //DarkMode Color
  // Color darkModeColor = Color(0xff121212);
  Color accentDarkModeColor = Color(0xFFf638dc);

  /// Default Dynamic Text Color DarkMode
  Color defaultTextDynamicColor(BuildContext context) =>
      (getAppTheme(context) == Brightness.dark ? white : black);

  /// Card Dynamic Color For DarkMode
  Color cardDynamicColor(BuildContext context) =>
      (getAppTheme(context) == Brightness.dark)
          ? Theme.of(context).primaryColor
          : Colors.white;

  /// BottomTitleMainCalendarDynamicColor Dynamic Color For DarkMode
  Color bottomTitleMainCalendarDynamicColor(BuildContext context) =>
      (getAppTheme(context) == Brightness.dark)
          ? accentDarkModeColor
          : accentColor;

  /// ButtonDynamicColor Dynamic Color For DarkMode
  Color buttonDynamicColor(BuildContext context) =>
      (getAppTheme(context) == Brightness.dark)
          ? accentDarkModeColor
          : accentColor;

  /// circleAvatarPickerIconDynamicColor Dynamic Color For DarkMode
  Color circleAvatarPickerIconDynamicColor(BuildContext context) =>
      (getAppTheme(context) == Brightness.dark)
          ? accentDarkModeColor
          : accentColor;

  /// cupertinoDateTimeTextDynamicColor Dynamic Color For DarkMode
  Color cupertinoDateTimeTextDynamicColor(BuildContext context) =>
      (getAppTheme(context) == Brightness.dark) ? white : black;

  /// dividerDynamicColor Dynamic Color For DarkMode
  Color dividerDynamicColor(BuildContext context) =>
      (getAppTheme(context) == Brightness.dark)
          ? Theme.of(context).primaryColor
          : greyTransparent;

  /// circleAvatarIconDynamicColor Dynamic Color For DarkMode
  Color circleAvatarIconDynamicColor({
    @required BuildContext context,
    bool isDeleteIcon = false,
  }) =>
      (getAppTheme(context) == Brightness.dark)
          ? Colors.white
          : isDeleteIcon ? Theme.of(context).errorColor : Colors.blue[800];
}

final colorPallete = ColorPallete();
