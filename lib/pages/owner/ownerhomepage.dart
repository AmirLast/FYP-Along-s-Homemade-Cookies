import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/components/my_menubutton.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/settingspage.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/pages/owner/ownerorderpage.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({super.key});

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> with SingleTickerProviderStateMixin {
  //owner data from ownerclass.dart
  String fname = UserNow.usernow!.fname;
  //for logo
  final Logo show = Logo();
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
            "Hello " + fname,
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
            IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuPage())),
              icon: const Icon(Icons.add_shopping_cart, color: Colors.black),
            ),
          ],
          backgroundColor: const Color(0xffd1a271),
        ),
        drawer: const MyDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height, //max width for current phone
          decoration: show.showLogo(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyMenuButton(
                icon: CupertinoIcons.news,
                text: "Customer Order",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OwnerOrderPage()),
                ),
              ),
              /*
              List function2 owner yang belum terciptakan
              MyMenuButton(
                  text: "Business Summary",
                  onPressed: () {} //=> Navigator.push(context,
                  //MaterialPageRoute(builder: (context) => const SummaryPage())),
                  ),
              const SizedBox(
                height: 60,
              ),
              const SizedBox(
                height: 60,
              */
            ],
          ),
        ),
      ),
    );
  }
}

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
