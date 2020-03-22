import 'package:flutter/material.dart';
import '../models/activity/activity_model.dart';
import '../variable/colors/color_pallete.dart';
import '../variable/config/app_config.dart';
import '../variable/sizes/sizes.dart';
import 'delete_activity_list.dart';
import 'detail_activity_list.dart';

class OperationCalendarList extends StatelessWidget {
  final ActivityModel activityModel;
  OperationCalendarList({@required this.activityModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizes.height(context) / 4.5,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            child: Text(
              'Operasi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                letterSpacing: 1.25,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: sizes.width(context) / 14,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  circleOperationCalendarList(
                    context: context,
                    colorCircle: Theme.of(context).errorColor,
                    icon: Icons.delete,
                    title: appConfig.hapus,
                    onTap: () {
                      Navigator.of(context).pop(true);
                      showDialog(
                        context: context,
                        builder: (ctxDialog) => DeleteActivityList(
                          activityModel: activityModel,
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 15),
                  circleOperationCalendarList(
                    context: context,
                    colorCircle: Colors.blue,
                    icon: Icons.edit,
                    title: appConfig.edit,
                    isVisible: activityModel.isDoneActivity == 1 ? false : true,
                  ),
                  SizedBox(width: 15),
                  circleOperationCalendarList(
                    context: context,
                    colorCircle: Colors.lightBlue,
                    icon: Icons.view_compact,
                    title: appConfig.detail,
                    onTap: () => showDialog(
                      context: context,
                      barrierDismissible: false,
                      child: DetailActivityList(
                        result: activityModel,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }

  Widget circleOperationCalendarList({
    @required BuildContext context,
    @required Color colorCircle,
    @required IconData icon,
    @required String title,
    Function onTap,
    bool isVisible = true,
  }) =>
      Visibility(
        visible: isVisible,
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: onTap,
              splashColor: colorCircle,
              child: CircleAvatar(
                backgroundColor: colorCircle,
                child: FittedBox(
                  child: Icon(
                    icon,
                    size: 32,
                    color: colorPallete.white,
                  ),
                ),
                radius: sizes.width(context) / 12,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
}
