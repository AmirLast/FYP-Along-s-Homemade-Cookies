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

  stillLoad() {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator(color: Colors.grey)),
    );
  }

  Future<void> whoisuser() async {
    //update user data in local memory
    final obj = UpdateUserData();
    await obj.updateuserdata().then((temp) {
      type = temp;
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    whoisuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? stillLoad()
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
                    return const OwnerHomePage();
                  }
                  return const HomeScreen(); //to counter returning null
                } else {
                  // no user logged in -> homescreen
                  if (type != "") {
                    //kadang masih pegi sini walaupun ada snapshot data = logged in user
                    return stillLoad();
                  } else {
                    return const HomeScreen();
                  }
                }
              },
            ),
          );
  }
}
