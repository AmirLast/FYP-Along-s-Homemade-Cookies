import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/shopclass.dart';

class Showloading {
  final load = Loading(); //to show loading screen
  void showloading(
      String currentDir, Widget Function(BuildContext) page, RouteSettings? routeName, String predicate, BuildContext context) async {
    load.loading(context); //show loading screen for both option
    List<Shops> shops = [];
    if (currentDir == "") {
      //option 1: goto shoplist
      List cat = [];
      int i = 0; //check how many categories
      int j = 0; //starts from index 0
      List<Bakeds?> allMenu = []; //to store menus
      try {
        await FirebaseFirestore.instance.collection('users').where("type", isEqualTo: "seller").get().then((querySnapshot) async {
          for (var docSnapshot in querySnapshot.docs) {
            cat = docSnapshot.data()['categories'];
            allMenu = []; //reset
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
            //add the shop into the list
            Shops.currentShop = Shops(
              name: docSnapshot.data()['shop'],
              bakeds: allMenu,
              id: docSnapshot.id,
              categories: docSnapshot.data()['categories'],
            );
            shops.add(Shops.currentShop);
          }
        }).then((onValue) {
          Shops.currentShop.shops = shops;
          //go next page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(builder: page, settings: routeName),
            ModalRoute.withName(predicate),
          );
        });
      } on FirebaseException catch (e) {
        if (kDebugMode) {
          print("Error is" + e.code.toString());
        }
        throw Exception(e);
      }
    } else {
      //option 2: goto shoppage
      List cat = [];
      String name = "";
      var dir = FirebaseFirestore.instance.collection('users').doc(currentDir);
      try {
        await dir.get().then((value) {
          cat = value.data()?['categories'];
          name = value.data()?['shop'];
        }).then((onValue) async {
          int i = 0; //starts from index 0
          int j = cat.length; //check how many categories
          List<Bakeds?> allMenu = []; //to store menus
          for (i; i < j; i++) {
            await dir.collection(cat[i].toString()).get().then(
              (querySnapshot) {
                for (var docSnapshot in querySnapshot.docs) {
                  //every document read will be set as Bakeds data and inserted into List<Bakeds>
                  Bakeds.currentBaked = Bakeds(
                    quantity: docSnapshot.data()['quantity'],
                    imagePath: docSnapshot.data()['imagePath'],
                    name: docSnapshot.data()['name'],
                    description: docSnapshot.data()['description'],
                    url: docSnapshot.data()['url'],
                    price: double.parse(docSnapshot.data()['price']),
                    category: cat[i].toString(),
                  );
                  allMenu.add(Bakeds.currentBaked);
                }
              },
              //onError: (e) => print("Error completing: $e"),
            );
          }
          //add the shop into the list
          Shops.currentShop = Shops(
            name: name,
            bakeds: allMenu,
            id: currentDir,
            categories: cat,
          );
          shops.add(Shops.currentShop);
        }).then((onValue) {
          Shops.currentShop.shops = shops;
          //go to next page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(builder: page, settings: routeName),
            ModalRoute.withName(predicate),
          );
        });
      } on FirebaseException catch (e) {
        if (kDebugMode) {
          print("Error is" + e.code.toString());
        }
        throw Exception(e);
      }
    }
  }
}
