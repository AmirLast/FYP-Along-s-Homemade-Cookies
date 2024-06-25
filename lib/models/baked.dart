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

enum BakedCategory {
  cookie,
  cake,
  bread,
  donut,
  bagel,
  keropok,
  kuihraya,
}
