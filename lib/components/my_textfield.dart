import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType inputType;
  final TextCapitalization caps;
  final bool isEnabled;
  final String hintText;
  final bool isShowhint;

  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    required this.inputType,
    required this.caps,
    required this.isEnabled,
    required this.hintText,
    required this.isShowhint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        cursorColor: Colors.black,
        autofocus: isShowhint,
        enabled: isEnabled, //get this value
        controller: controller,
        keyboardType: inputType,
        obscureText: obscureText,
        textCapitalization: caps,
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey.shade400)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          filled: true,
          fillColor: Colors.grey.shade400,
          labelText: labelText,
          floatingLabelStyle: const TextStyle(color: Colors.black),
          floatingLabelBehavior: isShowhint ? FloatingLabelBehavior.never : null,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
        ),
      ),
    );
  }
}
