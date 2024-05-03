import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/baked.dart';
import 'package:fyp/models/cartitem.dart';
import 'package:intl/intl.dart';

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
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Second Cookie",
      description: "Second dummy item for cookie",
      imagePath: "lib/images/default_cookie.jpg",
      price: 20.00,
      category: BakedCategory.cookie,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Third Cookie",
      description: "Third dummy item for cookie",
      imagePath: "lib/images/default_cookie.jpg",
      price: 30.00,
      category: BakedCategory.cookie,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fourth Cookie",
      description: "Fourth dummy item for cookie",
      imagePath: "lib/images/default_cookie.jpg",
      price: 40.00,
      category: BakedCategory.cookie,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fifth Cookie",
      description: "Fifth dummy item for cookie",
      imagePath: "lib/images/default_cookie.jpg",
      price: 50.00,
      category: BakedCategory.cookie,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),

    //cake

    Baked(
      name: "First Cake",
      description: "First dummy item for cake",
      imagePath: "lib/images/default_cake.jpg",
      price: 10.00,
      category: BakedCategory.cake,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Second Cake",
      description: "Second dummy item for cake",
      imagePath: "lib/images/default_cake.jpg",
      price: 20.00,
      category: BakedCategory.cake,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Third Cake",
      description: "Third dummy item for cake",
      imagePath: "lib/images/default_cake.jpg",
      price: 30.00,
      category: BakedCategory.cake,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fourth Cake",
      description: "Fourth dummy item for cake",
      imagePath: "lib/images/default_cake.jpg",
      price: 40.00,
      category: BakedCategory.cake,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fifth Cake",
      description: "Fifth dummy item for cake",
      imagePath: "lib/images/default_cake.jpg",
      price: 50.00,
      category: BakedCategory.cake,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    //bread

    Baked(
      name: "First Bread",
      description: "First dummy item for bread",
      imagePath: "lib/images/default_bread.jpg",
      price: 10.00,
      category: BakedCategory.bread,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Second Bread",
      description: "Second dummy item for bread",
      imagePath: "lib/images/default_bread.jpg",
      price: 20.00,
      category: BakedCategory.bread,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Third Bread",
      description: "Third dummy item for bread",
      imagePath: "lib/images/default_bread.jpg",
      price: 30.00,
      category: BakedCategory.bread,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fourth Bread",
      description: "Fourth dummy item for bread",
      imagePath: "lib/images/default_bread.jpg",
      price: 40.00,
      category: BakedCategory.bread,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fifth Bread",
      description: "Fifth dummy item for bread",
      imagePath: "lib/images/default_bread.jpg",
      price: 50.00,
      category: BakedCategory.bread,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),

    //donut

    Baked(
      name: "First Donut",
      description: "First dummy item for donut",
      imagePath: "lib/images/default_donut.jpg",
      price: 10.00,
      category: BakedCategory.donut,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Second Donut",
      description: "Second dummy item for donut",
      imagePath: "lib/images/default_donut.jpg",
      price: 20.00,
      category: BakedCategory.donut,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Third Donut",
      description: "Third dummy item for donut",
      imagePath: "lib/images/default_donut.jpg",
      price: 30.00,
      category: BakedCategory.donut,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fourth Donut",
      description: "Fourth dummy item for donut",
      imagePath: "lib/images/default_donut.jpg",
      price: 40.00,
      category: BakedCategory.donut,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fifth Donut",
      description: "Fifth dummy item for donut",
      imagePath: "lib/images/default_donut.jpg",
      price: 50.00,
      category: BakedCategory.donut,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),

    //bagel

    Baked(
      name: "First Bagel",
      description: "First dummy item for bagel",
      imagePath: "lib/images/default_bagel.jpg",
      price: 10.00,
      category: BakedCategory.bagel,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Second Bagel",
      description: "Second dummy item for bagel",
      imagePath: "lib/images/default_bagel.jpg",
      price: 20.00,
      category: BakedCategory.bagel,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Third Bagel",
      description: "Third dummy item for bagel",
      imagePath: "lib/images/default_bagel.jpg",
      price: 30.00,
      category: BakedCategory.bagel,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fourth Bagel",
      description: "Fourth dummy item for bagel",
      imagePath: "lib/images/default_bagel.jpg",
      price: 40.00,
      category: BakedCategory.bagel,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fifth Bagel",
      description: "Fifth dummy item for bagel",
      imagePath: "lib/images/default_bagel.jpg",
      price: 50.00,
      category: BakedCategory.bagel,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),

    //keropok

    Baked(
      name: "First Keropok",
      description: "First dummy item for keropok",
      imagePath: "lib/images/default_keropok.jpg",
      price: 10.00,
      category: BakedCategory.keropok,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Second Keropok",
      description: "Second dummy item for keropok",
      imagePath: "lib/images/default_keropok.jpg",
      price: 20.00,
      category: BakedCategory.keropok,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Third Keropok",
      description: "Third dummy item for keropok",
      imagePath: "lib/images/default_keropok.jpg",
      price: 30.00,
      category: BakedCategory.keropok,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fourth Keropok",
      description: "Fourth dummy item for keropok",
      imagePath: "lib/images/default_keropok.jpg",
      price: 40.00,
      category: BakedCategory.keropok,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fifth Keropok",
      description: "Fifth dummy item for keropok",
      imagePath: "lib/images/default_keropok.jpg",
      price: 50.00,
      category: BakedCategory.keropok,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),

    //kuihraya

    Baked(
      name: "First Kuih Raya",
      description: "First dummy item for kuihraya",
      imagePath: "lib/images/default_kuihraya.jpg",
      price: 10.00,
      category: BakedCategory.kuihraya,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Second Kuih Raya",
      description: "Second dummy item for kuihraya",
      imagePath: "lib/images/default_kuihraya.jpg",
      price: 20.00,
      category: BakedCategory.kuihraya,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Third Kuih Raya",
      description: "Third dummy item for kuihraya",
      imagePath: "lib/images/default_kuihraya.jpg",
      price: 30.00,
      category: BakedCategory.kuihraya,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fourth Kuih Raya",
      description: "Fourth dummy item for kuihraya",
      imagePath: "lib/images/default_kuihraya.jpg",
      price: 40.00,
      category: BakedCategory.kuihraya,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
    ),
    Baked(
      name: "Fifth Kuih Raya",
      description: "Fifth dummy item for kuihraya",
      imagePath: "lib/images/default_kuihraya.jpg",
      price: 50.00,
      category: BakedCategory.kuihraya,
      availableAddons: [
        Addon(
          name: "One",
          price: 0.10,
        ),
        Addon(
          name: "Two",
          price: 0.20,
        ),
        Addon(
          name: "Three",
          price: 0.30,
        ), //tambahan yang customer boleh mintak untuk sesuatu order
      ],
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
  void addToCart(Baked prod, List<Addon> selectedAddons) {
    //see if there is cart item already w/ same prod and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if food item is same
      bool isSameFood = item.prod == prod;

      // check if list addons is same
      bool isSameAddons =
          const ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
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
          selectedAddons: selectedAddons,
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

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

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
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt
            .writeln("   Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
      }
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

  // format list addons into a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }
}
