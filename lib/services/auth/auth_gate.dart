import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/pages/adminhomepage.dart';
import 'package:fyp/pages/userhomepage.dart';
import 'package:fyp/pages/ownerhomepage.dart';
import 'package:fyp/pages/homescreen.dart';
import 'package:fyp/services/auth/update_user.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
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
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if there is user logged in then
            if (type == 'user') {
              return const UserHomePage();
            } else if (type == 'admin') {
              return const AdminHomePage();
            } else if (type == 'owner') {
              return const OwnerHomePage();
            }
            return const HomeScreen(); //to counter returning null
          } else {
            // no user logged in -> homescreen
            return const HomeScreen();
          }
        },
      ),
    );
  }
}
