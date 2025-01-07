import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_ordercard.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/models/orderclass.dart';
import 'package:intl/intl.dart';

class BuyerOrder extends StatefulWidget {
  const BuyerOrder({super.key});

  @override
  State<BuyerOrder> createState() => _BuyerOrderState();
}

class _BuyerOrderState extends State<BuyerOrder> {
  final Logo show = Logo();
  late List<Orders> orders, currentO, pastO;
  final load = Loading();
  final obj = MyScaffoldmessage();
  //text editing controller
  late TextEditingController reasonCancel;
  late TextEditingController review;

  @override
  void initState() {
    super.initState();
    reorder();
  }

  @override
  void dispose() {
    super.dispose();
    reasonCancel.dispose();
    review.dispose();
  }

  void reorder() {
    orders = Orders.currentOrder.orders;
    currentO = orders.where((a) => a.status == "Pin" || a.status == "Pending").toList();
    pastO = orders.where((a) => a.status == "Complete" || a.status == "Cancel" || a.status == "Confirm").toList();
    currentO.sort((x, y) => x.dateDT.compareTo(y.dateDT)); //all current order sort by date
    pastO.sort((x, y) => DateTime.parse(x.onchange).compareTo(DateTime.parse(y.onchange))); //all past order sort by date
    setState(() {
      reasonCancel = TextEditingController();
      review = TextEditingController();
    });
  }

  bool noNeedConfirm(Orders o) {
    DateTime statusTime = DateTime.parse(o.onchange);
    Duration dayPassed = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
        .difference(DateTime(statusTime.year, statusTime.month, statusTime.day));
    return dayPassed.inDays < 3;
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
          controller: reasonCancel,
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
                  if (reasonCancel.text.length < 10) {
                    obj.scaffoldmessage("Please put appropriate reason", context);
                  } else {
                    load.loading(context);
                    await FirebaseFirestore.instance.collection('orders').doc(id).update({
                      "status": "Cancel",
                      'onchange': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                    }).then((onValue) async {
                      await FirebaseFirestore.instance.collection('cancel').doc().set({
                        "id": id,
                        "reason": reasonCancel.text.trim(),
                      });
                    }).then((onValue) {
                      Orders.currentOrder.orders.firstWhere((test) => test.id == id).status = "Cancel";
                      Orders.currentOrder.orders.firstWhere((test) => test.id == id).reasonOrdate = reasonCancel.text.trim();
                      Orders.currentOrder.orders.firstWhere((test) => test.id == id).onchange =
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
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
                  reasonCancel = TextEditingController();
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
          "go to website",
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }

  void onReceive(String id, Orders order) {
    bool doReviewOnly = noNeedConfirm(order);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          "Confirm Receive",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                doReviewOnly ? "Before confirming, you can put a review in the text box." : "You can put your review in this text box.",
                style: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              ),
            ),
            TextField(
              cursorColor: Colors.black,
              autofocus: false,
              enabled: true, //get this value
              controller: review,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey.shade400)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.grey.shade400,
                floatingLabelStyle: const TextStyle(color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: "write your review here...",
                hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.4)),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                iconSize: 50,
                color: Colors.green,
                onPressed: () async {
                  String sellerID = "";
                  load.loading(context);
                  await FirebaseFirestore.instance.collection('orders').doc(id).update({
                    "status": "Confirm",
                    'onchange': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                  }).then((onValue) async {
                    await FirebaseFirestore.instance.collection('orders').doc(id).get().then((value) {
                      sellerID = value.data()?['seller'];
                    }).then((onValue) async {
                      await FirebaseFirestore.instance.collection('confirm').doc().set({
                        "id": id,
                        "seller": sellerID,
                        "review": review.text.trim(),
                      });
                    }).then((onValue) {
                      Orders.currentOrder.orders.firstWhere((test) => test.id == id).status = "Confirm";
                      Orders.currentOrder.orders.firstWhere((test) => test.id == id).onchange =
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
                      Navigator.pop(context);
                      Navigator.pop(context);
                      obj.scaffoldmessage("Order confirmed received", context);
                      setState(() {
                        reorder();
                      });
                    });
                  });
                },
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                iconSize: 50,
                color: Colors.red,
                onPressed: () {
                  reasonCancel = TextEditingController();
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
            "Order History",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
          decoration: show.showLogo(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              orders.isEmpty
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
                          return index < currentO.length
                              ? OrderCard(
                                  title: "Current Order",
                                  index: index,
                                  order: currentO[index],
                                  onCancel: () {
                                    onCancel(currentO[index].id);
                                  },
                                  onComplete: () {},
                                  onInfo: onInfo,
                                  onPin: () {},
                                  onReceive: () {
                                    onReceive(currentO[index].id, currentO[index]);
                                  },
                                )
                              : OrderCard(
                                  title: "Past Order",
                                  index: index - currentO.length,
                                  order: pastO[index - currentO.length],
                                  onCancel: () {},
                                  onComplete: () {},
                                  onInfo: onInfo,
                                  onPin: () {},
                                  onReceive: () {
                                    onReceive(pastO[index - currentO.length].id, pastO[index - currentO.length]);
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
