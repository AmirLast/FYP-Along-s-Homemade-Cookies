import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_logo.dart';

class OwnerOrderPage extends StatefulWidget {
  const OwnerOrderPage({super.key});

  @override
  State<OwnerOrderPage> createState() => _OwnerOrderPageState();
}

class _OwnerOrderPageState extends State<OwnerOrderPage> {
  //for logo
  final Logo show = Logo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1a271),
      appBar: AppBar(
        backgroundColor: const Color(0xffB67F5F),
        title: const Center(
          child: Text(
            textAlign: TextAlign.center,
            "Order",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: const MyDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width, //max width for current phone
        decoration: show.showLogo(),
        child: const Column(
          children: [],
        ),
      ),
    );
  }
}
