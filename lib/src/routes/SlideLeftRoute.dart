import 'package:flutter/material.dart';

/// @link https://medium.com/@agungsurya/create-custom-router-transition-in-flutter-using-pageroutebuilder-73a1a9c4a171
class SlideLeftRoute extends PageRouteBuilder {
  final Widget widget;
  SlideLeftRoute({this.widget})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return new SlideTransition(
              position: new Tween<Offset>(begin: const Offset(1.0, 0), end: Offset.zero).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: child,
            );
          },
        );
}
