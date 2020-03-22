import 'package:flutter/material.dart';
import '../providers/main_calendar_provider.dart';
import '../widgets/empty_nearby_activity.dart';
import '../widgets/nearby_activity_list.dart';
import 'package:provider/provider.dart';

class NearbyActivity extends StatelessWidget {
  final DateTime test = DateTime.now();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    final mainCalendarProvider = Provider.of<MainCalendarProvider>(context);

    return RefreshIndicator(
      onRefresh: () async => mainCalendarProvider.updateStatusWhenDatePassed(),
      key: _refreshIndicatorKey,
      child: SingleChildScrollView(
        /// Dibutuhkan Jika Kamu Butuh Widget RefreshIndicator Didalam SingleChildScrollView
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            mainCalendarProvider.nearby10ActivityItem.length == 0
                ? Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: EmptyNearbyActivity(),
                  )
                : NearbyActivityList(
                    mcProvider: mainCalendarProvider,
                    limitedActivityList:
                        mainCalendarProvider.nearby10ActivityItem,
                  ),
          ],
        ),
      ),
    );
  }
}
