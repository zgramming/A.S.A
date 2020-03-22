import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class GlobalProvider extends ChangeNotifier {
  GlobalProvider() {
    _getPackageInfo();
  }

  //! For BottomNavigationBarCustom On Tap

  int _currentIndexBottomNavigation = 1;

  /// Untuk Mengatur Halaman Yang Pertama Kali Akan Tampil Setelah Login
  int get currentIndexBottomNavigation => _currentIndexBottomNavigation;

  Widget _currentAppBarBottomNavigation = Text("Kalendar Aktifitas");
  Widget get currentAppBarBottomNavigation => _currentAppBarBottomNavigation;

  int setCurrentIndexBottomNavigation(int index) {
    int result = index;
    _currentIndexBottomNavigation = result;
    notifyListeners();
    return result;
  }

  Widget setCurrentAppBarBottomNavigation(Widget appbarBottomNavigation) {
    Widget result = appbarBottomNavigation;
    _currentAppBarBottomNavigation = result;
    notifyListeners();
    return result;
  }

  //! Get Device Info Like AppName , Version etc.

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    buildNumber: 'Unknown',
    packageName: 'Unkwon',
    version: 'Unknown',
  );
  PackageInfo get packageInfo => _packageInfo;
  String get appNamePackageInfo => packageInfo.appName;
  String get buildNumberPackageInfo => packageInfo.buildNumber;
  String get packageNamePackageInfo => packageInfo.packageName;
  String get versionPackageInfo => packageInfo.version;

  Future<PackageInfo> _getPackageInfo() async {
    final result = await PackageInfo.fromPlatform();
    _packageInfo = result;
    notifyListeners();
    return result;
  }

  //!======================================================================================================================================================================

  //! Hide and Show Password TextFormFieldCustom
  bool _obsecurePassword = true;
  bool get obsecurePassword => _obsecurePassword;
  setObsecurePassword(bool value) {
    _obsecurePassword = !value;
    notifyListeners();
  }
  //!======================================================================================================================================================================

}
