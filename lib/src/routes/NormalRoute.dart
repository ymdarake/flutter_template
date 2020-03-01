import 'package:flutter/material.dart';

/// 普通のトランジション
///@link https://stackoverflow.com/questions/43680902/replace-initial-route-in-materialapp-without-animation/43685697#43685697
class NormalRoute<T> extends MaterialPageRoute<T> {
  NormalRoute({WidgetBuilder builder, RouteSettings settings}) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return child;
//   return FadeTransition(opacity: animation, child: child);
  }
}
