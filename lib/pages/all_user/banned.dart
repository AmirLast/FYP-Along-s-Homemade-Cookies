import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/pages/all_user/homescreen.dart';
import 'package:fyp/services/auth_service.dart';

class Banned extends StatelessWidget {
  const Banned({super.key});

  @override
  Widget build(BuildContext context) {
    final show = Logo(); //for logo
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        body: Container(
          decoration: show.showLogo(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const Text(
                      "You are banned",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    MaterialButton(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Text(
                            "Return",
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final authService = AuthService();
                        await authService.signOut().then((onValue) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                              settings: const RouteSettings(name: "/"),
                            ),
                            ModalRoute.withName(""),
                          );
                        });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
