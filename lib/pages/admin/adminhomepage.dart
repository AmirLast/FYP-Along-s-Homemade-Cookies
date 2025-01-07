import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_drawer.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_menubutton.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/endscreen.dart';
import 'package:fyp/pages/all_user/profile.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> with SingleTickerProviderStateMixin {
  final Logo show = Logo(); //for logo
  late String? name;

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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(builder: (BuildContext context) => const EndScreen()),
                    ModalRoute.withName('/'),
                  );
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
  void initState() {
    super.initState();
    name = UserNow.usernow.user?.displayName ?? "";
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
          backgroundColor: const Color(0xffd1a271),
          title: Text(
            "Hello " + name.toString(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(type: UserNow.usernow.type))),
              icon: const Icon(Icons.account_circle, color: Colors.black),
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
          decoration: show.showLogo(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyMenuButton(
                text: "User List",
                icon: Icons.person,
                onPressed: () {},
                size: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
