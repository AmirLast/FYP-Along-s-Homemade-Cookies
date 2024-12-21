import "package:fyp/models/bakedclass.dart";

class CartItem {
  Bakeds? prod;
  int quantity;

  CartItem({
    required this.prod,
    this.quantity = 0, //initial value is 0
  });

  double get totalPrice {
    return (prod!.price) * quantity;
  }
}
