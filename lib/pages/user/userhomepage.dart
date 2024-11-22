import 'package:flutter/material.dart';
import 'package:fyp/components/my_button.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/models/userclass.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> with SingleTickerProviderStateMixin {
  String name = UserNow.usernow!.fname;
  //for logo
  late Logo show;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd1a271),
      ),
      drawer: const MyDrawer(),
      body: Container(
        decoration: show.showLogo(),
        child: Column(
          children: [
            MyButton(
              text: "Hello " + name,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
