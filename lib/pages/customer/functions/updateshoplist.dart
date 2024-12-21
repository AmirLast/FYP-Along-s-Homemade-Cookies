import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/shopclass.dart';

class UpdateShopList {
  Future<List<Shops?>> updateshoplist() async {
    List cat = [];
    int i = 0; //check how many categories
    int j = 0; //starts from index 0
    List<Bakeds?> allMenu = []; //to store menus
    List<Shops?> allShops = []; //to store shops with menus in it
    try {
      await FirebaseFirestore.instance.collection('users').where("type", isEqualTo: "owner").get().then((querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          cat = docSnapshot.data()['categories'];
          i = cat.length;
          j = 0; //resetter
          //print('${docSnapshot.id} => ${docSnapshot.data()}');
          for (j; j < i; j++) {
            //different category different collection
            var dir = FirebaseFirestore.instance.collection('users').doc(docSnapshot.id);
            await dir.collection(cat[j].toString()).get().then(
              (querySnapshot) {
                for (var docSnapshot2 in querySnapshot.docs) {
                  //every document read will be set as Bakeds data and inserted into List<Bakeds>
                  //print('${docSnapshot.id} => ${docSnapshot.data()}');
                  Bakeds.currentBaked = Bakeds(
                    quantity: docSnapshot2.data()['quantity'],
                    imagePath: docSnapshot2.data()['imagePath'],
                    name: docSnapshot2.data()['name'],
                    description: docSnapshot2.data()['description'],
                    url: docSnapshot2.data()['url'],
                    price: double.parse(docSnapshot2.data()['price']),
                    category: cat[j].toString(),
                  );
                  allMenu.add(Bakeds.currentBaked);
                }
              },
              //onError: (e) => print("Error completing: $e"),
            );
          }
          allShops.add(Shops(
            id: docSnapshot.id,
            name: docSnapshot.data()['shop'],
            bakeds: allMenu,
            categories: docSnapshot.data()['categories'],
          ));
        }
      });
      return allShops;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Error is" + e.code.toString());
      }
      throw Exception(e);
    }
  }
}
