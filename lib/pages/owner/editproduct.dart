import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_menubutton.dart';
import 'package:fyp/models/bakedclass.dart';
//import 'package:fyp/models/shop.dart';

class EditProdPage extends StatefulWidget {
  final Bakeds? prod;
  final String category;

  const EditProdPage({
    super.key,
    required this.prod,
    required this.category,
  });

  @override
  State<EditProdPage> createState() => _EditProdPageState();
}

class _EditProdPageState extends State<EditProdPage> {
  //method to add to cart
  /*void addToCart(Bakeds prod) {
    // close current prod page
    Navigator.pop(context);

    //add to cart
    context.read<Shop>().addToCart(prod);
  }*/
  late String src;

  @override
  void initState() async {
    super.initState();
    //getting image of product
    var path = widget.prod!.imagePath;
    try {
      src = await FirebaseStorage.instance.ref().child(path).getDownloadURL();
    } on FirebaseException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Product image does not exist",
            textAlign: TextAlign.center,
          ),
        ),
      );
      src = ""; //set src as blank if product image does not exist
    }
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      //product description
                      Text(widget.prod!.description),

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
                onPressed:
                    () {}, /*=> addToCart(
                  widget.prod,
                ),*/
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
