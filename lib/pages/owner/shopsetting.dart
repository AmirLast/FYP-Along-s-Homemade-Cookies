import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/owner/menupage.dart';

class ShopSetting extends StatefulWidget {
  const ShopSetting({super.key});

  @override
  State<ShopSetting> createState() => _ShopSettingState();
}

class _ShopSettingState extends State<ShopSetting> {
  final show = Logo(); //for logo
  final load = Loading();
  bool visibility = UserNow.usernow.visibility;

  void toPop() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MenuPage(), settings: const RouteSettings(name: "menus")),
      ModalRoute.withName('/'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        toPop();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffd1a271),
        appBar: AppBar(
          backgroundColor: const Color(0xffB67F5F),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              toPop();
            },
          ),
          title: const Center(
            child: Text(
              textAlign: TextAlign.center,
              "Shop Settings",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.more_vert,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
          decoration: show.showLogo(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Visibility(
                    visible: !UserNow.usernow.visibility,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 5, 20),
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Publish Shop",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(), //const SizedBox(width: 15),

                  Text(
                    !visibility ? "NO" : "YES",
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(width: 5),
                  Switch(
                    activeTrackColor: Colors.brown,
                    activeColor: Colors.black,
                    inactiveThumbColor: Colors.brown,
                    value: visibility,
                    onChanged: (value) async {
                      load.loading(context);
                      await FirebaseFirestore.instance.collection('users').doc(UserNow.usernow.user?.uid).update({
                        "visibility": value,
                      }).then((x) {
                        Navigator.pop(context);
                        setState(() {
                          visibility = value;
                          UserNow.usernow.visibility = value;
                        });
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
