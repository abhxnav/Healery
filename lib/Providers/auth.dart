import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healery/main.dart';

class Auth extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isSignedIn;
  User user;
  bool isNewUser = false;
  Map<String, dynamic> userData;
  AuthCredential credential;

  Future<void> fetchUserInfo() async {
    try {
      this.user.reload();
    } catch (e) {}
    if (_auth.currentUser != null) {
      isSignedIn = true;
    } else {
      isSignedIn = false;
    }

    if (isSignedIn) {
      user = _auth.currentUser;

      userData = await DB
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) => value.data());
    }
  }

  Future<User> googleSignIn() async {
    // hold the instance of the authenticated user
    // flag to check whether we're signed in already
    isSignedIn = await _googleSignIn.isSignedIn();

    if (isSignedIn) {
      // if so, return the current user
      user = _auth.currentUser;

      if (user == null) {
        signOut();
      }
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      UserCredential authResult = await _auth.signInWithCredential(credential);
      isNewUser = authResult.additionalUserInfo.isNewUser;
      user = authResult.user;
    }

    if (isNewUser) {
      await DB.collection('users').doc(user.uid).set({
        'userID': user.uid,
        'name': user.displayName,
        'profilePic': user.photoURL,
      });
    }

    await fetchUserInfo();
    notifyListeners();
    return user;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();

    fetchUserInfo();
    notifyListeners();
  }
}

Auth auth = Auth();
