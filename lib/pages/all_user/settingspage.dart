import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_menubutton.dart';

class SettingsPage extends StatelessWidget {
  final Logo show = Logo(); //for logo
  SettingsPage({super.key});

  //can change notification setting
  //change email and password
  //can subscribe to premium

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1a271),
      appBar: AppBar(
        backgroundColor: const Color(0xffB67F5F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context); //change this after popscope is added
          },
        ),
        title: const Center(
          child: Text(
            textAlign: TextAlign.center,
            "Settings",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, //max width for current phone
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
        decoration: show.showLogo(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyMenuButton(
              text: "Change Notification Settings",
              onPressed: () {},
              icon: Icons.notifications_active_rounded,
              size: 350,
            ),
            const SizedBox(height: 50),
            MyMenuButton(
              text: "Subscribe to Premium",
              onPressed: () {},
              icon: Icons.library_add_check_rounded,
              size: 350,
            ),
            const SizedBox(height: 50),
            MyMenuButton(
              text: "Change Email or Password",
              onPressed: () {},
              icon: Icons.lock_person_rounded,
              size: 350,
            ),
          ],
        ),
      ),
    );
  }
}
