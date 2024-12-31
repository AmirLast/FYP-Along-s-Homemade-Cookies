import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/models/cartitem.dart';
import 'package:fyp/pages/customer/fpxpage.dart';
import 'package:fyp/pages/customer/paymentpage.dart';

class PayOptionPage extends StatelessWidget {
  final Logo show = Logo(); //for logo
  final double priceReduct;
  final int currentPoint;
  final List<CartItem> cartItem;
  PayOptionPage({
    super.key,
    required this.cartItem,
    required this.priceReduct,
    required this.currentPoint,
  });

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
            "Payment Option",
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 60),
                  child: Column(
                    children: [
                      const Text(
                        "Choose payment option",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(20)),
                              height: 100,
                              width: 100,
                              child: const Center(child: Text("FPX", style: TextStyle(fontSize: 20, color: Colors.black))),
                            ),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FPXPage())),
                          ),
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(20)),
                              height: 100,
                              width: 100,
                              child: const Center(child: Text("QR Code", style: TextStyle(fontSize: 20, color: Colors.black))),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PayPage(cartItem: cartItem, priceReduct: priceReduct, currentPoint: currentPoint)),
                            ),
                          ),
                        ],
                      ),
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
