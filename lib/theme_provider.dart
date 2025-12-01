import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  String _userName = '';
  String get userName => _userName;

  static const String _themekey = 'theme_key';
  static const String _userKey = 'username_key';

  ThemeProvider() {
    _loadTheme();
    loadUser();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themekey) ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme(bool isOn) async {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themekey, isOn);
    notifyListeners();
  }

  void saveUser(String user) async {
    _userName = user;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, user);
    notifyListeners();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString(_userKey) ?? '';
    notifyListeners();
  }
}
