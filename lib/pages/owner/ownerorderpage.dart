import 'package:flutter/material.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/components/my_ordercart.dart';
import 'package:fyp/models/orderclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/functions/updateorder.dart';

class OwnerOrderPage extends StatefulWidget {
  const OwnerOrderPage({super.key});

  @override
  State<OwnerOrderPage> createState() => _OwnerOrderPageState();
}

class _OwnerOrderPageState extends State<OwnerOrderPage> {
  final Logo show = Logo();
  late List<Orders?> orders = [];
  UserNow? user = UserNow.usernow;
  final obj = UpdateOrderData();
  bool isLoading = true;

  Future<void> updateOrder() async {
    //update menu data in local memory
    await obj.updateorderdata(user!.user.uid, user!.type).then((temp) {
      setState(() {
        orders = temp;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    updateOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(color: Color(0xffB67F5F)),
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
                height:
                    MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
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
                              itemCount: orders.length,
                              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              itemBuilder: (context, index) {
                                return OrderCard(order: orders[index], onCancel: () {}, onCheck: () {});
                              },
                            ),
                          )
                  ],
                ),
              ),
            ),
          );
  }
}
