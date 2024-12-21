import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fyp/models/orderclass.dart';

class UpdateOrderData {
  Future<List<Orders?>> updateorderdata(String userid, String type) async {
    List<Orders?> allOrder = []; //to store orders
    try {
      await FirebaseFirestore.instance.collection('orders').where(type, isEqualTo: userid).get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            Orders.currentOrder = Orders(
              dateString: docSnapshot.get('date'),
              dateDT: DateTime.parse(docSnapshot.get('date')),
              order: docSnapshot.get('order'),
              status: docSnapshot.get('status'),
            );
            allOrder.add(Orders.currentOrder);
          }
        },
        //onError: (e) => print("Error completing: $e"),
      );
      return allOrder;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return allOrder;
    }
  }
}
