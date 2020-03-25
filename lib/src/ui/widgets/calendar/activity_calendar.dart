import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../providers/main_calendar_provider.dart';
import '../../screens/add_activity_screen.dart';
import '../../variable/config/app_config.dart';

import '../calendar/activity_calendar_marker.dart';
import '../calendar/activity_calendar_holiday_marker.dart';

class ActivityCalendar extends StatefulWidget {
  final Function(DateTime, List<dynamic>) onDaySelected;
  ActivityCalendar({
    @required this.onDaySelected,
  });
  @override
  _ActivityCalendarState createState() => _ActivityCalendarState();
}

class _ActivityCalendarState extends State<ActivityCalendar> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    return;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainCalendarProvider>(
      builder: (_, mcProvider, __) => Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: 3,
        child: TableCalendar(
          calendarController: _calendarController,
          locale: appConfig.indonesiaLocale,
          headerStyle: calendarHeaderStyle(context),
          events: mcProvider.activityBasedOnDate,
          onDaySelected: widget.onDaySelected,
          onDayLongPressed: (date, activity) {
            DateTime dateRevision = DateTime(date.year, date.month, date.day);
            mcProvider.setDateOnLongPressCalendar(dateRevision);
            Navigator.of(context).pushNamed(AddActivityScreen.routeName);
          },
          builders: CalendarBuilders(
            markersBuilder: (context, date, activitiy, holidays) {
              /// Digunakan Untuk Mendapatkan Jumlah Aktifitas Yang Belum Selesai
              final Iterable result =
                  activitiy.where((element) => element.isDoneActivity == 0);
              final int activityUnfinished = result.length;
              final children = <Widget>[];
              if (activitiy.isNotEmpty) {
                children.add(
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: ActivityCalendarMarker(
                      calendarController: _calendarController,
                      date: date,
                      activity: activitiy,
                      activityUnFinished: activityUnfinished,
                    ),
                  ),
                );
              }
              if (holidays.isNotEmpty) {
                children.add(
                  Positioned(
                    right: -2,
                    top: -2,
                    child: ActivityCalendarHolidaysMarker(),
                  ),
                );
              }
              return children;
            },
          ),
        ),
      ),
    );
  }

  HeaderStyle calendarHeaderStyle(BuildContext context) {
    return HeaderStyle(
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      headerMargin: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
      centerHeaderTitle: true,
      titleTextBuilder: (date, locale) =>
          DateFormat.yMMMM(appConfig.indonesiaLocale).format(date),
      formatButtonVisible: false,
    );
  }
}
