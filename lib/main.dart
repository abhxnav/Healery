import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healery/Helpers/themes.dart';
import 'package:healery/Screens/auth_screen.dart';
import 'package:healery/Screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healery',
      theme: darkTheme,
      home: AuthScreen(),
    );
  }
}
