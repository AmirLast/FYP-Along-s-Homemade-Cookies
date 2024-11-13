import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/pages/admin/adminhomepage.dart';
import 'package:fyp/pages/owner/ownerhomepage.dart';
import 'package:fyp/pages/user/userhomepage.dart';
import 'package:fyp/pages/all_user/homescreen.dart';
import 'package:fyp/services/auth/update_user.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  String type = "";
  bool isLoading = true;

  Future<void> whoisuser() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      //pop loading circle---------
    });
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
    return !isLoading
        ? const CircularProgressIndicator()
        : Scaffold(
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
                    return const OwnerHomePage(); //const OwnerHomePage();
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
