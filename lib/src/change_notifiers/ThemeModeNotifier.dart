import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeModeNotifier extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  void toggle() {
    mode = mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
