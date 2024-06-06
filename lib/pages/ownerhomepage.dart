import 'package:flutter/material.dart';
import 'package:fyp/components/my_button.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_menubutton.dart';
import 'package:fyp/pages/homepagetemplate.dart';
import 'package:fyp/pages/menupage.dart';
// import 'package:fyp/pages/ownerorderpage.dart';
// import 'package:fyp/pages/summarypage.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({super.key});

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      drawer: const MyDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width, //max width for current phone
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          image: DecorationImage(
            image: const AssetImage("lib/images/applogo.png"),
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.surface.withOpacity(0.2),
              BlendMode.dstATop,
            ),
            alignment: Alignment.center,
            scale: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyButton(
              text: "Hello Owner",
              onPressed: () {},
              margin: 150,
            ),
            const SizedBox(
              height: 80,
            ),
            MyMenuButton(
              text: "Manage Menu",
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MenuPage())),
            ),
            const SizedBox(
              height: 60,
            ),
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
            ),
            MyMenuButton(
              text: "See Template",
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage())),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
