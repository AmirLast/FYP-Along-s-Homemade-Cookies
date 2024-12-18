import 'package:flutter/material.dart';
import 'package:fyp/components/my_menubutton.dart';
import 'package:fyp/models/bakedclass.dart';

class ProdPage extends StatefulWidget {
  final Bakeds? prod;
  final String category;

  const ProdPage({
    super.key,
    required this.prod,
    required this.category,
  });

  @override
  State<ProdPage> createState() => _EditProdPageState();
}

class _EditProdPageState extends State<ProdPage> {
  //to access this page from previous widget
  //=> Navigator.push, //pergi prod page cam kat mitch
  //alter part: nak refresh kat mana? lepas update/delete
  //access data guna categoryMenu[index] as key different
  //method to add to cart
  void addToCart(Bakeds? prod) {
    // close current prod page
    Navigator.pop(context);

    //add to cart
    //context.read<Shop>().addToCart(prod);
  }

  late String src;

  @override
  void initState() {
    super.initState();
    src = widget.prod!.url;
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
              SizedBox(
                  height: 150,
                  width: 150,
                  //if url does not exist display default image
                  child: src == ""
                      ? Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/fyp-along-shomemadecookies.appspot.com/o/default_item.png?alt=media&token=a6c87415-83da-4936-81dc-249ac4d89637")
                      : Image.network(src)),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
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
                        'RM' + widget.prod!.price.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 10),

                      //product description
                      Text(widget.prod!.description),

                      const SizedBox(height: 10),
                      Divider(color: Colors.grey.shade400),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              //button -> add to cart
              MyMenuButton(
                text: "Add to cart",
                icon: Icons.add_shopping_cart_rounded,
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
      ],
    );
  }
}
