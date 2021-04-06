import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healery/Helpers/themes.dart';
import 'package:healery/Providers/auth.dart';
import 'package:healery/Screens/auth_screen.dart';
import 'package:healery/Screens/home.dart';
import 'package:provider/provider.dart';

FirebaseFirestore DB;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DB = FirebaseFirestore.instance;
  await auth.fetchUserInfo();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Auth(),
      ),
    ],
    child: MyApp(),
  ));
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
      home: auth.isSignedIn ? Home() : AuthScreen(),
    );
  }
}
