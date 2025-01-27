import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_drawer_tile.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/memberclass.dart';
import 'package:fyp/models/orderclass.dart';
import 'package:fyp/models/shopclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/models/userlistclass.dart';
import 'package:fyp/pages/all_user/homescreen.dart';
import 'package:fyp/pages/all_user/profile.dart';
import 'package:fyp/services/auth_service.dart';
import '../../pages/all_user/settingspage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  Future logout(context) async {
    // loading circle-----
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.black),
              SizedBox(width: 10),
              Text(
                "Logging Out",
                style: TextStyle(color: Colors.grey, fontSize: 25),
              )
            ],
          ),
        );
      },
    );
    // loading circle-----
    await Future.delayed(const Duration(seconds: 2), () async {
      //empty all classes
      Bakeds.currentBaked.empty();
      Member.member.empty();
      Orders.currentOrder.empty();
      Shops.currentShop.empty();
      UserNow.usernow.empty();
      UserList.user.empty();

      final authService = AuthService();
      await authService.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade400,
      child: Column(
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.shade400,
                BlendMode.color,
              ),
              child: Image.asset(
                "lib/images/applogo.png",
                height: 80,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            child: Divider(
              color: Colors.white,
            ),
          ),

          //home list tile
          Visibility(
            visible: UserNow.usernow.type != "admin",
            child: MyDrawerTile(
              text: "P R O F I L E",
              icon: Icons.person,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(type: UserNow.usernow.type),
                  ),
                );
              }, //go to profile setting
            ),
          ),

          const SizedBox(height: 10),

          //setting list tile
          MyDrawerTile(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          //about list tile
          MyDrawerTile(
            text: "A B O U T",
            icon: Icons.info,
            onTap: () => Navigator.pop(context), //goto about page
          ),

          const SizedBox(height: 10),

          //help list tile
          MyDrawerTile(
            text: "H E L P",
            icon: Icons.help,
            onTap: () => Navigator.pop(context), //goto help page
          ),

          const Spacer(),

          //logout list tile
          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () async {
              await logout(context).then((onValue) {
                //Navigator.pop(context); no need cause pushandremoveuntil right?
                //pop circle after logout done
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
              });
            },
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
