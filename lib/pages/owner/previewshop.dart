import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/owner/my_previewproducttile.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/shopclass.dart';
import 'package:fyp/pages/all_user/functions/updateorder.dart';

class PreviewShop extends StatefulWidget {
  final String id;
  const PreviewShop({super.key, required this.id});

  @override
  State<PreviewShop> createState() => _PreviewShopState();
}

class _PreviewShopState extends State<PreviewShop> {
  late Shops? shop;
  late String name; //shop name
  late List<Bakeds?> bakeds; //the shop bakeds with categories
  late List categories; //owner shop list of category
  final Logo show = Logo(); //for logo
  final gotoOrder = UpdateOrderData();

  @override
  void initState() {
    super.initState();
    shop = Shops.currentShop.shops.firstWhere((x) => x.id == widget.id);
    name = shop!.name;
    bakeds = shop!.bakeds;
    categories = shop!.categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1a271),
      appBar: AppBar(
        backgroundColor: const Color(0xffB67F5F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
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
            onPressed: () {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: const Row(
                      children: [Text("Sort by"), Spacer(), Icon(Icons.arrow_drop_down_sharp)],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 80,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: const Center(child: Text("Reviews")),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 10, bottom: 5),
                            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MyPreviewProdTile(bakeds: bakeds, category: categories[index]),
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
    );
  }
}
