import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/services/auth/auth_service.dart';

class UpdateUserData {
  Future<String> updateuserdata() async {
    AuthService something = AuthService();
    User? user = something.getCurrentUser();
    var dir = FirebaseFirestore.instance.collection('users');
    await dir.doc(user!.uid).get().then((value) {
      //containing user data into a class so we don't need database delay
      UserNow.usernow = UserNow(
        value.data()?['name'],
        value.data()?['phone'],
        user,
        value.data()?['type'],
      );
    });
    return UserNow.usernow!.type;
  }
}
