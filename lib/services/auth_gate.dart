import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/pages/admin/adminhomepage.dart';
import 'package:fyp/pages/owner/ownerhomepage.dart';
import 'package:fyp/pages/customer/userhomepage.dart';
import 'package:fyp/pages/all_user/homescreen.dart';
import 'package:fyp/services/update_user.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  String type = "";
  bool isLoading = true;

  stillLoad() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffd1a271),
          image: DecorationImage(
            image: AssetImage("lib/images/applogo.png"),
            alignment: Alignment.center,
            scale: 3.5,
          ),
        ),
      ),
    );
  }

  Future<void> whoisuser() async {
    //update user data in local memory
    final obj = UpdateUserData();

    await Future.delayed(const Duration(seconds: 1), () {
      obj.updateuserdata().then((temp) {
        //try tak guna future delayed
        setState(() {
          type = temp;
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
                  if (type == 'buyer') {
                    return const UserHomePage();
                  } else if (type == 'admin') {
                    return const AdminHomePage();
                  } else if (type == 'seller') {
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
