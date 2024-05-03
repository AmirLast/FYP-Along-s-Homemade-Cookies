class Baked {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final BakedCategory category;
  List<Addon> availableAddons;

  Baked({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });
}

//baked categories
enum BakedCategory {
  cookie,
  cake,
  bread,
  donut,
  bagel,
  keropok,
  kuihraya,
}

// baked addons
class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price,
  });
}
