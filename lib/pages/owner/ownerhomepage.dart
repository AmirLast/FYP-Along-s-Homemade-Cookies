import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_drawer.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_menubutton.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/endscreen.dart';
import 'package:fyp/pages/all_user/functions/updateorder.dart';
import 'package:fyp/pages/all_user/profile.dart';
import 'package:fyp/pages/owner/menupage.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({super.key});

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> with SingleTickerProviderStateMixin {
  late String? name;
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
  void initState() {
    super.initState();
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
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(type: UserNow.usernow.type))),
              icon: const Icon(Icons.account_circle, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuPage()));
              },
              icon: const Icon(Icons.add_shopping_cart, color: Colors.black),
            ),
          ],
          backgroundColor: const Color(0xffd1a271),
        ),
        drawer: const MyDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height, //max width for current phone
          decoration: show.showLogo(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyMenuButton(
                icon: CupertinoIcons.news,
                text: "Customer Order",
                size: 0,
                onPressed: () {
                  gotoOrder.updateorderdata(UserNow.usernow.user!.uid, "owner", context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
