import "package:fyp/models/baked.dart";

class CartItem {
  Baked prod;
  int quantity;

  CartItem({
    required this.prod,
    this.quantity = 1, //initial value is 1
  });

  double get totalPrice {
    return (prod.price) * quantity;
  }
}
