import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
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
