import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1a271),
      appBar: AppBar(
        backgroundColor: const Color(0xffB67F5F),
        title: const Center(
          child: Text(
            textAlign: TextAlign.center,
            "Settings",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: const MyDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width, //max width for current phone
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
        child: const Column(
          children: [],
        ),
      ),
    );
  }
}
