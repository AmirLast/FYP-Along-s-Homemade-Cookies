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
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //food image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      cartItem.prod.imagePath,
                      height: 100,
                      width: 100,
                    ),
                  ),

                  const SizedBox(width: 10),

                  //name and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //the name
                      Text(cartItem.prod.name),
                      //the price
                      Text(
                        'RM' + cartItem.prod.price.toString(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  //increment or decrement for quantity
                  QuantitySelector(
                    quantity: cartItem.quantity,
                    prod: cartItem.prod,
                    onDec: () {
                      shop.removeFromCart(cartItem);
                    },
                    onInc: () {
                      shop.addToCart(cartItem.prod, cartItem.selectedAddons);
                    },
                  ),
                ],
              ),
            ),

            //addons
            SizedBox(
              height: cartItem.selectedAddons.isEmpty ? 0 : 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                children: cartItem.selectedAddons
                    .map(
                      (addon) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Row(
                            children: [
                              //addon name
                              Text(addon.name),
                              //addon price
                              Text('RM' + addon.price.toString()),
                            ],
                          ),
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          onSelected: (value) {},
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
