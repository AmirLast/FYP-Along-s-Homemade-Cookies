import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/models/bakedclass.dart';

class ShopPage extends StatefulWidget {
  final String name;
  final List<Bakeds?> bakeds;

  const ShopPage({
    super.key,
    required this.name,
    required this.bakeds,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final Logo show = Logo(); //for logo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1a271),
      appBar: AppBar(
        backgroundColor: const Color(0xffB67F5F),
        title: Center(
          child: Text(
            textAlign: TextAlign.center,
            widget.name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(), //default drawer);
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height, //max height for current phone
          decoration: show.showLogo(),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text("Sort by"), Icon(Icons.arrow_drop_down_sharp)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
