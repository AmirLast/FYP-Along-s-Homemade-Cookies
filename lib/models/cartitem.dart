import "package:fyp/models/bakedclass.dart";

class CartItem {
  Bakeds? prod;
  int quantity;

  CartItem({
    required this.prod,
    this.quantity = 1, //initial value is 1
  });

  double get totalPrice {
    return (prod!.price) * quantity;
  }
}
