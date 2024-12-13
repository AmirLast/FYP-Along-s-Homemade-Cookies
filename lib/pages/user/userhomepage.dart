import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/components/my_menubutton.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/settingspage.dart';
import 'package:fyp/pages/user/shoplistpage.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> with SingleTickerProviderStateMixin {
  String name = UserNow.usernow!.fname;
  //for logo
  final Logo show = Logo();

  confirmPopUp(context) {
    //confirm pop up
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: const Text(
          "Are you sure you want to exit?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                iconSize: 50,
                color: Colors.green,
                onPressed: () {
                  exit(0);
                },
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                  iconSize: 50,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel)),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        confirmPopUp(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hello " + name,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage())),
              icon: const Icon(Icons.account_circle, color: Colors.black),
            ),
          ],
          backgroundColor: const Color(0xffd1a271),
        ),
        drawer: const MyDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: show.showLogo(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyMenuButton(
                  text: "Browse Shop",
                  icon: Icons.shopify_rounded,
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopListPage()))),
            ],
          ),
        ),
      ),
    );
  }
}
