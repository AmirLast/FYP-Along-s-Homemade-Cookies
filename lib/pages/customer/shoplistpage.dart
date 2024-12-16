import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/components/my_shopcard.dart';
import 'package:fyp/models/shopclass.dart';
import 'package:fyp/pages/customer/shoppage.dart';
import 'package:fyp/pages/customer/functions/updateshoplist.dart';

class ShopListPage extends StatefulWidget {
  const ShopListPage({super.key});

  @override
  State<ShopListPage> createState() => _ShopListPageState();
}

class _ShopListPageState extends State<ShopListPage> {
  final Logo show = Logo(); //for logo
  late List<Shops?> shops;
  final UpdateShopList obj = UpdateShopList();
  bool isLoading = true;

  Future<void> updateShop() async {
    //update menu data in local memory
    await obj.updateshoplist().then((temp) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          shops = temp;
          isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    updateShop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(color: Color(0xffB67F5F)),
            ),
          )
        : Scaffold(
            backgroundColor: const Color(0xffd1a271),
            appBar: AppBar(
              backgroundColor: const Color(0xffB67F5F),
              title: const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Browse Shops",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
            drawer: const MyDrawer(), //default drawer
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width, //max width for current phone
                height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight, //max height for current phone
                decoration: show.showLogo(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: shops.length,
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        itemBuilder: (context, index) {
                          return ShopCard(
                            shop: shops[index],
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShopPage(name: shops[index]!.name, bakeds: shops[index]!.bakeds)));
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
