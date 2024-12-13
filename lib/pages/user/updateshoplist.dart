import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/shopclass.dart';

class UpdateShopList {
  Future<List<Shops?>> updateshoplist() async {
    List cat = [];
    int i = 0; //check how many categories
    int j = 0; //starts from index 0
    List<Bakeds?> allMenu = []; //to store menus
    List<Shops?> allShops = []; //to store shops with menus in it

    await FirebaseFirestore.instance.collection('users').where("type", isEqualTo: "owner").get().then((querySnapshot) async {
      for (var docSnapshot in querySnapshot.docs) {
        cat = docSnapshot.data()['categories'];
        i = cat.length;
        for (j; j < i; j++) {
          var dir = FirebaseFirestore.instance.collection('users').doc(docSnapshot.id);
          //different category different collection
          await dir.collection(cat[j].toString()).get().then(
            (querySnapshot) {
              for (var docSnapshot in querySnapshot.docs) {
                //every document read will be set as Bakeds data and inserted into List<Bakeds>
                //print('${docSnapshot.id} => ${docSnapshot.data()}');
                Bakeds.currentBaked = Bakeds(
                  name: docSnapshot.data()['name'],
                  description: docSnapshot.data()['description'],
                  url: docSnapshot.data()['url'],
                  price: double.parse(docSnapshot.data()['price']),
                  category: cat[j].toString(),
                );
                allMenu.add(Bakeds.currentBaked);
              }
            },
            //onError: (e) => print("Error completing: $e"),
          );
        }
        allShops.add(Shops(name: docSnapshot.data()['shop'], bakeds: allMenu));
      }
    });
    return allShops;
  }
}
