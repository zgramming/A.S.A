import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final bool centerTitle;
  final Widget titleAppBar;
  final Function onTap;
  AppBarCustom({
    @required this.appBar,
    this.centerTitle = false,
    this.titleAppBar,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: centerTitle,
      title: titleAppBar,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: onTap,
        )
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
