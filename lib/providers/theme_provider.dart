import 'package:cryptotracker/services/LocalStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode themeMode;

  ThemeProvider(String theme) {
    if(theme == "light") {
      themeMode = ThemeMode.light;
    }
    else {
      themeMode = ThemeMode.dark;
    }
  }

  void toggleTheme() async {
    if(themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      await LocalStorage.saveTheme("dark");
    }
    else {
      themeMode = ThemeMode.light;
      await LocalStorage.saveTheme("light");
    }

    notifyListeners();
  }
}