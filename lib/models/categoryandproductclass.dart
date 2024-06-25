class Category {
  //how to make this read a whole list?
  final String name;

  Category({
    required this.name,
  });
}

class Product {
  //how to make this read a whole list?
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final Category category; //???

  Product({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category, //???
  });
}
