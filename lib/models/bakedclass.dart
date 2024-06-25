class Bakeds {
  //all data in a product
  String name;
  String description;
  String imagePath;
  double price;
  String category;
  Bakeds({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
  });
  static Bakeds? currentBaked; // the object to call all the above
}
