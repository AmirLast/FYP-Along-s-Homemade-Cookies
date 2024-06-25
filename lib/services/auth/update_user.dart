import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/foundation.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/services/auth/auth_service.dart';

class UpdateUserData {
  Future<String> updateuserdata() async {
    AuthService something = AuthService();
    User? user = something.getCurrentUser();
    var dir = FirebaseFirestore.instance.collection('users');
    await dir.doc(user!.uid).get().then((value) {
      UserNow.usernow = UserNow(
        value.data()?['fname'],
        value.data()?['lname'],
        value.data()?['phone'],
        user,
        value.data()?['type'],
        value.data()?['currentdir'],
        value.data()?['passStrength'],
      );
      //check user type
      if (value.data()?['type'] == "owner") {
        //for owner, they have extra data
        UserNow.usernow?.categories = value.data()?['categories'];
        UserNow.usernow?.shop = value.data()?['shop'];
      }
    });
    return UserNow.usernow!.type;
  }
}
