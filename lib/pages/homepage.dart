import 'package:flutter/material.dart';
import 'package:fyp/components/my_currentlocation.dart';
import 'package:fyp/components/my_descbox.dart';
import 'package:fyp/components/my_foodtile.dart';
import 'package:fyp/components/my_tabbar.dart';
import 'package:fyp/models/baked.dart';
import 'package:fyp/models/shop.dart';
import 'package:fyp/pages/prodpage.dart';
import 'package:provider/provider.dart';

import '../components/my_drawer.dart';
import '../components/my_sliverappbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
//tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: BakedCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //sort out and return a list of product item that belong to a specific category
  List<Baked> _filterMenuByCategory(
      BakedCategory category, List<Baked> fullMenu) {
    return fullMenu.where((baked) => baked.category == category).toList();
  }

  //return list of foods in given category
  List<Widget> getProdInThisCategory(List<Baked> fullMenu) {
    return BakedCategory.values.map((category) {
      //get category menu
      List<Baked> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          //get individual food
          final prod = categoryMenu[index];

          //return product tile UI
          return ProdTile(
            prod: prod,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdPage(prod: prod),
              ),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home"),
      //   backgroundColor: Theme.of(context).colorScheme.background,
      // ),
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                // current location
                MyCurrentLocation(),

                //desc box
                const MyDescBox(),
              ],
            ),
          ),
        ],
        body: Consumer<Shop>(
          builder: (context, shop, child) => TabBarView(
            controller: _tabController,
            children: getProdInThisCategory(shop.menu),
          ),
        ),
      ),
    );
  }
}
