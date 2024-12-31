import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_cachednetworkimage.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_menubutton.dart';
import 'package:fyp/models/bakedclass.dart';

class PreviewProdPage extends StatefulWidget {
  final Bakeds? prod;
  final String src;
  final String name;
  final String desc;
  final String price;
  final int quantity;

  const PreviewProdPage({
    super.key,
    required this.prod,
    required this.src,
    required this.name,
    required this.desc,
    required this.price,
    required this.quantity,
  });

  @override
  State<PreviewProdPage> createState() => _PreviewProdPageState();
}

class _PreviewProdPageState extends State<PreviewProdPage> {
  final obj = MyCachednetworkimage();
  final logo = Logo();
  @override
  Widget build(BuildContext context) {
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
                  Navigator.pop(context);
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
                child: obj.showImage(widget.src),
              ),
            ),

            const SizedBox(height: 30),

            Container(height: 2, color: Colors.black),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffc1ff72).withValues(alpha: 0.5),
              ),
              child: Padding(
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
                            widget.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          //product price
                          Text(
                            'RM' + widget.price,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 10),

                          //product description
                          Text(
                            widget.desc,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),

                          const SizedBox(height: 10),

                          //product available quantity
                          Text("Available Product: " + widget.quantity.toString()),
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
                                onTap: () {},
                                child: const Icon(
                                  Icons.remove,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),

                              //quantity counter
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: SizedBox(
                                  width: 20,
                                  child: Center(
                                    child: Text(
                                      "0",
                                    ),
                                  ),
                                ),
                              ),

                              //increase button
                              GestureDetector(
                                onTap: () {},
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
                          child: Text('Currently in cart: ' + widget.quantity.toString()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 2, color: Colors.black),

            const Spacer(),

            //button -> add to cart
            MyMenuButton(
              text: "Add to cart",
              icon: Icons.add_shopping_cart_rounded,
              size: 0,
              onPressed: () {},
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
