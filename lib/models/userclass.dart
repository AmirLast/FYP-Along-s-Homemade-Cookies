import 'package:firebase_auth/firebase_auth.dart';

class UserNow {
  //list down all data in user database
  String fullname;
  String phone;
  String type; //to know user type
  User? user;
  String currentdir;
  bool passStrength;
  bool isMember = false; //only buyer can be member
  List address = []; //only admin has no address
  //below is for owner
  List categories = [];
  String shop = "";
  bool visibility = false;
  UserNow({
    required this.fullname,
    required this.phone,
    required this.user,
    required this.type,
    required this.currentdir,
    required this.passStrength,
  });
  static UserNow usernow = UserNow(
    fullname: "",
    phone: "",
    user: FirebaseAuth.instance.currentUser,
    type: "",
    currentdir: "",
    passStrength: true,
  ); //the object to call all the above data
  void empty() {
    UserNow.usernow = UserNow(
      fullname: "",
      phone: "",
      user: FirebaseAuth.instance.currentUser,
      type: "",
      currentdir: "",
      passStrength: true,
    );
    UserNow.usernow.isMember = false;
    UserNow.usernow.address.clear();
    UserNow.usernow.categories.clear();
    UserNow.usernow.shop = "";
    UserNow.usernow.visibility = false;
  }
}
