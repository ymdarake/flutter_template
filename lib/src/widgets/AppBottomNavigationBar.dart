import 'package:flutter/material.dart';
import '../routes/routes.dart';

class AppBottomNavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  static int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: ((index) {
        if (index != currentIndex) {
          currentIndex = index;
          Navigator.pushReplacementNamed(context, ROUTES[index]);
        }
      }),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.view_comfy), title: Text('')),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text('')),
      ],
    );
  }
}
