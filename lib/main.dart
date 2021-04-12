import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healery/Helpers/themes.dart';
import 'package:healery/Providers/auth.dart';
import 'package:healery/Screens/auth_screen.dart';
import 'package:healery/Screens/home.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:splashscreen/splashscreen.dart';

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
      home: SplashScreen(
        seconds: 3,
        backgroundColor: Color(0xFF6f5975),
        image: Image.asset(
          'assets/images/new-logo1.png',
          color: Colors.white,
        ),
        title: Text(
          'Healery',
          style: TextStyle(
            fontFamily: 'Dancing',
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        photoSize: 150,
        loaderColor: Colors.white,
        navigateAfterSeconds: auth.isSignedIn ? Home() : AuthScreen(),
      ),
      // home: AnimatedSplashScreen(
      //   splash: Image.asset(
      //     'assets/images/logo.png',
      //     color: Colors.white,
      //   ),
      //   nextScreen: auth.isSignedIn ? Home() : AuthScreen(),
      //   splashTransition: SplashTransition.scaleTransition,
      //   backgroundColor: Color(0xFF6f5975),
      //   duration: 3000,
      // ),
    );
  }
}
