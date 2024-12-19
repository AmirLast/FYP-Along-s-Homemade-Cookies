import 'package:flutter/material.dart';
import 'package:fyp/components/my_quantityselector.dart';
import 'package:fyp/models/cartitem.dart';
import 'package:fyp/models/shop.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, shop, child) => Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.fromLTRB(25, 30, 25, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //food image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      cartItem.prod!.url,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                  ),

                  const SizedBox(width: 10),

                  //name and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //the name
                      Text(cartItem.prod!.name),
                      //the price
                      Text(
                        'RM' + cartItem.prod!.price.toStringAsFixed(2),
                        style: const TextStyle(color: Colors.purple),
                      ),
                    ],
                  ),

                  const Spacer(),

                  //increment or decrement for quantity
                  QuantitySelector(
                    quantity: cartItem.quantity,
                    onDec: () {
                      shop.removeFromCart(cartItem);
                    },
                    onInc: () {
                      shop.addToCart(cartItem.prod);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
