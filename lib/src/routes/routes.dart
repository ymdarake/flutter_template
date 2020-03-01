import 'package:flutter/material.dart';
import 'package:flutter_template/src/routes/FadeRoute.dart';
import 'package:flutter_template/src/screens/HomeScreen.dart';
import 'package:flutter_template/src/screens/CalendarScreen.dart';
import '../routes/NormalRoute.dart';

//NOTE: refactor: respect the paths order in AppBottomNavigationBar
const ROUTES = ['/home', '/calendar'];
Route<dynamic> router(RouteSettings settings) {
  switch (settings.name) {
    case '/home':
      return NormalRoute(builder: (_) => HomeScreen(), settings: settings);
    case '/calendar':
      return FadeRoute(widget: CalendarScreen());
    default:
      return NormalRoute(builder: (_) => HomeScreen(), settings: settings);
  }
}
