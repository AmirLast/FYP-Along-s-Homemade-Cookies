import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_ordercard.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/models/orderclass.dart';

class BuyerOrder extends StatefulWidget {
  const BuyerOrder({super.key});

  @override
  State<BuyerOrder> createState() => _BuyerOrderState();
}

class _BuyerOrderState extends State<BuyerOrder> {
  final Logo show = Logo();
  late List<Orders> orders, currentO, pastO, list;
  late String title;
  late int showNext = 0;
  final load = Loading();
  final obj = MyScaffoldmessage();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    reorder();
  }

  void reorder() {
    orders = Orders.currentOrder.orders;
    currentO = orders.where((a) => a.status == "Pin" || a.status == "Pending").toList();
    pastO = orders.where((a) => a.status == "Complete" || a.status == "Cancel").toList();
    currentO.sort((x, y) => x.dateDT.compareTo(y.dateDT)); //all current order sort by date
    pastO.sort((x, y) => x.dateDT.compareTo(y.dateDT)); //all past order sort by date
    if (currentO.isEmpty) {
      list = pastO;
      title = "Past Order";
      pastO = [];
    } else {
      list = currentO;
      title = "Current Order";
    }
    showNext = list.length;
    setState(() {
      isLoading = false;
    });
  }

  void onCancel(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm 'Cancel'?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                iconSize: 50,
                color: Colors.green,
                onPressed: () async {
                  load.loading(context);
                  await FirebaseFirestore.instance.collection('orders').doc(id).update({
                    "status": "Cancel",
                  }).then((onValue) {
                    Orders.currentOrder.orders.firstWhere((test) => test.id == id).status = "Cancel";
                    Navigator.pop(context);
                    Navigator.pop(context);
                    obj.scaffoldmessage("Status updated to Cancel", context);
                    setState(() {
                      reorder();
                    });
                  });
                },
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                iconSize: 50,
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel),
              ),
            ],
          )
        ],
      ),
    );
  }

  void onInfo() {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Delivery Info",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "test",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : Scaffold(
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
                  "Order History",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width, //max width for current phone
                height:
                    MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
                decoration: show.showLogo(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    currentO.isEmpty
                        ? const Expanded(
                            child: Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Text("Order List is empty.."),
                          ))
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: currentO.length + pastO.length,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) {
                                showNext--;
                                return showNext >= 0
                                    ? OrderCard(
                                        title: "Current Order",
                                        index: index,
                                        order: currentO[index],
                                        onCancel: () {},
                                        onComplete: () {},
                                        onInfo: onInfo,
                                        onPin: () {},
                                      )
                                    : OrderCard(
                                        title: "Past Order",
                                        index: index - list.length,
                                        order: pastO[index - list.length],
                                        onCancel: () {},
                                        onComplete: () {},
                                        onInfo: onInfo,
                                        onPin: () {},
                                      );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
