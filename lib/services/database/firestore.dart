import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/models/userclass.dart';

class FirestoreService {
  final UserNow? user = UserNow.usernow;
  //get collection of orders
  final CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  //save order to db
  Future<void> saveOrderToDatabase(String receipt) async {
    await orders.add({
      'date': DateTime.now(),
      'order': receipt,
      //add more data later
      'owner': user!.currentdir,
      'buyer': user!.user.uid,
      'status': "Pending",
    });
  }
}
