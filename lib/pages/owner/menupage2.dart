//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:fyp/components/my_cattile.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/models/bakedclass.dart';
//import 'package:fyp/models/baked.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/owner/addcategory.dart';
//import 'package:fyp/pages/updatemenu.dart';
//import 'package:fyp/pages/prodpage.dart';

class MenuPage2 extends StatefulWidget {
  const MenuPage2({super.key});

  @override
  State<MenuPage2> createState() => _MenuPage2State();
}

class _MenuPage2State extends State<MenuPage2> with SingleTickerProviderStateMixin {
  List cat = UserNow.usernow!.categories;
  List<Bakeds?> menus = [];
/*
  Future<void> updateMenu() async {
    //update menu data in local memory
    final obj = UpdateMenuData();
    menus = await obj.updatemenudata();
    setState(() {});
  }
*/
  @override
/*  void initState() {
    updateMenu();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Expanded(
        child: Scaffold(
          //the add button
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddCategory())),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            title: const Center(
              child: Text(
                textAlign: TextAlign.center,
                "Manage Menu",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          drawer: const MyDrawer(), //default drawer
          body: Container(
            width:
                MediaQuery.of(context).size.width, //max width for current phone
                height: 
                MediaQuery.of(context).size.height, //max width for current phone
            //for logo transparent
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              image: DecorationImage(
                image: const AssetImage("lib/images/applogo.png"),
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.surface.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
                alignment: Alignment.center,
                scale: 0.5,
              ),
            ),
            child: const Column(
              
            ),
          ),
        ),
      ),
    );
  }
}