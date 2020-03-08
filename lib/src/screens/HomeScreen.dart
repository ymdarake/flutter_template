import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/src/change_notifiers/ThemeModeNotifier.dart';
import 'package:flutter_template/src/widgets/AppBottomNavigationBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  Animation<double> iconAnimation;
  AnimationController iconAnimationController;

  @override
  void initState() {
    super.initState();
    iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    iconAnimation = Tween(begin: 0.0, end: 1.0).animate(iconAnimationController);
  }

  @override
  void dispose() {
    iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeModeNotifier notifier = Provider.of<ThemeModeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Template"),
        leading: GestureDetector(
          onTap: () {
            if (iconAnimationController.status == AnimationStatus.dismissed) {
              iconAnimationController.forward();
            } else if (iconAnimationController.status == AnimationStatus.completed) {
              iconAnimationController.reverse();
            }
          },
          child: Center(
            child: AnimatedIcon(
              progress: iconAnimation,
              icon: AnimatedIcons.menu_close,
            ),
          ),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            children: <Widget>[
              Text("I hope this will help! :)"),
              Text("Toggle to Dark Mode!"),
              Switch(
                value: notifier.mode == ThemeMode.dark,
                onChanged: (value) => notifier.toggle(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
