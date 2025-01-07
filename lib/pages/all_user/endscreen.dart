import 'dart:io';
import 'package:flutter/material.dart';

class EndScreen extends StatefulWidget {
  const EndScreen({super.key});

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  bool isWait = true;

  void stillWait() async {
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        isWait = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    stillWait();
  }

  @override
  Widget build(BuildContext context) {
    return !isWait
        ? exit(0)
        : Scaffold(
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
}
