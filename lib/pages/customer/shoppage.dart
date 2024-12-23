import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/customer/my_shopproducttile.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/shopclass.dart';
import 'package:fyp/models/shoppingclass.dart';
import 'package:fyp/pages/customer/cartpage.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  final String id;
  const ShopPage({
    super.key,
    required this.id,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late Shops? shop;
  late String name; //shop name
  late List<Bakeds?> bakeds; //the shop bakeds with categories
  late List categories; //owner shop list of category
  final Logo show = Logo(); //for logo

  @override
  void initState() {
    super.initState();
    shop = Shops.currentShop.shops.firstWhere((x) => x.id == widget.id);
    name = shop!.name;
    bakeds = shop!.bakeds;
    categories = shop!.categories;
  }

  //confirm pop up kalau ada unsaved data---------------------------------------
  confirmPopUp(Shopping shop, context) {
    //confirm pop up
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: const Text(
          "You have items in cart for this shop. Exiting will result in clearing cart. Proceed to exit?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                iconSize: 50,
                color: Colors.green,
                onPressed: () {
                  shop.clearCart();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                  iconSize: 50,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel)),
            ],
          )
        ],
      ),
    );
  } //----------------------------------------------------------------------

  void toPop(Shopping shop) {
    if (shop.cart.isEmpty) {
      Navigator.pop(context);
    } else {
      confirmPopUp(shop, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shopping>(
      builder: (context, shopping, child) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }
          toPop(shopping);
        },
        child: Scaffold(
          backgroundColor: const Color(0xffd1a271),
          appBar: AppBar(
            backgroundColor: const Color(0xffB67F5F),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                toPop(shopping);
              },
            ),
            title: Center(
              child: Text(
                textAlign: TextAlign.center,
                name + " Shop",
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const CartPage(), settings: const RouteSettings(name: "cart")));
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width, //max width for current phone
              height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
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
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: categories.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white.withValues(alpha: 0.75),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                                        child: Center(
                                          child: Text(
                                            categories[index],
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MyProdTile(bakeds: bakeds, category: categories[index]),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
