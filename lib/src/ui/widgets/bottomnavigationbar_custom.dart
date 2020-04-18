import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/appbar_custom.dart';

import '../../providers/main_calendar_provider.dart';
import '../../providers/global_provider.dart';
import '../../function/double_tap_to_exit.dart';
import 'dart:async';
// import '../screens/add_activity_screen.dart';
// import '../screens/main_calendar_screen.dart';
// import '../screens/nearby_activity_screen.dart';
// import '../screens/settings_screen.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  /// Count of screen must be same with count of Items in BottomNavigationBarCustom
  final List<Widget> screens;

  /// Change Color Icon And Text if items is selected
  final Color selectedItemsColor;

  /// Change Color Icon And Text if items is unselected
  final Color unselectedItemsColor;

  /// Change Size Of Icon if Items is Selected
  final double selectedIconSize;

  /// Image Logo For AppBar
  final Widget imageLogoBuilder;
  BottomNavigationBarCustom({
    @required this.screens,
    @required this.imageLogoBuilder,
    this.selectedItemsColor = Colors.white,
    this.unselectedItemsColor = Colors.white70,
    this.selectedIconSize = 28.0,
  });
  @override
  _BottomNavigationBarCustomState createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer timerCheckActivityPassed;

  @override
  void initState() {
    super.initState();
    final mcProvider =
        Provider.of<MainCalendarProvider>(context, listen: false);
    timerCheckActivityPassed = Timer.periodic(Duration(minutes: 1), (timer) {
      print("Jalankan Perintah Setiap 1 Menit");
      mcProvider.updateStatusWhenDatePassed();
    });
  }

  @override
  void dispose() {
    timerCheckActivityPassed.cancel();
    super.dispose();
  }

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.near_me),
      title: Text('Aktifitas Terdekat'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.event),
      title: Text('Kalendar Utama'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text('Pengaturan'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final globalProvider = Provider.of<GlobalProvider>(context);
    final mainCalendarProvider = Provider.of<MainCalendarProvider>(context);
    return WillPopScope(
      onWillPop: () =>
          doubleTapToExit.doubleTapToExit(scaffoldKey: _scaffoldKey),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBarCustom(
          appBar: AppBar(),
          titleAppBar: globalProvider.currentIndexBottomNavigation == 1
              ? widget.imageLogoBuilder
              : globalProvider.currentAppBarBottomNavigation,
          onTap: () async => mainCalendarProvider.updateStatusWhenDatePassed(),
        ),
        body: IndexedStack(
          index: globalProvider.currentIndexBottomNavigation,
          children: widget.screens,
        ),
        // body: widget.screens
        //     .elementAt(globalProvider.currentIndexBottomNavigation),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: items,
          selectedIconTheme: IconThemeData(size: widget.selectedIconSize),
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: globalProvider.currentIndexBottomNavigation,
          unselectedItemColor: widget.unselectedItemsColor,
          selectedItemColor: widget.selectedItemsColor,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: (int index) {
            globalProvider.setCurrentIndexBottomNavigation(index);
            switch (index) {
              case 0:
                return globalProvider.setCurrentAppBarBottomNavigation(
                  Text('Aktifitas Terdekat'),
                );
                break;
              case 1:
                return globalProvider.setCurrentAppBarBottomNavigation(
                  Text('Kalendar Aktifitas'),
                );
                break;
              case 2:
                return globalProvider.setCurrentAppBarBottomNavigation(
                  Text('Pengaturan'),
                );
                break;
              default:
                return null;
            }
          },
        ),
      ),
    );
  }
}

// return Scaffold(
//   appBar: AppBarCustom(
//     appBar: AppBar(),
//     titleAppBar: globalProvider.currentAppBarBottomNavigation,
//     onTap: () => mainCalendarProvider.updateStatusWhenDatePassed(),
//   ),
// navigationBar: CupertinoNavigationBar(
//   backgroundColor: Theme.of(context).primaryColor,
//   middle: globalProvider.currentAppBarBottomNavigation,
//   trailing: IconButton(
//     icon: Icon(Icons.refresh),
//     onPressed: () => mainCalendarProvider.updateStatusWhenDatePassed(),
//   ),
// ),
//!TODO Ganti Title AppBar Secara Dynamic
//   body: CupertinoTabScaffold(
//     tabBar: CupertinoTabBar(items: items),
//     tabBuilder: (context, index) {
//       switch (index) {
//         case 0:
//           return CupertinoTabView(
//             builder: (context) => CupertinoPageScaffold(
//               child: NearbyActivity(),
//             ),
//           );
//           break;
//         case 1:
//           return CupertinoTabView(
//             routes: {
//               AddActivityScreen.routeName: (context) => AddActivityScreen(),
//             },
//             builder: (context) => CupertinoPageScaffold(
//               child: MainCalendarScreen(),
//             ),
//           );
//           break;
//         case 2:
//           return CupertinoTabView(
//             builder: (context) => CupertinoPageScaffold(
//               child: SettingsScreen(),
//             ),
//           );
//           break;
//         default:
//           return const CupertinoTabView();
//       }
//     },
//   ),
// );
