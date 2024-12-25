import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/customer/my_currentlocation.dart';
import 'package:fyp/components/general/my_drawer.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/my_descbox.dart';
import 'package:fyp/models/shoppingclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/endscreen.dart';
import 'package:fyp/pages/all_user/functions/showloading.dart';
import 'package:fyp/pages/all_user/functions/updateorder.dart';
import 'package:fyp/pages/all_user/profile.dart';
import 'package:fyp/pages/customer/membership.dart';
import 'package:fyp/pages/customer/shoplistpage.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> with SingleTickerProviderStateMixin {
  late String? name;
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

  void refreshAddress() {
    List<String> address = [
      UserNow.usernow.address[0],
      UserNow.usernow.address[1],
      UserNow.usernow.address[2],
      UserNow.usernow.address[3],
      UserNow.usernow.address[4]
    ];
    context.read<Shopping>().updateDeliveryAddress(address);
  }

  @override
  void initState() {
    super.initState();
    refreshAddress();
    name = UserNow.usernow.user?.displayName ?? "";
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
              onPressed: () {
                gotoNext.showloading(
                  "",
                  (BuildContext context) => const ShopListPage(),
                  const RouteSettings(name: "shoplist"),
                  "/",
                  context,
                );
              },
              icon: const Icon(Icons.shopping_cart, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                gotoOrder.updateorderdata(UserNow.usernow.user!.uid, "buyer", context);
              },
              icon: const Icon(CupertinoIcons.tray_full, color: Colors.black),
            ),
            IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(type: UserNow.usernow.type))),
              icon: const Icon(Icons.account_circle, color: Colors.black),
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
          decoration: show.showLogo(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("This"),
                        Text("Is"),
                        Text("Advertisement"),
                        Text("Placeholder"),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: MyCurrentLocation(),
                ),
                const MyDescBox(),
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MembershipPage())),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 4),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Try Membership! Be a Premium User",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
