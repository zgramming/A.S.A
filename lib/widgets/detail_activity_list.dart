import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/activity/activity_model.dart';
import '../variable/colors/color_pallete.dart';
import '../variable/config/app_config.dart';
import '../variable/sizes/sizes.dart';

import 'button_custom.dart';

class DetailActivityList extends StatelessWidget {
  final ActivityModel result;
  DetailActivityList({@required this.result});

  @override
  Widget build(BuildContext context) {
    final convertDateActivityFromStringToDateTime =
        DateTime.parse(result.dateTimeActivity);
    final convertCreatedDateToDateTime =
        DateTime.parse(result.createdDateActivity);
    final formatTime =
        DateFormat.Hm().format(convertDateActivityFromStringToDateTime);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: result.isDoneActivity == 0
            ? BorderSide(
                color: Colors.yellow[700],
                width: 2,
              )
            : BorderSide(
                color: Colors.green,
                width: 2,
              ),
      ),
      titlePadding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      title: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              height: sizes.height(context) / 14,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FittedBox(
                child: Icon(
                  IconData(
                    result.codeIconActivity,
                    fontFamily: appConfig.fontFamilyIcon,
                  ),
                  color: colorPallete.white,
                ),
              ),
            ),
          ),
          Flexible(
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                ),
                child: Text(
                  result.titleActivity,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            fit: FlexFit.tight,
            flex: 3,
          )
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 4.0,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Divider(),
          Text(
            formatTime,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: colorPallete.bottomTitleMainCalendarDynamicColor(
                context,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            result.informationActivity,
            style: TextStyle(
              fontSize: 11.0,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Dibuat Pada : ${DateFormat.yMMMMEEEEd(appConfig.indonesiaLocale).format(convertCreatedDateToDateTime)}',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
        ],
      ),
      actions: <Widget>[
        ButtonCustom(
          buttonSize: 4,
          buttonTitle: 'Tutup',
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
