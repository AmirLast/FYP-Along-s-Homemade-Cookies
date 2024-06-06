import 'package:flutter/material.dart';

class MyMenuButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const MyMenuButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          maximumSize: const Size(250, 60),
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          shape: const BeveledRectangleBorder(
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(30)))),
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
