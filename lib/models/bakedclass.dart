class Bakeds {
  //all data in a product
  String name;
  String description;
  String url;
  double price;
  String category;
  Bakeds({
    required this.name,
    required this.description,
    required this.url,
    required this.price,
    required this.category,
  });
  static Bakeds? currentBaked; // the object to call all the above
}
