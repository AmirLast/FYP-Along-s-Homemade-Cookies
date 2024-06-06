import 'package:flutter/material.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/adminhomepage.dart';
import 'package:fyp/pages/userhomepage.dart';
import 'package:fyp/pages/ownerhomepage.dart';

class UserReplacement extends StatelessWidget {
  const UserReplacement({super.key});

  @override
  Widget build(BuildContext context) {
    String type = UserNow.usernow!.type;
//how to make different user go to different page?
    type = UserNow.usernow!.type;
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
