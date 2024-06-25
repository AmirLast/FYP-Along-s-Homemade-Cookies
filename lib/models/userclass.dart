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
  //below is for owner
  List categories = [];
  String shop = "";
  UserNow(this.fname, this.lname, this.phone, this.user, this.type,
      this.currentdir, this.passStrength);
  static UserNow? usernow; //the object to call all the above data
}
