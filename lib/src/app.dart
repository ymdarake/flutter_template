import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './change_notifiers/ThemeModeNotifier.dart';
import './routes/routes.dart';

const primaryColor = Color.fromRGBO(97, 62, 234, 1);
MaterialColor primarySwatch = MaterialColor(primaryColor.value, {
  50: const Color(0xece8fc),
  100: const Color(0xd0c5f9),
  200: const Color(0xb09ff5),
  300: const Color(0x9078f0),
  400: const Color(0x795bed),
  500: const Color(0x613eea),
  600: const Color(0x5938e7),
  700: const Color(0x4f30e4),
  800: const Color(0x4528e1),
  900: const Color(0x331bdb),
});

class App extends StatelessWidget {
  final ThemeModeNotifier themeModeNotifier = ThemeModeNotifier();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => themeModeNotifier,
      child: Consumer<ThemeModeNotifier>(
        builder: (context, value, child) {
          return _buildApp(value.mode);
        },
        child: _buildApp(themeModeNotifier.mode),
      ),
    );
  }

  Widget _buildApp(ThemeMode mode) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: mode,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: primarySwatch,
      ),
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      onGenerateRoute: router,
    );
  }
}
