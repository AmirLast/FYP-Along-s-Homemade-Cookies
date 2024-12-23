import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/models/userclass.dart';
import 'package:intl/intl.dart';

class FirestoreService {
  final UserNow? user = UserNow.usernow;
  //get collection of orders
  final CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  //save order to db
  Future<void> saveOrderToDatabase(String receipt) async {
    await orders.add({
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      'order': receipt,
      //add more data later
      'owner': user!.currentdir,
      'buyer': user!.user!.uid,
      'status': "Pending",
    });
  }
}
