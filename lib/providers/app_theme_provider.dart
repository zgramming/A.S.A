import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  static const _APP_THEME = 'app_theme';
  AppThemeProvider() {
    _getAppThemeFromSharedPreferences();
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  setAppTheme(bool value) {
    _isDarkMode = value;
    _saveAppThemeToSharedPreferences(_isDarkMode);
    notifyListeners();
  }

  _saveAppThemeToSharedPreferences(bool spValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_APP_THEME, spValue);
    notifyListeners();
  }

  Future<bool> _getAppThemeFromSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final result = preferences.getBool(_APP_THEME);
    if (result == null) {
      return false;
    }
    _isDarkMode = result;
    notifyListeners();
    return result;
  }
}
