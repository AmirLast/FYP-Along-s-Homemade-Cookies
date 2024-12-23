import 'package:flutter/material.dart';

class MyScaffoldmessage {
  void scaffoldmessage(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(10),
        backgroundColor: Colors.white,
        content: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
        showCloseIcon: true,
        closeIconColor: Colors.black,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        elevation: 10,
      ),
    );
  }
}
