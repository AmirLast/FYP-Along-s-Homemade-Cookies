import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_sortby.dart';
import 'package:fyp/components/owner/my_salespermonth.dart';
import 'package:fyp/components/owner/my_salestotal.dart';
import 'package:fyp/components/owner/my_salescomparison.dart';
import 'package:fyp/models/orderclass.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final Logo show = Logo(); //for logo
  bool isExpand = false;
  double totSales = 0;
  final totQuant = <Map<String, int>>[];
  var orders = Orders.currentOrder.orders.where((x) => x.status == "Confirm").toList();

  @override
  void initState() {
    super.initState();
    int i = 0;
    //for every order
    for (i; i < orders.length; i++) {
      int j = 0;
      //for every item in order
      for (j; j < orders[i].cartitems.length; j++) {
        int quantity = orders[i].cartitems[j].values.elementAt(0);
        double price = orders[i].cartitems[j].values.elementAt(1);
        //sum the total of price x quantity of each cart items
        totSales += price * quantity;
      }
    }
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              MySortBy(
                enable: true,
                width: 180,
                options: const ["Individual Product Sales", "Total Product Sales"],
                functions: [() {}, () {}],
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                    color: Colors.lightGreenAccent.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                          child: const Text("Product Sales", style: TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child:
                          Text("Total Sales: RM " + totSales.toStringAsFixed(2), style: const TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                    const MySalesTotal(),
                    const MySalesComparison(),
                    const MySalesPerMonth(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
