import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../network/models/activity/activity_model.dart';
import '../../providers/main_calendar_provider.dart';

import '../variable/colors/color_pallete.dart';
import '../variable/config/app_config.dart';
import '../variable/sizes/sizes.dart';

class NearbyActivityList extends StatelessWidget {
  const NearbyActivityList({
    Key key,
    @required this.mcProvider,
    @required this.limitedActivityList,
  }) : super(key: key);

  final List<ActivityModel> limitedActivityList;
  final MainCalendarProvider mcProvider;

  @override
  Widget build(BuildContext context) {
    return GroupedListView<ActivityModel, String>(
      shrinkWrap: true,
      groupBy: (ActivityModel element) {
        /// Disini Berfungsi Untuk Group List berdasarkan Format Tanggal, Bulan , Tahun => 25 Maret 2020
        DateTime convertStringToDateTime =
            DateTime.parse(element.dateTimeActivity);
        return DateFormat.yMMMMd(appConfig.indonesiaLocale)
            .format(convertStringToDateTime);
      },
      elements: limitedActivityList,
      sort: true,
      physics: NeverScrollableScrollPhysics(),
      groupSeparatorBuilder: (value) {
        /// Return Dari Group Tadi ditampilkan disini
        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      },
      itemBuilder: (BuildContext c, ActivityModel activitiyItem) {
        DateTime convertDateActivityFromStringToDateTime =
            DateTime.parse(activitiyItem.dateTimeActivity);
        String formatTime =
            DateFormat.Hm().format(convertDateActivityFromStringToDateTime);
        final remainingDayDate = convertDateActivityFromStringToDateTime
            .difference(DateTime.now())
            .inDays;
        final remainingHoursDate = convertDateActivityFromStringToDateTime
            .difference(DateTime.now())
            .inHours;
        final remainingMinuteDate = convertDateActivityFromStringToDateTime
            .difference(DateTime.now())
            .inMinutes;
        final remainingSecondDate = convertDateActivityFromStringToDateTime
            .difference(DateTime.now())
            .inSeconds;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
          elevation: 5.0,
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(4.0),
              width: sizes.width(context) / 6,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              child: FittedBox(
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorPallete.grey,
                    ),
                    children: [
                      if (remainingDayDate > 0) ...[
                        TextSpan(text: remainingDayDate.toString()),
                        TextSpan(text: 'Hari', style: TextStyle(fontSize: 4))
                      ] else if (remainingHoursDate > 0) ...[
                        TextSpan(text: remainingHoursDate.toString()),
                        TextSpan(text: 'Jam', style: TextStyle(fontSize: 4))
                      ] else if (remainingMinuteDate > 0) ...[
                        TextSpan(text: remainingMinuteDate.toString()),
                        TextSpan(text: 'Menit', style: TextStyle(fontSize: 4))
                      ] else if (remainingSecondDate > 0) ...[
                        TextSpan(text: remainingSecondDate.toString()),
                        TextSpan(text: 'Detik', style: TextStyle(fontSize: 4))
                      ] else ...[
                        TextSpan(text: ' Selesai'),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            title: Text(
              activitiyItem.titleActivity,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(formatTime),
            trailing: Image.asset(
              activitiyItem.isDoneActivity == 0
                  ? 'assets/images/process.png'
                  : 'assets/images/done.png',
              fit: BoxFit.cover,
              height: sizes.height(context) / 20,
            ),
          ),
        );
      },
    );
  }
}
