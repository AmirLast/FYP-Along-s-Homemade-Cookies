import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fyp/components/my_menubutton.dart';
import 'package:fyp/models/cartitem.dart';
import 'package:fyp/models/shop.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/customer/deliveryprogresspage.dart';
import 'package:fyp/pages/customer/shoplistpage.dart';
import 'package:provider/provider.dart';

class PayPage extends StatefulWidget {
  final List<CartItem> cartItem;
  const PayPage({super.key, required this.cartItem});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  String id = UserNow.usernow!.currentdir; //for knowing owner shop id

  //user wants to pay-----------------------------------------
  void userTappedPay(Shop shop) {
    if (formKey.currentState!.validate()) {
      //only show dialog if form is valid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm payment", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card Number: $cardNumber"),
                Text("Expiry Date: $expiryDate"),
                Text("Card Holder name: $cardHolderName"),
                Text("CVV: $cvvCode"),
              ],
            ),
          ),
          actions: [
            //cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.black)),
            ),

            //yes button
            TextButton(
              onPressed: () {
                checkCurrentQuantity(shop);
              },
              child: const Text("Yes", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      );
    }
  } //---------------------------------------------------------

  //confirm pop up kalau ada unsaved data---------------------------------------
  confirmPopUp(context, String prodName, Shop shop) {
    //confirm pop up
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: Text(
          "Current available product for " + prodName + " is insufficient",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          //proceed button
          TextButton(
            onPressed: () {
              Navigator.pop(context); //pop this confirm dialogue
              shop.clearCart();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) => const ShopListPage()),
                ModalRoute.withName('/'),
              );
            },
            child: const Text("Proceed", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  } //----------------------------------------------------------------------

  void checkCurrentQuantity(Shop shop) async {
    // loading circle-------------------------
    showDialog(
      barrierDismissible: false, //to prevent outside click
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) {
              return;
            }
          },
          child: const Center(
            child: CircularProgressIndicator(color: Color(0xffB67F5F)),
          ),
        );
      },
    ); //-------------------------------------
    int i = 0;
    int j = widget.cartItem.length;
    var dir = FirebaseFirestore.instance.collection('users').doc(id).collection(widget.cartItem[i].prod!.category);
    for (i; i < j; i++) {
      await dir.where("name", isEqualTo: widget.cartItem[i].prod!.name).get().then((onValue) async {
        for (var docSnapshot in onValue.docs) {
          if (docSnapshot.get("quantity") < widget.cartItem[i].quantity) {
            //if someone checkout first and the quantity exceed available then don't update
            Navigator.pop(context);
            Navigator.pop(context);
            confirmPopUp(context, widget.cartItem[i].prod!.name, shop);
          } else {
            await dir.doc(docSnapshot.id).update(({"quantity": docSnapshot.get("quantity") - widget.cartItem[i].quantity})).then((onValue) {
              if (i + j == j) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeliveryProgressPage(),
                  ),
                );
              }
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, shop, child) => Scaffold(
        backgroundColor: const Color(0xffd1a271),
        appBar: AppBar(
          backgroundColor: const Color(0xffB67F5F),
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Center(
            child: Text(
              "Checkout",
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
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19,
            child: Column(
              children: [
                //credit card
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  onCreditCardWidgetChange: (p0) {},
                ),

                //credit card form
                CreditCardForm(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: (data) {
                    setState(() {
                      cardNumber = data.cardNumber;
                      expiryDate = data.expiryDate;
                      cardHolderName = data.cardHolderName;
                      cvvCode = data.cvvCode;
                    });
                  },
                  formKey: formKey,
                ),

                const Spacer(),

                MyMenuButton(
                  text: "Pay now",
                  onPressed: () {
                    userTappedPay(shop);
                  },
                  icon: Icons.attach_money_rounded,
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
