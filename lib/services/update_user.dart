import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/models/memberclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/services/auth_service.dart';

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
      await dir.doc(user.uid).get().then((value) async {
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
          UserNow.usernow.visibility = value.data()?['visibility'];
        }
        if (value.data()?['type'] == "buyer") {
          UserNow.usernow.address = value.data()?['address'];
          UserNow.usernow.isMember = value.data()?['ismember'];
          if (UserNow.usernow.isMember) {
            await FirebaseFirestore.instance.collection('members').where('id', isEqualTo: UserNow.usernow.user?.uid).get().then((qSs) {
              for (var dSs in qSs.docs) {
                Member.member = Member(
                  memPoint: dSs.get('memPoint'),
                  firstPurch: dSs.get('firstPurch'),
                  rm30Purch: dSs.get('rm30Purch'),
                  rm10x5Purch: dSs.get('rm10x5Purch'),
                );
              }
            });
          }
        }
      });
      return UserNow.usernow.type;
    } catch (e) {
      return "";
    }
  }
}
