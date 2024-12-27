import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/customer/my_shopcard.dart';
import 'package:fyp/models/shopclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/functions/showloading.dart';
import 'package:fyp/pages/customer/shoppage.dart';

class ShopListPage extends StatefulWidget {
  const ShopListPage({super.key});

  @override
  State<ShopListPage> createState() => _ShopListPageState();
}

class _ShopListPageState extends State<ShopListPage> {
  final Logo show = Logo(); //for logo
  final gotoNext = Showloading();
  final List<Shops?> shops = Shops.currentShop.shops;

  @override
  void initState() {
    super.initState();
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
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
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
                        UserNow.usernow.currentdir = shops[index]!.id;
                        gotoNext.showloading(
                          shops[index]!.id,
                          (context) => ShopPage(id: shops[index]!.id),
                          const RouteSettings(name: "shoppage"),
                          "shoplist",
                          context,
                        );
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
