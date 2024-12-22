import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';

class AuthService {
  // get instance of FB auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // sign in
  Future<UserCredential> signInWithEmailPassword(String email, password, BuildContext context) async {
    String error = ""; //for displaying error
    try {
      //sign user in
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    }
    // catch errors
    on FirebaseAuthException catch (e) {
      // pop loading circle if fail
      Future.delayed(const Duration(seconds: 2), () {
        //to not show differences of success and failed login
        Navigator.of(context).pop();

        if (kDebugMode) {
          if (e.code == "user-not-found") {
            error = "No user found for that email";
          }
          if (e.code == "invalid-email") error = "Invalid email input";
          if (e.code == "unknown") error = "Bad connection";
          if (e.code == "wrong-password") error = "Incorrect Email or Password";
          if (email == "") error = "Email is blank";
          if (password == "") error = "Password is blank";
          if (e.code == "invalid-credential") {
            error = "Incorrect Email or Password";
          }
          if (e.code == "email-already-in-use") {
            error = "This email has it's own account";
          }
          MyScaffoldmessage obj = MyScaffoldmessage();
          obj.scaffoldmessage((error == "") ? e.message.toString() : error, context);
        }
      });

      throw Exception(e.code);
    }
  }

  // sign up
  Future<UserCredential> signUpWithEmailPassword(String email, password, BuildContext context) async {
    try {
      //sign user up
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    }
    // catch errors
    on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
        // pop loading circle if fail
        Future.delayed(const Duration(seconds: 2), () {
          //to not show differences of success and failed login
          Navigator.of(context).pop();
        });
      }
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
