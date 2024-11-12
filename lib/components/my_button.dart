import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        maximumSize: Size(MediaQuery.of(context).size.width - 80, 70),
        padding: const EdgeInsets.all(10),
        backgroundColor: Colors.black,
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(50), left: Radius.circular(50))),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
