import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_ordercard.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/models/orderclass.dart';

class OwnerOrderPage extends StatefulWidget {
  const OwnerOrderPage({super.key});

  @override
  State<OwnerOrderPage> createState() => _OwnerOrderPageState();
}

class _OwnerOrderPageState extends State<OwnerOrderPage> {
  final Logo show = Logo();
  late List<Orders> orders;
  late List<Orders> pin, pending, past;
  final load = Loading();
  final obj = MyScaffoldmessage();

  @override
  void initState() {
    super.initState();
    reorder();
  }

  void reorder() {
    orders = Orders.currentOrder.orders;
    pin = orders.where((d) => d.status == "Pin").toList();
    pending = orders.where((d) => d.status == "Pending").toList();
    past = orders.where((d) => d.status == "Complete" || d.status == "Cancel").toList();
    pin.sort((x, y) => x.dateDT.compareTo(y.dateDT));
    pending.sort((x, y) => x.dateDT.compareTo(y.dateDT));
    past.sort((x, y) => x.dateDT.compareTo(y.dateDT)); //all past order sort by date
    pin += pending; //all current order but pin is first, all sort by date
  }

  void changeStatus(String status, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm '$status'?", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    "status": status == "Unpin" ? "Pending" : status,
                  }).then((onValue) {
                    Orders.currentOrder.orders[Orders.currentOrder.orders.indexWhere((test) => test.id == id)].status =
                        status == "Unpin" ? "Pending" : status;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    obj.scaffoldmessage("Status updated to $status", context);
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

  void onCancel(String id) {
    changeStatus("Cancel", id);
  }

  void onComplete(String id) {
    changeStatus("Complete", id);
  }

  void onPin(String id, String status) {
    changeStatus(status == "Pin" ? "Unpin" : "Pin", id);
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
            "Order List",
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
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
          decoration: show.showLogo(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              orders.isEmpty
                  ? const Expanded(
                      child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Text("Order List is empty.."),
                    ))
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: pin.length,
                        padding: const EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, index) {
                          return OrderCard(
                            title: "Current Order",
                            index: index,
                            order: pin[index],
                            onCancel: () {
                              onCancel(pin[index].id);
                            },
                            onComplete: () {
                              onComplete(pin[index].id);
                            },
                            onInfo: () {},
                            onPin: () {
                              onPin(pin[index].id, pin[index].status);
                            },
                          );
                        },
                      ),
                    ),
              Visibility(
                visible: past.isNotEmpty,
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: past.length,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      return OrderCard(
                        title: "Past Order",
                        index: index,
                        order: past[index],
                        onCancel: () {
                          onCancel(past[index].id);
                        },
                        onComplete: () {
                          onComplete(past[index].id);
                        },
                        onInfo: () {},
                        onPin: () {
                          onPin(past[index].id, past[index].status);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
