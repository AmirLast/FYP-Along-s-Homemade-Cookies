import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/models/orderclass.dart';

class UpdateOrderData {
  final load = Loading(); //to show loading screen
  void updateorderdata(
    String userid,
    String type,
    BuildContext context,
    Widget Function(BuildContext) page,
    String predicate,
  ) async {
    load.loading(context); //show loading screen for both option
    Orders.currentOrder.orders.clear(); //clear current order list
    //final cartitems = <Map<String, int>>[];
    Orders oneOrder;
    try {
      await FirebaseFirestore.instance.collection('orders').where(type, isEqualTo: userid).get().then(
        (querySnapshot) async {
          for (var docSnapshot in querySnapshot.docs) {
            oneOrder = Orders(
              id: docSnapshot.id,
              dateString: docSnapshot.get('date'),
              dateDT: DateTime.parse(docSnapshot.get('date')),
              order: docSnapshot.get('order'),
              status: docSnapshot.get('status'),
              cartitems: docSnapshot.get('cartitem'),
            );
            if (oneOrder.status == "Complete") {
              await FirebaseFirestore.instance.collection('complete').where("id", isEqualTo: oneOrder.id).get().then((value) {
                for (var dSs in value.docs) {
                  oneOrder.reasonOrdate = dSs.get('date');
                }
              });
            }
            if (oneOrder.status == "Cancel") {
              await FirebaseFirestore.instance.collection('cancel').where("id", isEqualTo: oneOrder.id).get().then((value) {
                for (var dSs in value.docs) {
                  oneOrder.reasonOrdate = dSs.get('reason');
                }
              });
            }
            if (oneOrder.status == "Confirm") {
              await FirebaseFirestore.instance.collection('confirm').where("id", isEqualTo: oneOrder.id).get().then((value) {
                for (var dSs in value.docs) {
                  oneOrder.review = dSs.get('review');
                  oneOrder.reviewID = dSs.get('seller');
                }
              }).then((onValue) async {
                await FirebaseFirestore.instance.collection('complete').where("id", isEqualTo: oneOrder.id).get().then((value) {
                  for (var dSs in value.docs) {
                    oneOrder.reasonOrdate = dSs.get('date');
                  }
                });
              });
            }
            Orders.currentOrder.orders.add(oneOrder);
          }
        },
        //onError: (e) => print("Error completing: $e"),
      ).then((onValue) {
        Orders.currentOrder.orders.sort((a, b) => a.dateDT.compareTo(b.dateDT));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: page),
          ModalRoute.withName(predicate),
        );
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
