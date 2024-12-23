import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/customer/my_currentlocation.dart';
import 'package:fyp/components/general/my_drawer.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_menubutton.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/endscreen.dart';
import 'package:fyp/pages/all_user/functions/showloading.dart';
import 'package:fyp/pages/all_user/functions/updateorder.dart';
import 'package:fyp/pages/all_user/profile.dart';
import 'package:fyp/pages/customer/shoplistpage.dart';
import 'package:fyp/pages/customer/sizepage.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> with SingleTickerProviderStateMixin {
  String? name = UserNow.usernow.user?.displayName ?? "";
  final gotoNext = Showloading();
  final Logo show = Logo(); //for logo
  final gotoOrder = UpdateOrderData();

  confirmPopUp(context) {
    //confirm pop up
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: const Text(
          "Are you sure you want to exit?",
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(builder: (BuildContext context) => const EndScreen()),
                    ModalRoute.withName('/'),
                  );
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
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        confirmPopUp(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffd1a271),
          title: Text(
            "Hello " + name.toString(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage())),
              icon: const Icon(Icons.account_circle, color: Colors.black),
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
          decoration: show.showLogo(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyCurrentLocation(),
              const SizedBox(height: 60),
              MyMenuButton(
                text: "Browse Shop",
                icon: Icons.shopify_rounded,
                size: 0,
                onPressed: () {
                  gotoNext.showloading(
                    "",
                    (BuildContext context) => const ShopListPage(),
                    const RouteSettings(name: "shoplist"),
                    "/",
                    context,
                  );
                },
              ),
              const SizedBox(height: 60),
              MyMenuButton(
                text: "Order History",
                icon: CupertinoIcons.tray_full,
                size: 0,
                onPressed: () {
                  gotoOrder.updateorderdata(UserNow.usernow.user!.uid, "buyer", context);
                },
              ),
              const SizedBox(height: 60),
              MyMenuButton(
                text: "Word Sizes",
                icon: CupertinoIcons.search,
                size: 0,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SizePage())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
