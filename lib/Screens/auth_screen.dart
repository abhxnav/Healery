import 'package:flutter/material.dart';
import 'package:healery/Providers/auth.dart';
import 'package:healery/Screens/home.dart';
import 'package:flutter_twitter/flutter_twitter.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Healery',
              style: TextStyle(
                fontFamily: 'Dancing',
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(height: 50),
            Divider(
              height: 20,
              thickness: 2, 
              indent: 50,
              endIndent: 50,
            ),
            SizedBox(height: 50),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await auth.googleSignIn();
                  setState(() {
                    isLoading = false;
                  });
                  if (auth.isSignedIn && auth.userData != null) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  width: 260,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google_logo.png',
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontFamily: 'Balsamiq',
                          color: Colors.white,
                        ),
                      ),
                      if (isLoading)
                        CircularProgressIndicator(
                          backgroundColor: Theme.of(context).backgroundColor,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await auth.googleSignIn();
                  setState(() {
                    isLoading = false;
                  });
                  if (auth.isSignedIn && auth.userData != null) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  width: 260,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/twitter_logo1.png',
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Continue with Twitter',
                        style: TextStyle(
                          fontFamily: 'Balsamiq',
                          color: Colors.white,
                        ),
                      ),
                      if (isLoading)
                        CircularProgressIndicator(
                          backgroundColor: Theme.of(context).backgroundColor,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// Container(
// width: 300,
// child: Column(
// children: [
// TextField(
// decoration: InputDecoration(
// contentPadding:
// EdgeInsets.symmetric(vertical: 0, horizontal: 15),
// fillColor: Colors.grey.shade900,
// focusColor: Theme.of(context).backgroundColor,
// filled: true,
// hintText: 'Username',
// hintStyle: TextStyle(color: Colors.grey.shade700),
// border: OutlineInputBorder(
// borderSide: BorderSide(
// width: 0,
// style: BorderStyle.none,
// ),
// borderRadius: BorderRadius.all(
// Radius.circular(10.0),
// ),
// ),
// ),
// keyboardType: TextInputType.emailAddress,
// ),
// SizedBox(
// height: 20,
// ),
// TextField(
// decoration: InputDecoration(
// contentPadding:
// EdgeInsets.symmetric(vertical: 0, horizontal: 15),
// fillColor: Colors.grey.shade900,
// focusColor: Theme.of(context).backgroundColor,
// filled: true,
// hintText: 'Password',
// hintStyle: TextStyle(color: Colors.grey.shade700),
// border: OutlineInputBorder(
// borderSide: BorderSide(
// width: 0,
// style: BorderStyle.none,
// ),
// borderRadius: BorderRadius.all(
// Radius.circular(10.0),
// ),
// ),
// ),
// keyboardType: TextInputType.emailAddress,
// ),
// SizedBox(
// height: 40,
// ),
// Card(
// color: Theme.of(context).accentColor,
// child: Container(
// padding:
// EdgeInsets.symmetric(vertical: 10, horizontal: 0),
// width: 230,
// child: Text(
// 'Login',
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.white,
// ),
// ),
// ),
// ),
// SizedBox(
// height: 15,
// ),
// Text(
// 'forgot password?',
// style: TextStyle(
// color: Colors.grey.shade600,
// ),
// ),
// SizedBox(
// height: 40,
// ),
// SizedBox(
// height: 20,
// width: 200,
// child: Divider(
// color: Colors.white,
// ),
// ),
// SizedBox(
// height: 20,
// ),
// Card(
// color: Theme.of(context).accentColor,
// child: TextButton(
// onPressed: () {
// Navigator.push(context,
// MaterialPageRoute(builder: (context) => Home()));
// },
// child: Container(
// padding:
// EdgeInsets.symmetric(vertical: 5, horizontal: 0),
// width: 230,
// child: Text(
// 'Sign Up',
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.white,
// ),
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// SizedBox(height: 10),
// Text(
// 'Or',
// style: TextStyle(
// color: Colors.grey.shade600,
// ),
// ),
// SizedBox(height: 10),
