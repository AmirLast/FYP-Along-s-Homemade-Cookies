import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/models/bakedclass.dart';
//import 'package:flutter/foundation.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/services/auth/auth_service.dart';

class UpdateMenuData {
  Future<List<Bakeds?>> updatemenudata() async {
    List cat = UserNow.usernow!.categories;
    int i = cat.length; //check how many categories
    int j = 0; //starts from index 0
    List<Bakeds?> allMenu = []; //to store menus
    AuthService something = AuthService();
    User? user = something.getCurrentUser();
    for (j; j < i; j++) {
      var dir = FirebaseFirestore.instance.collection('users').doc(user!.uid);
      //different category different collection
      await dir.collection(cat[j].toString()).get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            //every document read will be set as Bakeds data and inserted into List<Bakeds>
            //print('${docSnapshot.id} => ${docSnapshot.data()}');
            Bakeds.currentBaked = Bakeds(
              name: docSnapshot.data()['name'],
              description: docSnapshot.data()['description'],
              imagePath: docSnapshot.data()['imagePath'],
              price: double.parse(docSnapshot.data()['price']),
              category: cat[j].toString(),
            );
            allMenu.add(Bakeds.currentBaked);
          }
        },
        //onError: (e) => print("Error completing: $e"),
      );
    }
    return allMenu;
  }
}
