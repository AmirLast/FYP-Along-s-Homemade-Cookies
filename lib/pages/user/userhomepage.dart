import 'package:flutter/material.dart';
import 'package:fyp/components/my_button.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/models/userclass.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage>
    with SingleTickerProviderStateMixin {
  String name = UserNow.usernow!.fname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd1a271),
      ),
      drawer: const MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xffd1a271),
          image: DecorationImage(
            image: const AssetImage("lib/images/applogo.png"),
            colorFilter: ColorFilter.mode(
              const Color(0xffd1a271).withOpacity(0.2),
              BlendMode.dstATop,
            ),
            alignment: Alignment.center,
            scale: 0.5,
          ),
        ),
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
