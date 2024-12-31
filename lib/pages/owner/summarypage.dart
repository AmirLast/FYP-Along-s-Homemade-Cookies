import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final Logo show = Logo(); //for logo
  bool isExpand = false;
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
            "Business Summary",
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
          children: [
            const SizedBox(height: 15),
            SizedBox(
              width: 200,
              child: ExpansionTile(
                onExpansionChanged: (value) {
                  setState(() {
                    isExpand = value;
                  });
                },
                trailing: Icon(
                  isExpand ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
                ),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                collapsedBackgroundColor: Colors.grey.shade400,
                backgroundColor: Colors.grey.shade400,
                title: const Center(child: Text("Sort By", style: TextStyle(color: Colors.black))),
                iconColor: Colors.black,
                collapsedIconColor: Colors.black,
                children: [
                  Container(
                    width: 200,
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(child: Text("Sales Monthly")),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 200,
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(child: Text("Sales Yearly")),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 200,
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(child: Text("Product Sales")),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(color: Colors.lightGreenAccent, borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Total Sales", style: TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(color: Colors.lightGreenAccent, borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Product Sales", style: TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
