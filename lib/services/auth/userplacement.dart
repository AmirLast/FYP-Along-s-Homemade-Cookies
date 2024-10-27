import 'package:flutter/material.dart';
import 'package:fyp/pages/adminhomepage.dart';
import 'package:fyp/pages/ownerhomepage.dart';
import 'package:fyp/pages/userhomepage.dart';
import 'package:fyp/services/auth/update_user.dart';

class UserReplacement extends StatefulWidget {
  const UserReplacement({super.key});

  @override
  State<UserReplacement> createState() => _UserReplacementState();
}

class _UserReplacementState extends State<UserReplacement> {
  String type = "";

  Future<void> whoisuser() async {
    //update user data in local memory
    final obj = UpdateUserData();
    type = await obj.updateuserdata();
    setState(() {});
  }

  @override
  void initState() {
    whoisuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//how to make different user go to different page?
    if (type == 'user') {
      return const UserHomePage();
    } else if (type == 'admin') {
      return const AdminHomePage();
    } else {
      // type == owner
      return const OwnerHomePage();
    }
  }
}
