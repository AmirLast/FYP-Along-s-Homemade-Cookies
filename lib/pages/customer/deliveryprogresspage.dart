import 'package:flutter/material.dart';
import 'package:fyp/components/my_receipt.dart';
import 'package:fyp/models/shop.dart';
import 'package:fyp/pages/customer/shoplistpage.dart';
import 'package:fyp/services/database/firestore.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  //get access to db
  FirestoreService db = FirestoreService();

  @override
  void initState() {
    super.initState();

    //submit order to firestore db
    String receipt = context.read<Shop>().displayCartReceipt();
    db.saveOrderToDatabase(receipt);
  }

  void toPop(Shop shop) {
    shop.clearCart();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => const ShopListPage()),
      ModalRoute.withName('/'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, shop, child) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          toPop(shop);
        },
        child: Scaffold(
          backgroundColor: const Color(0xffd1a271),
          appBar: AppBar(
            backgroundColor: const Color(0xffB67F5F),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                toPop(shop);
              },
            ),
            title: const Center(
              child: Text(
                "Receipt",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
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
          bottomNavigationBar: _buildBottomNavBar(context),
          body: const Column(
            children: [
              MyReceipt(),
            ],
          ),
        ),
      ),
    );
  }

  //Custom bottom naavigation bar - messages/call delivery driver
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          children: [
            //pfp of driver
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {},
              ),
            ),

            const SizedBox(width: 10),

            //driver detail
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Abdul Dilan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Driver",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            const Spacer(),

            Row(
              children: [
                //message button
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                    icon: const Icon(Icons.message),
                    color: Colors.blue.shade900,
                    onPressed: () {},
                  ),
                ),

                const SizedBox(width: 10),

                //call button
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                    icon: const Icon(Icons.call),
                    color: Colors.green,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
