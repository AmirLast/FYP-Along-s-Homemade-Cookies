import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';

class SettingsPage extends StatelessWidget {
  //for logo
  final Logo show = Logo();
  SettingsPage({super.key});

  //add:
  //can subscribe to premium
  //change basic data
  //change delivery data
  //what else?

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
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, //max width for current phone
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
        decoration: show.showLogo(),
        child: const Column(
          children: [],
        ),
      ),
    );
  }
}
