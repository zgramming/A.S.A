import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './detail_activity_list.dart';

import '../variable/colors/color_pallete.dart';
import '../variable/config/app_config.dart';
import '../variable/sizes/sizes.dart';
import '../widgets/popUpDialog.dart';

import '../../providers/main_calendar_provider.dart';
import '../../ui/screens/add_activity_screen.dart';
import '../../network/models/activity/activity_model.dart';
import '../../function/show_schedule_notification.dart';

class OperationCalendarList extends StatelessWidget {
  final ActivityModel activityModel;

  final ShowNotificationSchedule notificationSchedule =
      ShowNotificationSchedule();

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
                  Consumer<MainCalendarProvider>(
                    builder: (_, mcProvider, __) => circleOperationCalendarList(
                        context: context,
                        colorCircle: Theme.of(context).errorColor,
                        icon: Icons.delete,
                        title: appConfig.hapus,
                        onTap: () => showDialog(
                              context: context,
                              child: PopUpDialog(
                                title:
                                    'Kamu Yakin Ingin Menghapus Aktifitas ini ?',
                                onTap: () {
                                  int count = 0;
                                  mcProvider
                                      .deleteActivityById(
                                        activityModel.idActivity,
                                      )
                                      .then(
                                        (_) => notificationSchedule
                                            .cancelNotificationById(
                                          activityModel.idActivity,
                                        ),
                                      );

                                  /// Akan Melakukan Pop Sampai 2 Kali [Menutup Dialog dan ShowBottomSheet]
                                  Navigator.popUntil(
                                    context,
                                    (route) => count++ == 2,
                                  );
                                },
                              ),
                            )),
                  ),
                  SizedBox(width: 15),
                  //TODO Check Disnii ada bug apa tidak saat hapus aktifitas
                  Consumer<MainCalendarProvider>(
                    builder: (_, mcProvider, __) => circleOperationCalendarList(
                      context: context,
                      colorCircle: Colors.blue,
                      icon: Icons.edit,
                      title: appConfig.edit,
                      isVisible:
                          activityModel.isDoneActivity == 1 ? false : true,
                      onTap: () {
                        /// Menutup BottomSheet Sebelum Navigasi Ke Edit Activity
                        Navigator.of(context).pop();
                        final dateTimeActivity =
                            DateTime.parse(activityModel.dateTimeActivity);
                        DateTime initialDateCupertino = dateTimeActivity;
                        DateTime minDateCupertino = DateTime(
                          dateTimeActivity.year,
                          dateTimeActivity.month,
                          dateTimeActivity.day,
                        );
                        mcProvider.setDateCupertinoDatePicker(
                          initialDateCupertino: initialDateCupertino,
                          minDateCupertino: minDateCupertino,
                        );
                        Navigator.of(context).pushNamed(
                          AddActivityScreen.routeName,
                          arguments: activityModel,
                        );
                      },
                    ),
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

class EditActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 10,
        height: MediaQuery.of(context).size.height - 80,
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
              color: const Color(0xFF1BC0C5),
            )
          ],
        ),
      ),
    );
  }
}
