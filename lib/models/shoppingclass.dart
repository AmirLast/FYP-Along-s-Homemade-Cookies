import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/cartitem.dart';
import 'package:fyp/models/userclass.dart';
import 'package:intl/intl.dart';

//these will be in database, but how to make it into a List after reading
//loading screen to wait
//search internet
//read in changenotifier?
//and then make page to edit the product

class Shopping extends ChangeNotifier {
  //list product menu

  // user cart
  final List<CartItem> _cart = [];

  //delivery address (user can change)
  String _deliveryAddress = UserNow.usernow.address;

//getters----------------------------------
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  //operations----------------------------------

  //get current cart
  CartItem? getCurrentCart(Bakeds? prod) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if food item is same
      bool isSameFood = item.prod == prod;
      return isSameFood;
    });
    return cartItem;
  }

  //get current quantity for current item
  int getQuantity(Bakeds? prod) {
    //see if the cart item contain the same prod and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if food item is same
      bool isSameFood = item.prod == prod;
      return isSameFood;
    });

    if (cartItem != null) {
      return cartItem.quantity;
    } else {
      return 0;
    }
  }

  // add to cart
  void addToCart(Bakeds prod, int quantity) {
    //see if there is cart item already w/ same prod and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if food item is same
      bool isSameFood = item.prod == prod;

      return isSameFood;
    });

    //if item already exist -> increase quantity
    if (cartItem != null) {
      if (quantity == 0) {
        //0 means from cart, so change quantity directly
        cartItem.quantity++;
      } else {
        cartItem.quantity += quantity;
      }
    } else {
      //if not exit -> add new into cart
      _cart.add(
        CartItem(
          prod: prod,
          quantity: quantity,
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
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");

    for (final cartItem in _cart) {
      receipt.writeln("${cartItem.quantity} x ${cartItem.prod.name}");
      receipt.writeln("                                                  - " + _formatPrice(cartItem.prod.price * cartItem.quantity));
      if (_cart.last != cartItem) {
        receipt.writeln();
      }
    }

    receipt.writeln("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivering to: $deliveryAddress");

    return receipt.toString();
  }

  // format double value into money
  String _formatPrice(double price) {
    if (price < 10) {
      return "RM  ${price.toStringAsFixed(2)}";
    } else {
      return "RM${price.toStringAsFixed(2)}";
    }
  }
}
