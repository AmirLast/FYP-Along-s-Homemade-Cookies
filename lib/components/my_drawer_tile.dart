import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;

  const MyDrawerTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        tileColor: Theme.of(context).colorScheme.tertiary,
        onTap: onTap,
      ),
    );
  }
}
