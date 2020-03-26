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

  /// Scaffold Color
  Color scaffoldColor = Color(0xFFf1f3f4);

  /// Scaffold Dark Color
  Color scaffoldDarkColor = Color(0xFF003545);

  // Color darkModeColor = Color(0xff121212);
  Color accentDarkModeColor = Color(0xFFf638dc);

  /// Dynamic Outline TextFormField Color
  Color focusTextFormFieldTextDynamicColor(BuildContext context) =>
      (getAppTheme(context) == Brightness.dark ? white : black.withOpacity(.6));

  /// Dynamic Outline TextFormField Color
  Color borderOutlineTextFormFieldDynamicColor(BuildContext context) =>
      (getAppTheme(context) == Brightness.dark ? white : accentColor);

  /// Default Dynamic Text Color DarkMode
  Color defaultTextDynamicColor(BuildContext context) =>
      (getAppTheme(context) == Brightness.dark ? white : black);

  /// Card Dynamic Color For DarkMode
  Color cardDynamicColor(BuildContext context) =>
      (getAppTheme(context) == Brightness.dark)
          ? Theme.of(context).primaryColor
          : white;

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
          ? white
          : isDeleteIcon ? Theme.of(context).errorColor : Colors.blue[800];
}

final colorPallete = ColorPallete();
