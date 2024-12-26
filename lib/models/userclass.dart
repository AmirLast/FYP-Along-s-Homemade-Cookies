import 'package:firebase_auth/firebase_auth.dart';

class UserNow {
  //list down all data in user database
  String fullname = "";
  String phone = "";
  String type = ""; //to know if they are user or admin
  User? user;
  String currentdir = "";
  bool passStrength = false;
  bool isMember = false;
  List address = [];
  //below is for owner
  List categories = [];
  String shop = "";
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
}
