import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: const Color(0xffd1a271), //bg apps
    primary: Colors.black, //bg button
    secondary: Colors.grey.shade500, //writings in black
    tertiary: Colors.white, //bg form
    inversePrimary: const Color(0xffc1ff72), // light green bg
  ),
);
