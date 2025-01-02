import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_cachednetworkimage.dart';
import 'package:fyp/components/customer/my_quantityselector.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/models/cartitem.dart';
import 'package:fyp/models/memberclass.dart';
import 'package:fyp/models/shoppingclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/customer/payoption.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatefulWidget {
  final CartItem cartItem;
  final List<CartItem> userCart;
  final int index;

  const MyCartTile({
    super.key,
    required this.cartItem,
    required this.index,
    required this.userCart,
  });

  @override
  State<MyCartTile> createState() => _MyCartTileState();
}

class _MyCartTileState extends State<MyCartTile> {
  final obj = MyScaffoldmessage();
  final obj2 = MyCachednetworkimage();
  final load = Loading();
  double memPointPrice = 0;
  bool isMember = UserNow.usernow.isMember;
  int currentmemPoint = Member.member.memPoint;
  int q = 0;
  bool isBlock = false;
  bool isBlock2 = false;

  void blockButton2() async {
    if (!isBlock2) {
      setState(() {
        isBlock2 = true;
        obj.scaffoldmessage("Exceed available member point", context);
      });
      await Future.delayed(const Duration(seconds: 4));
      setState(() => isBlock2 = false);
    }
  }

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
    return Consumer<Shopping>(
      builder: (context, shopping, child) => Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: GestureDetector(
                    onTap: () {
                      shopping.removeFromCart(widget.cartItem, true);
                    },
                    child: const Icon(Icons.close_rounded, color: Colors.black, size: 20),
                  ),
                ),
                //food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: obj2.showImage(widget.cartItem.prod.url),
                  ),
                ),

                const SizedBox(width: 10),

                //name and price
                SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //the name
                      Text(
                        widget.cartItem.prod.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      //the price
                      const SizedBox(height: 10),
                      Text(
                        'RM' + widget.cartItem.prod.price.toStringAsFixed(2),
                        style: const TextStyle(color: Colors.purple),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                Column(
                  children: [
                    QuantitySelector(
                      //increment or decrement for quantity
                      quantity: widget.cartItem.quantity,
                      onDec: () {
                        shopping.removeFromCart(widget.cartItem, false);
                      },
                      onInc: () {
                        if (widget.cartItem.quantity == widget.cartItem.prod.quantity) {
                          blockButton();
                        } else {
                          shopping.addToCart(widget.cartItem.prod, 0);
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('RM ${(widget.cartItem.quantity * widget.cartItem.prod.price).toStringAsFixed(2)}'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //show total price and check out button and use point button
          widget.index == 1
              ? Column(
                  children: [
                    Visibility(
                      visible: widget.userCart.isNotEmpty,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 15.0),
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                        child: Text(
                          "Total Price: RM${(shopping.getTotalPrice() - 2).toStringAsFixed(2)}",
                          style: const TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.userCart.isNotEmpty,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 35,
                              width: 150,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                child: Text("Use Member Point"),
                              ),
                            ),
                            onTap: !isMember
                                ? null
                                : () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text(
                                              "Member Point Usage",
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                            ),
                                            content: Text(
                                              "100 point = RM1, current point: $currentmemPoint",
                                              style: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                            ),
                                            actions: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  QuantitySelector(
                                                    quantity: q,
                                                    onDec: () {
                                                      if (q > 0) {
                                                        setState(() {
                                                          q--;
                                                        });
                                                      }
                                                    },
                                                    onInc: () {
                                                      if (currentmemPoint / 100 - q >= 1) {
                                                        setState(() {
                                                          q++;
                                                        });
                                                      } else {
                                                        blockButton2();
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    "Total Price: RM${(shopping.getTotalPrice() - 2 - q).toStringAsFixed(2)}",
                                                    style: const TextStyle(color: Colors.black, fontSize: 15),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      //cancel button
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                          setState(() {
                                                            q = 0;
                                                          });
                                                        },
                                                        child: const Text("Go Back", style: TextStyle(color: Colors.black)),
                                                      ),

                                                      //yes button
                                                      TextButton(
                                                        onPressed: () {
                                                          if (q != 0) {
                                                            memPointPrice = double.parse("$q");
                                                            currentmemPoint -= q * 100;
                                                            Navigator.pop(context);
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => PayOptionPage(
                                                                  cartItem: widget.userCart,
                                                                  priceReduct: memPointPrice,
                                                                  currentPoint: currentmemPoint,
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            q = 0;
                                                            Navigator.pop(context);
                                                          }
                                                        },
                                                        child: const Text("Confirm and Pay", style: TextStyle(color: Colors.black)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                              child: Container(
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                  child: Text("Go to checkout"),
                                ),
                              ),
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PayOptionPage(
                                      cartItem: widget.userCart,
                                      priceReduct: memPointPrice,
                                      currentPoint: currentmemPoint,
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    Visibility(visible: widget.userCart.isNotEmpty, child: const SizedBox(height: 15)),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
