import 'package:firebase_auth/firebase_auth.dart';

class UserNow {
  //list down all data in user database
  String name = "";
  String phone = "";
  String type = ""; //to know if they are user or admin
  User user;
  UserNow(this.name, this.phone, this.user, this.type);
  static UserNow? usernow; //the object to call all the above data
}
