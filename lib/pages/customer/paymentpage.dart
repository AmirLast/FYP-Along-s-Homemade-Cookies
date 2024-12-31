import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_menubutton.dart';
import 'package:fyp/models/cartitem.dart';
import 'package:fyp/models/memberclass.dart';
import 'package:fyp/models/shoppingclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/customer/deliveryprogresspage.dart';
import 'package:provider/provider.dart';

class PayPage extends StatefulWidget {
  final double priceReduct;
  final int currentPoint;
  final List<CartItem> cartItem;
  const PayPage({
    super.key,
    required this.cartItem,
    required this.priceReduct,
    required this.currentPoint,
  });

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
  String id = UserNow.usernow.currentdir; //for knowing owner shop id
  final load = Loading();

  //user wants to pay-----------------------------------------
  void userTappedPay(Shopping shop) {
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
              onPressed: () async {
                await context.read<Shopping>().updateShopAddress(UserNow.usernow.currentdir);
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
  confirmPopUp(context, String prodName, Shopping shop) {
    //confirm pop up
    showDialog(
      barrierDismissible: false,
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
              Navigator.pop(context);
              shop.clearCart();
              Navigator.popUntil(
                context,
                ModalRoute.withName('shoplist'), //pop until shoplist
              );
            },
            child: const Text("Proceed", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  } //----------------------------------------------------------------------

  void checkCurrentQuantity(Shopping shop) async {
    // loading circle-------------------------
    load.loading(context);
    //-------------------------------------
    int i = 0;
    int j = widget.cartItem.length;
    for (i; i < j; i++) {
      var dir = FirebaseFirestore.instance.collection('users').doc(id).collection(widget.cartItem[i].prod.category);
      await dir.where("name", isEqualTo: widget.cartItem[i].prod.name).get().then((onValue) async {
        for (var docSnapshot in onValue.docs) {
          if (docSnapshot.get("quantity") < widget.cartItem[i].quantity) {
            //if someone checkout first and the quantity exceed available then don't update
            Navigator.pop(context);
            Navigator.pop(context);
            confirmPopUp(context, widget.cartItem[i].prod.name, shop);
          } else {
            await dir
                .doc(docSnapshot.id)
                .update(({"quantity": docSnapshot.get("quantity") - widget.cartItem[i].quantity}))
                .then((onValue) async {
              if (i + 1 == j) {
                if (UserNow.usernow.isMember) {
                  load.loading(context);
                  context.read<Shopping>().updatePriceReduct(widget.priceReduct); //affect if use memberpoint
                  int newPoint = widget.currentPoint + context.read<Shopping>().getTotalPrice().round();
                  if (Member.member.firstPurch) {
                    newPoint += 100;
                    Member.member.firstPurch = false;
                  }
                  bool forrm30purchase = Member.member.rm30Purch && context.read<Shopping>().getTotalPrice() >= 15;
                  bool isrm30Valid = Member.member.rm30Purch && context.read<Shopping>().getTotalPrice() < 15;
                  if (forrm30purchase) {
                    newPoint += 300;
                    Member.member.rm30Purch = false;
                  }
                  if (Member.member.rm10x5Purch < 5 && context.read<Shopping>().getTotalPrice() >= 10) {
                    Member.member.rm10x5Purch += 1;
                    if (Member.member.rm10x5Purch == 5) {
                      newPoint += 300;
                    }
                  }
                  Member.member.memPoint = newPoint;
                  //update member point after paying
                  await FirebaseFirestore.instance
                      .collection('members')
                      .where('id', isEqualTo: UserNow.usernow.user?.uid)
                      .get()
                      .then((qSs) async {
                    for (var dSs in qSs.docs) {
                      await FirebaseFirestore.instance.collection('members').doc(dSs.id).update({
                        'mempoint': newPoint,
                        'firstPurch': false, //whether it's first or not, it will always go to false after the purchase
                        'rm30Purch': isrm30Valid,
                        'rm10x5Purch': Member.member.rm10x5Purch,
                      });
                    }
                  }).then((onValue) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeliveryProgressPage(),
                      ),
                    );
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeliveryProgressPage(),
                    ),
                  );
                }
              }
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shopping>(
      builder: (context, shopping, child) => Scaffold(
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
                    userTappedPay(shopping);
                  },
                  icon: Icons.attach_money_rounded,
                  size: 0,
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
