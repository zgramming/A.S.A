import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/global_provider.dart';

class CopyRightVersion extends StatefulWidget {
  final String copyRight;
  final Color colorText;

  CopyRightVersion({
    this.copyRight = "Copyright \u00a9 Zeffry Reynando ",
    this.colorText = Colors.white,
  });

  @override
  _CopyRightVersionState createState() => _CopyRightVersionState();
}

class _CopyRightVersionState extends State<CopyRightVersion> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: widget.colorText),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Consumer<GlobalProvider>(
            builder: (_, gProvider, __) => Text(
              "${gProvider.projectName} | Version ${gProvider.projectVersion}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            widget.copyRight,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
