import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/baked.dart';
import 'package:fyp/models/cartitem.dart';
import 'package:intl/intl.dart';

//these will be in database, but how to make it into a List after reading
//loading screen to wait
//search internet
//read in changenotifier?
//and then make page to edit the product

class Shop extends ChangeNotifier {
  //list product menu
  final List<Baked> _menu = [
    //cookie
    Baked(
      name: "Salted Chocolate Chip Cookie",
      description: "A chocolate chip cookie dressed with a sprinkle of salt",
      imagePath: "lib/images/default_cookie.jpg",
      price: 10.00,
      category: BakedCategory.cookie,
    ),
    Baked(
      name: "Second Cookie",
      description: "Second dummy item for cookie",
      imagePath: "lib/images/default_cookie.jpg",
      price: 20.00,
      category: BakedCategory.cookie,
    ),
    Baked(
      name: "Third Cookie",
      description: "Third dummy item for cookie",
      imagePath: "lib/images/default_cookie.jpg",
      price: 30.00,
      category: BakedCategory.cookie,
    ),

    //cake

    Baked(
      name: "First Cake",
      description: "First dummy item for cake",
      imagePath: "lib/images/default_cake.jpg",
      price: 10.00,
      category: BakedCategory.cake,
    ),
    Baked(
      name: "Second Cake",
      description: "Second dummy item for cake",
      imagePath: "lib/images/default_cake.jpg",
      price: 20.00,
      category: BakedCategory.cake,
    ),
    Baked(
      name: "Third Cake",
      description: "Third dummy item for cake",
      imagePath: "lib/images/default_cake.jpg",
      price: 30.00,
      category: BakedCategory.cake,
    ),

    //bread

    Baked(
      name: "First Bread",
      description: "First dummy item for bread",
      imagePath: "lib/images/default_bread.jpg",
      price: 10.00,
      category: BakedCategory.bread,
    ),
    Baked(
      name: "Second Bread",
      description: "Second dummy item for bread",
      imagePath: "lib/images/default_bread.jpg",
      price: 20.00,
      category: BakedCategory.bread,
    ),
    Baked(
      name: "Third Bread",
      description: "Third dummy item for bread",
      imagePath: "lib/images/default_bread.jpg",
      price: 30.00,
      category: BakedCategory.bread,
    ),
  ];

  // user cart
  final List<CartItem> _cart = [];

  //delivery address (user can change)
  String _deliveryAddress = 'Earth, Milky Way';

//getters----------------------------------
  List<Baked> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  //operations----------------------------------

  // add to cart
  void addToCart(Baked prod) {
    //see if there is cart item already w/ same prod and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if food item is same
      bool isSameFood = item.prod == prod;

      return isSameFood;
    });

    //if item already exist -> increase quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }
    //if not exit -> add new into cart
    else {
      _cart.add(
        CartItem(
          prod: prod,
        ),
      );
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }

    notifyListeners();
  }

  // total price betul ke cara kira ni?
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.prod.price;

      total += itemTotal * cartItem.quantity; //betul ke cara kira ni?
    }
    return total;
  }

  // total item
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  //update delivery address
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  //helpers----------------------------------

  // generate receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt.");
    receipt.writeln();

    //format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("----------");

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.prod.name} - ${_formatPrice(cartItem.prod.price)}");
      receipt.writeln();
    }

    receipt.writeln("----------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivering to: $deliveryAddress");

    return receipt.toString();
  }

  // format double value into money
  String _formatPrice(double price) {
    return "RM${price.toStringAsFixed(2)}";
  }
}
