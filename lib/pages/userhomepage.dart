import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Center(
          child: Text(
            textAlign: TextAlign.justify,
            "Hello Customer",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
