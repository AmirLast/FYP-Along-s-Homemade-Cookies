import "package:fyp/models/baked.dart";

class CartItem {
  Baked prod;
  List<Addon> selectedAddons;
  int quantity;

  CartItem({
    required this.prod,
    required this.selectedAddons,
    this.quantity = 1, //initial value is 1
  });

  double get totalPrice {
    double addonsPrice =
        selectedAddons.fold(0, (sum, addon) => sum + addon.price);
    return (prod.price + addonsPrice) * quantity;
  }
}
