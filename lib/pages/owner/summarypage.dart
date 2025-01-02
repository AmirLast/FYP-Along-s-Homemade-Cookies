import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
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
  int totOrders = 0;
  final totQuant = <Map<String, int>>[];
  var orders = Orders.currentOrder.orders;

  @override
  void initState() {
    super.initState();
    totOrders = orders.length; //total order count
    int i = 0;
    //for every order
    for (i; i < orders.length; i++) {
      int j = 0;
      //for every item in order
      for (j; j < orders[i].cartitems.length; j++) {
        String name = orders[i].cartitems[j].values.elementAt(2);
        int quantity = orders[i].cartitems[j].values.elementAt(0);
        double price = orders[i].cartitems[j].values.elementAt(1);
        if (kDebugMode) {
          print(name);
        }
        //sum the total of price x quantity of each cart items
        totSales += price * quantity;
        int x = 0;
        bool exist = false;
        //if empty, add the product name and quantity
        if (totQuant.isEmpty) {
          totQuant.add({name: quantity});
          exist = true; //prod exist now
        } else {
          //check each list if exist current prod name
          for (x; x < totQuant.length; x++) {
            if (totQuant[x].containsKey(name)) {
              //if exist, sum up the prod quantity with current quantity
              int newQ = totQuant[x].values.first + quantity;
              totQuant[x].update(name, (value) => newQ); //update
              exist = true; //prod name found in list
            }
          }
        }
        if (!exist) {
          //if not found in list, add it
          totQuant.add({name: quantity});
        }
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
                title: const Center(child: Text("Sort By", style: TextStyle(color: Colors.black, fontSize: 15))),
                iconColor: Colors.black,
                collapsedIconColor: Colors.black,
                children: [
                  Container(
                    width: 200,
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: const Center(child: Text("Sales Monthly")),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 200,
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: const Center(child: Text("Sales Yearly")),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 200,
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: const Center(child: Text("Product Sales")),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                  color: Colors.lightGreenAccent.withValues(alpha: 0.5),
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
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: totQuant.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5.0),
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
                            child: Text("${index + 1}. ${totQuant[index].keys.first}",
                                style: const TextStyle(color: Colors.black, fontSize: 15)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 5.0),
                            padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
                            child: Text("total quantity sold: ${totQuant[index].values.first}",
                                style: const TextStyle(color: Colors.black, fontSize: 15)),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
