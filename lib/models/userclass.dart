import 'package:firebase_auth/firebase_auth.dart';

class UserNow {
  //list down all data in user database
  String fname = "";
  String lname = "";
  String phone = "";
  String type = ""; //to know if they are user or admin
  User user;
  String currentdir = "";
  bool passStrength = false;
  String address = "";
  //below is for owner
  List categories = [];
  String shop = "";
  UserNow({
    required this.fname,
    required this.lname,
    required this.phone,
    required this.user,
    required this.type,
    required this.currentdir,
    required this.passStrength,
    required this.address,
  });
  static UserNow? usernow; //the object to call all the above data
}
