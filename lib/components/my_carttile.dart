import 'package:flutter/material.dart';
import 'package:fyp/components/my_cachednetworkimage.dart';
import 'package:fyp/components/my_quantityselector.dart';
import 'package:fyp/components/my_scaffoldmessage.dart';
import 'package:fyp/models/cartitem.dart';
import 'package:fyp/models/shop.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatefulWidget {
  final CartItem cartItem;

  const MyCartTile({super.key, required this.cartItem});

  @override
  State<MyCartTile> createState() => _MyCartTileState();
}

class _MyCartTileState extends State<MyCartTile> {
  final obj = MyScaffoldmessage();
  final obj2 = MyCachednetworkimage();
  bool isBlock = false;

  void blockButton() async {
    if (!isBlock) {
      setState(() {
        isBlock = true;
        obj.scaffoldmessage("Exceed available quantity", context);
      });
      await Future.delayed(const Duration(seconds: 4));
      setState(() => isBlock = false);
    }
  }

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
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: obj2.showImage(widget.cartItem.prod!.url),
                      )),

                  const SizedBox(width: 10),

                  //name and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //the name
                      Text(widget.cartItem.prod!.name),
                      //the price
                      Text(
                        'RM' + widget.cartItem.prod!.price.toStringAsFixed(2),
                        style: const TextStyle(color: Colors.purple),
                      ),
                    ],
                  ),

                  const Spacer(),

                  //increment or decrement for quantity
                  QuantitySelector(
                    quantity: widget.cartItem.quantity,
                    onDec: () {
                      shop.removeFromCart(widget.cartItem);
                    },
                    onInc: () {
                      if (widget.cartItem.quantity == widget.cartItem.prod!.quantity) {
                        blockButton();
                      } else {
                        shop.addToCart(widget.cartItem.prod, 0);
                      }
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
