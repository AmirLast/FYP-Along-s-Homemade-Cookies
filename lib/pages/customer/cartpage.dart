import 'package:flutter/material.dart';
import 'package:fyp/components/my_menubutton.dart';
import 'package:fyp/pages/customer/paymentpage.dart';
import 'package:provider/provider.dart';
import 'package:fyp/models/shop.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, shop, child) {
        //cart
        final userCart = shop.cart;
        //scaffold UI
        return Scaffold(
          backgroundColor: const Color(0xffd1a271),
          appBar: AppBar(
            backgroundColor: const Color(0xffB67F5F),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Center(
              child: Text(
                "Cart",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            foregroundColor: Colors.black,
            actions: [
              //clear cart
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      content: const Text(
                        "Are you sure you want to clear the cart?",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              iconSize: 50,
                              color: Colors.green,
                              onPressed: () {
                                Navigator.pop(context);
                                shop.clearCart();
                              },
                              icon: const Icon(Icons.check_circle),
                            ),
                            IconButton(
                                iconSize: 50,
                                color: Colors.red,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.cancel)),
                          ],
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              )
            ],
          ),
          body: Column(
            children: [
              // list of cart
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? const Expanded(child: Center(child: Text("Cart is empty..")))
                        : Expanded(
                            child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                // get individual cart item
                                final cartItem = userCart[index];

                                // return cart tile UI
                                return ListTile(
                                  title: Text(cartItem.prod.name),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
              //button to pay
              MyMenuButton(
                text: "Go to checkout",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PayPage(),
                  ),
                ),
                icon: Icons.credit_card_rounded,
              ),

              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}
