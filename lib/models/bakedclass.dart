class Bakeds {
  //all data in a product
  String name;
  String description;
  String url;
  double price;
  String category;
  String imagePath;
  int quantity;
  Bakeds({
    required this.name,
    required this.quantity,
    required this.description,
    required this.url,
    required this.price,
    required this.category,
    required this.imagePath,
  });
  static Bakeds currentBaked = Bakeds(
    name: "",
    quantity: 0,
    description: "",
    url: "",
    price: 0,
    category: "",
    imagePath: "",
  ); // the object to call all the above
  void empty() {
    Bakeds.currentBaked = Bakeds(
      name: "",
      quantity: 0,
      description: "",
      url: "",
      price: 0,
      category: "",
      imagePath: "",
    );
  }
}
