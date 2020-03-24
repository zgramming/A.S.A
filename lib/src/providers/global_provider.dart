import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';

class GlobalProvider extends ChangeNotifier {
  GlobalProvider() {
    _getVersion();
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
  String _platformVersion = 'Unknown';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';

  String get platformVersion => _platformVersion;
  String get projectVersion => _projectVersion;
  String get projectCode => _projectCode;
  String get projectAppID => _projectAppID;
  String get projectName => _projectName;

  Future _getVersion() async {
    try {
      _platformVersion = await GetVersion.platformVersion;
      _projectVersion = await GetVersion.projectVersion;
      _projectCode = await GetVersion.projectCode;
      _projectAppID = await GetVersion.appID;
      _projectName = await GetVersion.appName;
      notifyListeners();
    } catch (e) {
      return Future.error(e.toString());
    }
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
