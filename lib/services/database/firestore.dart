import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/cartitem.dart';
import 'package:fyp/models/shoppingclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FirestoreService {
  final UserNow? user = UserNow.usernow;
  //get collection of orders
  final CollectionReference collection = FirebaseFirestore.instance.collection('orders');
  List<CartItem> cartitem = [];
  final orders = <Map<String, dynamic>>[];
  int i = 0, j = 0;

  //save order to db
  Future<void> saveOrderToDatabase(String receipt, BuildContext context) async {
    cartitem = context.read<Shopping>().cart;
    j = cartitem.length;
    for (i; i < j; i++) {
      orders.add({
        "name": cartitem[i].prod.name,
        "quantity": cartitem[i].quantity,
        "price": cartitem[i].prod.price,
      });
    }
    await collection.add({
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      'order': receipt,
      'cartitem': orders,
      //add more data later
      'seller': user!.currentdir,
      'buyer': user!.user!.uid,
      'status': "Pending",
    });
  }
}
