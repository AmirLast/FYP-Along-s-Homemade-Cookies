import 'package:flutter/material.dart';
import 'package:fyp/themes/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData get themeData => lightMode;
}
