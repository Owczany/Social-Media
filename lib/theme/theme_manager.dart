import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

final box = Hive.box('Theme Mode');

void saveThemeMode(String? stringThemeMode) {
  box.delete('themeMode');
  box.put('themeMode', stringThemeMode);
}

String? stringThemeMode() {
  return box.get('themeMode') ?? 'system';
}

ThemeMode loadThemeMode(String? stringThemeMode) {
  switch (stringThemeMode) {
    case 'system':
      return ThemeMode.system;

    case 'light':
      return ThemeMode.light;

    case 'dark':
      return ThemeMode.dark;

    default:
      return ThemeMode.system;
  }
}

// class that operates theme modes and save information about them
class ThemeManager with ChangeNotifier {
  ThemeMode themeMode = loadThemeMode(stringThemeMode());

  // toggle between themes
  void toggleThemes(String? themes) {
    switch (themes) {
      case 'system':
        themeMode = ThemeMode.system;
        break;
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.system;
    }
    notifyListeners();
    saveThemeMode(themes);
  }
}

// dark theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  primaryColor: Colors.black,

  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    color: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),

  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey.shade900,
    onPrimary: Colors.white,
    secondary: Colors.grey.shade800,
  ),

  iconTheme: IconThemeData(
    color: Colors.grey.shade200,
  ),
);

// light theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  primaryColor: Colors.white,

    appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
    color: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),

  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade100,
  ),
);
