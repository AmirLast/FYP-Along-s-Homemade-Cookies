import 'package:fyp/models/bakedclass.dart';

class Shops {
  //all data in a product
  String name;
  String id;
  List<Bakeds?> bakeds;
  Shops({
    required this.name,
    required this.bakeds,
    required this.id,
  });
  static Shops? currentShop; // the object to call all the above
}
