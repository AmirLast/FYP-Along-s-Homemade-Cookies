import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_menubutton.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/admin/adminhomepage.dart';
import 'package:fyp/pages/customer/membership.dart';
import 'package:fyp/pages/customer/userhomepage.dart';
import 'package:fyp/pages/owner/ownerhomepage.dart';

class SettingsPage extends StatelessWidget {
  final Logo show = Logo(); //for logo
  SettingsPage({super.key});

  void toPop(BuildContext context) {
    if (UserNow.usernow.type == "buyer") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const UserHomePage(), settings: const RouteSettings(name: "/")),
        (Route<dynamic> route) => false,
      );
    } else if (UserNow.usernow.type == "seller") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const OwnerHomePage(), settings: const RouteSettings(name: "/")),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const AdminHomePage(), settings: const RouteSettings(name: "/")),
        (Route<dynamic> route) => false,
      );
    }
  }

  //can change notification setting
  //change email and password
  //can subscribe to premium

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        toPop(context);
      },
      child: Scaffold(
        backgroundColor: const Color(0xffd1a271),
        appBar: AppBar(
          backgroundColor: const Color(0xffB67F5F),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              toPop(context);
            },
          ),
          title: const Center(
            child: Text(
              textAlign: TextAlign.center,
              "Settings",
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
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
          decoration: show.showLogo(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyMenuButton(
                text: "Change Notification Settings",
                onPressed: () {},
                icon: Icons.notifications_active_rounded,
                size: 350,
              ),
              const SizedBox(height: 50),
              Visibility(
                visible: UserNow.usernow.type == "buyer",
                child: Column(
                  children: [
                    MyMenuButton(
                      text: "Subscribe to Premium",
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MembershipPage(pop: "pop"))),
                      icon: Icons.library_add_check_rounded,
                      size: 350,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
              MyMenuButton(
                text: "Change Email or Password",
                onPressed: () {},
                icon: Icons.lock_person_rounded,
                size: 350,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
