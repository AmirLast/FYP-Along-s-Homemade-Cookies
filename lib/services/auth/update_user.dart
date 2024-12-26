import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/models/memberclass.dart';
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
          fullname: value.data()?['fullname'],
          phone: value.data()?['phone'],
          user: user,
          type: value.data()?['type'],
          currentdir: value.data()?['currentdir'],
          passStrength: value.data()?['passStrength'],
        );
        //check user type
        if (value.data()?['type'] == "seller") {
          //for owner, they have extra data
          UserNow.usernow.address = value.data()?['address'];
          UserNow.usernow.categories = value.data()?['categories'];
          UserNow.usernow.shop = value.data()?['shop'];
        }
        if (value.data()?['type'] == "buyer") {
          UserNow.usernow.address = value.data()?['address'];
          UserNow.usernow.isMember = value.data()?['ismember'];
          Member.member = Member(memPoint: value.data()?['mempoint'], firstPurchase: value.data()?['firstpurchase']);
        }
      });
      return UserNow.usernow.type;
    } catch (e) {
      return "";
    }
  }
}
