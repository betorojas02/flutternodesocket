import 'package:flutter/material.dart';
import 'package:flutteravanzad/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home' : (_) => HomePage(),
      },

    );
  }
}
