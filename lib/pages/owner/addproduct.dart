import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_textfield.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/services/auth/auth_service.dart';

class AddProduct extends StatefulWidget {
  final String prod;
  const AddProduct({super.key, required this.prod});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  //text editing controller
  late TextEditingController descController;
  late TextEditingController nameController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    descController = TextEditingController();
    nameController = TextEditingController();
    priceController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    descController.dispose();
    nameController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Center(
          child: Text(
            textAlign: TextAlign.center,
            widget.prod + "'s Product",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width:
              MediaQuery.of(context).size.width, //max width for current phone
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            image: DecorationImage(
              image: const AssetImage("lib/images/applogo.png"),
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.surface.withOpacity(0.2),
                BlendMode.dstATop,
              ),
              alignment: Alignment.center,
              scale: 0.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      Text(
                        "Fill in the information",
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 60),

                      //name of product
                      MyTextField(
                        controller: nameController,
                        caps: TextCapitalization.words,
                        inputType: TextInputType.text,
                        labelText: "Product Name",
                        hintText: "",
                        obscureText: false,
                        isEnabled: true,
                      ),

                      const SizedBox(height: 30),

                      //description of category
                      MyTextField(
                        controller: descController,
                        caps: TextCapitalization.none,
                        inputType: TextInputType.text,
                        labelText: "Description",
                        hintText: "",
                        obscureText: false,
                        isEnabled: true,
                      ),

                      const SizedBox(height: 30),

                      //price of category
                      MyTextField(
                        controller: priceController,
                        caps: TextCapitalization.none,
                        inputType: TextInputType.number,
                        labelText: "Price",
                        hintText: "RM 1.00",
                        obscureText: false,
                        isEnabled: true,
                      ),

                      const SizedBox(height: 30),

                      //image of category
                      //input file sendiri or use default image for now
                      //const SizedBox(height: 30),

                      //confirm button
                      MaterialButton(
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            //check blank
                            if (nameController.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Product name is blank",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              return;
                            } else if (descController.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Description is blank",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              return;
                            } else if (priceController.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Price is blank",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              return;
                            } else {
                              User? user = AuthService().getCurrentUser();
                              //cane nak cek product tu dah ade sama nama ke???
                              //update prod dalam collection categories kat FBFS
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user?.uid)
                                  .collection(widget.prod)
                                  .add({
                                "description": descController.text,
                                "imagePath":
                                    "gs://fyp-along-shomemadecookies.appspot.com/default_user.png", //pakai default dulu
                                "name": nameController.text,
                                "price": priceController.text,
                              });
                              //new collection is automatically create when add product :D
                              //go back to menu page
                              Navigator.pop(context);
                              Navigator.pop(context);
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MenuPage(),
                                ),
                              );
                            }
                          }),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
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

*/