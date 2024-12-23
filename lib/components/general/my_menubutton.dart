import 'package:flutter/material.dart';

class MyMenuButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final IconData icon;
  final double size;

  const MyMenuButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            maximumSize: size == 0 ? const Size(250, 60) : Size(size, 60),
            backgroundColor: const Color(0xff7ED957),
            shape: const BeveledRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(30)))),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 25,
            ),
            const SizedBox(width: 10),
            Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ));
  }
}
