import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/services/auth/auth_service.dart';

class UpdateUserData {
  //read FBFS and update local data
  Future<String> updateuserdata() async {
    AuthService something = AuthService();
    try {
      User? user = something.getCurrentUser();
      if (user == null) {
        return "";
      }
      var dir = FirebaseFirestore.instance.collection('users');
      await dir.doc(user.uid).get().then((value) {
        UserNow.usernow = UserNow(
          fname: value.data()?['fname'],
          lname: value.data()?['lname'],
          phone: value.data()?['phone'],
          user: user,
          type: value.data()?['type'],
          currentdir: value.data()?['currentdir'],
          passStrength: value.data()?['passStrength'],
          address: value.data()?['address'],
        );
        //check user type
        if (value.data()?['type'] == "owner") {
          //for owner, they have extra data
          UserNow.usernow?.categories = value.data()?['categories'];
          UserNow.usernow?.shop = value.data()?['shop'];
        }
      });
      return UserNow.usernow!.type;
    } catch (e) {
      return "";
    }
  }
}
