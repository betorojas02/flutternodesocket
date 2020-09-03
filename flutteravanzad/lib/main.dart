import 'package:flutter/material.dart';
import 'package:flutteravanzad/pages/home.dart';
import 'package:flutteravanzad/pages/status.dart';
import 'package:flutteravanzad/services/socket_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SocketService(),)
      ],
      child: MaterialApp(
        showSemanticsDebugger: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home' : (_) => HomePage(),
          'status' : (_) => StatusPage(),

        },

      ),
    );
  }
}
