import 'package:flutter/material.dart';
import './routes/routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      onGenerateRoute: router,
    );
    ;
  }
}
