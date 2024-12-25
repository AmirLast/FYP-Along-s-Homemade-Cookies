import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_ordercard.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/models/orderclass.dart';
import 'package:intl/intl.dart';

class OwnerOrderPage extends StatefulWidget {
  const OwnerOrderPage({super.key});

  @override
  State<OwnerOrderPage> createState() => _OwnerOrderPageState();
}

class _OwnerOrderPageState extends State<OwnerOrderPage> {
  final Logo show = Logo();
  late List<Orders> orders, pin, pending, past;
  final load = Loading();
  final obj = MyScaffoldmessage();

  late TextEditingController reason;

  @override
  void initState() {
    super.initState();
    reorder();
  }

  @override
  void dispose() {
    super.dispose();
    reason.dispose();
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
    setState(() {
      reason = TextEditingController();
    });
  }

  void onCancel(String id) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Please add your reasoning before cancelling", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        content: TextField(
          cursorColor: Colors.black,
          autofocus: false,
          enabled: true, //get this value
          controller: reason,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey.shade400)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            filled: true,
            fillColor: Colors.grey.shade400,
            floatingLabelStyle: const TextStyle(color: Colors.black),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: "write your reason here...",
            hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.4)),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                iconSize: 50,
                color: Colors.green,
                onPressed: () async {
                  if (reason.text.length < 10) {
                    obj.scaffoldmessage("Please put appropriate reason", context);
                  } else {
                    load.loading(context);
                    await FirebaseFirestore.instance.collection('orders').doc(id).update({
                      "status": "Cancel",
                    }).then((onValue) async {
                      await FirebaseFirestore.instance.collection('cancel').doc().set({
                        "id": id,
                        "reason": reason.text.trim(),
                      });
                    }).then((onValue) {
                      Orders.currentOrder.orders.firstWhere((test) => test.id == id).status = "Cancel";
                      Orders.currentOrder.orders.firstWhere((test) => test.id == id).reasonOrdate = reason.text.trim();
                      Navigator.pop(context);
                      Navigator.pop(context);
                      obj.scaffoldmessage("Status updated to Cancel", context);
                      setState(() {
                        reorder();
                      });
                    });
                  }
                },
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                iconSize: 50,
                color: Colors.red,
                onPressed: () {
                  reason = TextEditingController();
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

  void onComplete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Complete?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    "status": "Complete",
                  }).then((onValue) async {
                    await FirebaseFirestore.instance.collection('complete').doc().set({
                      "id": id,
                      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                    });
                  }).then((onValue) {
                    Orders.currentOrder.orders.firstWhere((test) => test.id == id).status = "Complete";
                    Orders.currentOrder.orders.firstWhere((test) => test.id == id).reasonOrdate =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
                    Navigator.pop(context);
                    Navigator.pop(context);
                    obj.scaffoldmessage("Status updated to Complete", context);
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

  void onPin(String id, String status) {
    String newStatus = status == "Pin" ? "Unpin" : "Pin";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm $newStatus?", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    "status": newStatus,
                  }).then((onValue) {
                    Orders.currentOrder.orders[Orders.currentOrder.orders.indexWhere((test) => test.id == id)].status = newStatus;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    obj.scaffoldmessage("Status updated to $newStatus", context);
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
                        itemCount: pin.length + past.length,
                        padding: const EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, index) {
                          return index < pin.length
                              ? OrderCard(
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
                                )
                              : OrderCard(
                                  title: "Past Order",
                                  index: index - pin.length,
                                  order: past[index - pin.length],
                                  onCancel: () {
                                    onCancel(past[index - pin.length].id);
                                  },
                                  onComplete: () {
                                    onComplete(past[index - pin.length].id);
                                  },
                                  onInfo: () {},
                                  onPin: () {
                                    onPin(past[index - pin.length].id, past[index - pin.length].status);
                                  },
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
