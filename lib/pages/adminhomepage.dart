import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Center(
          child: Text(
            textAlign: TextAlign.justify,
            "Hello Staff/Admin",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
