import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/models/orderclass.dart';

class UpdateOrderData {
  Future<List<Orders?>> updateorderdata(String userid, String type) async {
    List<Orders?> allOrder = []; //to store orders
    await FirebaseFirestore.instance.collection('orders').where(type, isEqualTo: userid).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Orders.currentOrder = Orders(
            date: docSnapshot.data()['date'],
            order: docSnapshot.data()['order'],
            status: docSnapshot.data()['status'],
          );
          allOrder.add(Orders.currentOrder);
        }
      },
      //onError: (e) => print("Error completing: $e"),
    );
    return allOrder;
  }
}
