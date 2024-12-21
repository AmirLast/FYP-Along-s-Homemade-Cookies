import 'package:flutter/material.dart';
import 'package:fyp/components/my_cachednetworkimage.dart';
import 'package:fyp/components/my_menubutton.dart';
import 'package:fyp/components/my_quantityselector.dart';
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
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Column(
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
              )),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //product name
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
                    Text("Available Product: " + widget.prod!.quantity.toString()),

                    const SizedBox(height: 10),
                    const Divider(color: Colors.black),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(width: 15),
                QuantitySelector(
                  quantity: 0,
                  onDec: () {},
                  onInc: () {},
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('Currently in cart: 0'),
                ),
              ],
            ),
          ),

          //button -> add to cart
          MyMenuButton(
            text: "Add to cart",
            icon: Icons.add_shopping_cart_rounded,
            onPressed: () {},
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
