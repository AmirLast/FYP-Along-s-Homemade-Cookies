import 'package:fyp/models/bakedclass.dart';

class Shops {
  //all data in a product
  String name;
  String id;
  List<Bakeds?> bakeds;
  List categories;
  List<Shops> shops = [];
  Shops({
    required this.name,
    required this.bakeds,
    required this.id,
    required this.categories,
  });
  static Shops currentShop = Shops(
    name: "",
    bakeds: [],
    id: "",
    categories: [],
  ); // the object to call all the above
  void empty() {
    Shops.currentShop = Shops(
      name: "",
      bakeds: [],
      id: "",
      categories: [],
    );
    Shops.currentShop.shops.clear();
  }
}
