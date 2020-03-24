import 'package:flutter/material.dart';
import '../../variable/sizes/sizes.dart';
import 'package:table_calendar/table_calendar.dart';

class ActivityCalendarMarker extends StatelessWidget {
  final CalendarController calendarController;
  final DateTime date;
  final List<dynamic> activity;
  final int activityUnFinished;
  ActivityCalendarMarker({
    @required this.calendarController,
    @required this.date,
    @required this.activity,
    @required this.activityUnFinished,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: calendarController.isSelected(date)
            ? Theme.of(context).primaryColor.withOpacity(.7)
            : calendarController.isToday(date)
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor,
      ),
      width: sizes.width(context) / 20,
      height: sizes.width(context) / 20,
      child: Center(
        child: FittedBox(
          child: activityUnFinished == 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                  ),
                )
              : Text(
                  '$activityUnFinished',
                  style: TextStyle().copyWith(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
