import 'package:flutter/material.dart';
import 'package:fyp/components/my_button.dart';
import 'package:fyp/models/baked.dart';
import 'package:fyp/models/shop.dart';
import 'package:provider/provider.dart';

class ProdPage extends StatefulWidget {
  final Baked prod;
  final Map<Addon, bool> selectedAddons = {};

  ProdPage({
    super.key,
    required this.prod,
  }) {
    //initialize selected addons as false
    for (Addon addon in prod.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<ProdPage> createState() => _ProdPageState();
}

class _ProdPageState extends State<ProdPage> {
  //method to add to cart
  void addToCart(Baked prod, Map<Addon, bool> selectedAddons) {
    // close current prod page
    Navigator.pop(context);

    //format the selected addons
    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.prod.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }
    //add to cart
    context.read<Shop>().addToCart(prod, currentlySelectedAddons);
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

                      //addons
                      Text(
                        "Add-ons",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: widget.prod.availableAddons.length,
                          itemBuilder: (context, index) {
                            //get each add ons
                            Addon addon = widget.prod.availableAddons[index];

                            //return check box UI
                            return CheckboxListTile(
                              title: Text(addon.name),
                              subtitle: Text(
                                'RM' + addon.price.toString(),
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              value: widget.selectedAddons[addon],
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.selectedAddons[addon] = value!;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //button -> add to cart
              MyButton(
                text: "Add to cart",
                onTap: () => addToCart(
                  widget.prod,
                  widget.selectedAddons,
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
