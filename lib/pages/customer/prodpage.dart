import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_cachednetworkimage.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_menubutton.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/images/assets.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/shoppingclass.dart';
import 'package:provider/provider.dart';

class ProdPage extends StatefulWidget {
  final Bakeds? prod;
  const ProdPage({super.key, required this.prod});

  @override
  State<ProdPage> createState() => _EditProdPageState();
}

class _EditProdPageState extends State<ProdPage> {
  late String src;
  late int q;
  final obj = MyScaffoldmessage();
  final obj2 = MyCachednetworkimage();
  final logo = Logo();
  bool isBlock = false;

  //method to add to cart
  void addToCart(Bakeds? prod, int quantity) {
    Navigator.pop(context);
    // close current prod page
    Bakeds prod2 = prod!;
    //add to cart
    context.read<Shopping>().addToCart(prod2, quantity);
  }

  @override
  void initState() {
    super.initState();
    src = widget.prod!.url;
    q = 0;
  }

  //confirm pop up kalau ada unsaved data---------------------------------------
  confirmPopUp(context) {
    //confirm pop up
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: const Text(
          "You didn/'t add to cart. Proceed to exit?",
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
                  Navigator.pop(context);
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
  } //--------------------------------------------------------------------------

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

  void toPop() {
    if (q == 0) {
      Navigator.pop(context);
    } else {
      confirmPopUp(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        toPop();
      },
      child: Consumer<Shopping>(
        builder: (context, shopping, child) {
          return Scaffold(
            backgroundColor: const Color(0xffd1a271),
            appBar: AppBar(
              backgroundColor: const Color(0xffd1a271),
              leading: Opacity(
                opacity: 0.6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () {
                        toPop();
                      }),
                ),
              ),
            ),
            body: Container(
              decoration: logo.showLogo(),
              child: Column(
                children: [
                  //product image
                  SizedBox(
                    height: 150,
                    width: 150,
                    //if url does not exist display default image
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 4,
                        ),
                      ),
                      child: src == "" ? obj2.showImage(defItem) : obj2.showImage(src),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(height: 2, color: Colors.black),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffc1ff72).withValues(alpha: 0.5),
                    ),
                    padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 210,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.prod!.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),

                              //product price
                              Text(
                                'RM' + widget.prod!.price.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 10),

                              //product description
                              Text(
                                widget.prod!.description,
                                style: const TextStyle(fontStyle: FontStyle.italic),
                              ),

                              const SizedBox(height: 10),

                              //product available quantity
                              Text("Available Product: " + widget.prod!.quantity.toString()),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              //increment or decrement for quantity
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //decrease button
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (q == 0) {
                                          q = 0;
                                        } else {
                                          q--;
                                        }
                                      });
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),

                                  //quantity counter
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    width: 20,
                                    child: Center(
                                      child: Text(
                                        q.toString(),
                                      ),
                                    ),
                                  ),

                                  //increase button
                                  GestureDetector(
                                    onTap: () {
                                      if (!(q + shopping.getQuantity(widget.prod) == widget.prod!.quantity)) {
                                        setState(() {
                                          q++;
                                        });
                                      } else {
                                        blockButton();
                                      }
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('Currently in cart: ' + shopping.getQuantity(widget.prod).toString()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(height: 2, color: Colors.black),

                  const Spacer(),

                  //button -> add to cart
                  MyMenuButton(
                    text: "Add to cart",
                    icon: Icons.add_shopping_cart_rounded,
                    onPressed: q == 0 ? () {} : () => addToCart(widget.prod, q),
                    size: 0,
                  ),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
