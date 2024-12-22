import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/customer/my_shopcard.dart';
import 'package:fyp/models/shoppingclass.dart';
import 'package:fyp/models/shopclass.dart';
import 'package:fyp/pages/customer/shoppage.dart';
import 'package:fyp/pages/customer/functions/updateshoplist.dart';
import 'package:provider/provider.dart';

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
      setState(() {
        shops = temp;
        isLoading = false;
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
        : Consumer<Shop>(
            builder: (context, shop, child) => Scaffold(
              backgroundColor: const Color(0xffd1a271),
              appBar: AppBar(
                backgroundColor: const Color(0xffB67F5F),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
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
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width, //max width for current phone
                  height:
                      MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
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
                                        builder: (context) => ShopPage(
                                              id: shops[index]!.id,
                                              name: shops[index]!.name,
                                              bakeds: shops[index]!.bakeds,
                                              categories: shops[index]!.categories,
                                            ),
                                        settings: const RouteSettings(name: "shop")));
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
