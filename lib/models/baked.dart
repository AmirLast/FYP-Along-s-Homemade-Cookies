class Baked {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final BakedCategory category;

  Baked({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
  });
}

//baked categories
//make this editable
//delete addon
/*
read from DB, collection baked doc useruid collection (1)prod/(2)category
(1) doc nameoffood -> all data in shop.dart
(2) doc nameofcategory -> just name
*/
enum BakedCategory {
  cookie,
  cake,
  bread,
  donut,
  bagel,
  keropok,
  kuihraya,
}
