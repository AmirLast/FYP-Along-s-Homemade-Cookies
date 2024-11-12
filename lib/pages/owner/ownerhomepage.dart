import 'package:flutter/material.dart';
//import 'package:fyp/components/my_button.dart';
import 'package:fyp/components/my_drawer.dart';
//import 'package:fyp/components/my_menubutton.dart';
import 'package:fyp/models/userclass.dart';
//import 'package:fyp/pages/homepagetemplate.dart';
import 'package:fyp/pages/all_user/settingspage.dart';
import 'package:fyp/pages/owner/menupage.dart';
// import 'package:fyp/pages/ownerorderpage.dart';
// import 'package:fyp/pages/summarypage.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({super.key});

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage>
    with SingleTickerProviderStateMixin {
  //owner data from ownerclass.dart
  String fname = UserNow.usernow!.fname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd1a271),
      ),
      drawer: const MyDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width, //max width for current phone
        height:
            MediaQuery.of(context).size.height, //max width for current phone
        decoration: BoxDecoration(
          color: const Color(0xffd1a271),
          image: DecorationImage(
            image: const AssetImage("lib/images/applogo.png"),
            colorFilter: ColorFilter.mode(
              const Color(0xffd1a271).withOpacity(0.2),
              BlendMode.dstATop,
            ),
            alignment: Alignment.center,
            scale: 0.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize:
                  MainAxisSize.max, //max maksudnya penuh container ke?
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage())),
                  icon: const Icon(Icons.account_circle),
                ),
                Text(
                  "Hello " + fname,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MenuPage())),
                  icon: const Icon(Icons.add_shopping_cart),
                ),
              ],
            ),
            const Image(
              image: AssetImage("lib/images/default_bagel.jpg"),
              height: 200,
              width: 300,
            ),

            /*
            List function2 owner yang belum terciptakan
            MyMenuButton(
                text: "Business Summary",
                onPressed: () {} //=> Navigator.push(context,
                //MaterialPageRoute(builder: (context) => const SummaryPage())),
                ),
            const SizedBox(
              height: 60,
            ),
            MyMenuButton(
                text: "Customer Order", onPressed: () {} //=> Navigator.push(
                //context,
                //MaterialPageRoute(
                //builder: (context) => const OwnerOrderPage())),
                ),
            const SizedBox(
              height: 60,
            */
          ],
        ),
      ),
    );
  }
}
