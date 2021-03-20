import 'package:flutter/material.dart';
import 'package:healery/Screens/home.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Healery',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 50),
            Container(
              width: 300,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      fillColor: Theme.of(context).backgroundColor,
                      focusColor: Theme.of(context).backgroundColor,
                      filled: true,
                      hintText: 'Email',
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      fillColor: Theme.of(context).backgroundColor,
                      focusColor: Theme.of(context).backgroundColor,
                      filled: true,
                      hintText: 'Password',
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 50),
                  Container(
                    color: Theme.of(context).backgroundColor,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        width: 230,
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 20),
            Text('Or'),
            SizedBox(height: 30),
            Container(
              color: Theme.of(context).backgroundColor,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  width: 230,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google_logo.png',
                        width: 37,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
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
