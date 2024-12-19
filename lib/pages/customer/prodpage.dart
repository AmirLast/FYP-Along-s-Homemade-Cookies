import 'package:flutter/material.dart';
import 'package:fyp/components/my_menubutton.dart';
//import 'package:fyp/components/my_quantityselector.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/cartitem.dart';
import 'package:fyp/models/shop.dart';
import 'package:provider/provider.dart';

class ProdPage extends StatefulWidget {
  final Bakeds? prod;
  const ProdPage({super.key, required this.prod});

  @override
  State<ProdPage> createState() => _EditProdPageState();
}

class _EditProdPageState extends State<ProdPage> {
  //method to add to cart
  void addToCart(Bakeds? prod) {
    // close current prod page
    Navigator.pop(context);

    Bakeds prod2 = prod!;

    //add to cart
    context.read<Shop>().addToCart(prod2);
  }

  late String src;
  late CartItem cartItem = CartItem(prod: widget.prod);

  @override
  void initState() {
    super.initState();
    src = widget.prod!.url;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, shop, child) {
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
                    child: src == ""
                        ? Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/fyp-along-shomemadecookies.appspot.com/o/default_item.png?alt=media&token=a6c87415-83da-4936-81dc-249ac4d89637",
                            fit: BoxFit.fill)
                        : Image.network(src, fit: BoxFit.fill),
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
                        Text(widget.prod!.description),

                        const SizedBox(height: 10),

                        //product available quantity
                        Text("Available Product: " + widget.prod!.quantity.toString()),

                        const SizedBox(height: 10),
                        const Divider(color: Colors.black),
                        const SizedBox(height: 10),
                      ],
                    ),
                    const SizedBox(width: 15),

                    //increment or decrement for quantity
                    // QuantitySelector(
                    //     quantity: cartItem.quantity,
                    //     onDec: () {
                    //       setState(() {
                    //         shop.removeFromCart(cartItem);
                    //       });
                    //     },
                    //     onInc: () {
                    //       setState(() {
                    //         shop.addToCart(cartItem.prod);
                    //       });
                    //     }),
                  ],
                ),
              ),

              //button -> add to cart
              MyMenuButton(
                text: "Add to cart",
                icon: Icons.add_shopping_cart_rounded,
                onPressed: () => addToCart(
                  cartItem.prod,
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}
