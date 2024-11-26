import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer_tile.dart';
import 'package:fyp/pages/all_user/homescreen.dart';
import 'package:fyp/services/auth/auth_service.dart';
import '../pages/all_user/settingspage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
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
            padding: EdgeInsets.all(25.0),
            child: Divider(
              color: Colors.white,
            ),
          ),

          //home list tile
          MyDrawerTile(
            text: "P R O F I L E",
            icon: Icons.person,
            onTap: () => Navigator.pop(context), //go to profile setting
          ),

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

          //about list tile
          MyDrawerTile(
            text: "A B O U T",
            icon: Icons.info,
            onTap: () => Navigator.pop(context), //goto about page
          ),

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
            onTap: () {
              logout();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
            },
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
