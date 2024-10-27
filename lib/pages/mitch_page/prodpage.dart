import 'package:flutter/material.dart';
import 'package:fyp/components/my_menubutton.dart';
import 'package:fyp/models/baked.dart';
import 'package:fyp/models/shop.dart';
import 'package:provider/provider.dart';

class ProdPage extends StatefulWidget {
  final Baked prod;

  const ProdPage({
    super.key,
    required this.prod,
  });

  @override
  State<ProdPage> createState() => _ProdPageState();
}

class _ProdPageState extends State<ProdPage> {
  //method to add to cart
  void addToCart(Baked prod) {
    // close current prod page
    Navigator.pop(context);

    //add to cart
    context.read<Shop>().addToCart(prod);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //scaffold UI
        Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              //product image
              Image.asset(widget.prod.imagePath),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //product name
                      Text(
                        widget.prod.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      //product price
                      Text(
                        'RM' + widget.prod.price.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      //product description
                      Text(widget.prod.description),

                      const SizedBox(height: 10),
                      Divider(color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              //button -> add to cart
              MyMenuButton(
                text: "Add to cart",
                onPressed: () => addToCart(
                  widget.prod,
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),

        //back button
        SafeArea(
          child: Opacity(
            opacity: 0.6,
            child: Container(
              margin: const EdgeInsets.only(left: 25),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
