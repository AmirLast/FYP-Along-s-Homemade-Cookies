import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType inputType;
  final TextCapitalization caps;
  final bool isEnabled;
  final String hintText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    required this.inputType,
    required this.caps,
    required this.isEnabled,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        enabled: isEnabled, //get this value
        controller: controller,
        keyboardType: inputType,
        obscureText: obscureText,
        textCapitalization: caps,
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
        ),
      ),
    );
  }
}
