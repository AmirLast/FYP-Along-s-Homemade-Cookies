class Bakeds {
  //all data in a product
  String name;
  String description;
  String url;
  double price;
  String category;
  String imagePath;
  Bakeds({
    required this.name,
    required this.description,
    required this.url,
    required this.price,
    required this.category,
    required this.imagePath,
  });
  static Bakeds? currentBaked; // the object to call all the above
}
