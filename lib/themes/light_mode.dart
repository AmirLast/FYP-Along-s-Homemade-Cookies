import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: const Color(0xffd1a271), //bg apps
    primaryContainer: const Color(0xffB67F5F), //appbar menus
    primary: Colors.black, //bg button
    secondary: Colors.grey.shade400, //writings in black
    tertiary: Colors.white, //bg form
    inversePrimary: const Color(0xffc1ff72), // hello user text bg
    inverseSurface: const Color(0xff7ED957), // user menu bg
  ),
);
