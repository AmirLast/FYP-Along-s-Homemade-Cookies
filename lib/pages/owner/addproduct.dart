import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_textfield.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/services/auth/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final String category;
  const AddProduct({super.key, required this.category});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  //uppercase first letter-----------------------------------------
  String upperCase(String toEdit) {
    return toEdit[0].toUpperCase() + toEdit.substring(1).toLowerCase();
  }

  //uppercase first letter-----------------------------------------
  //untuk bahagian upload image-----------------------------------------------------
  File? _image;
  final picker = ImagePicker();

//Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
  //bahagian upload imej-----------------------------------------------------------------------

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
            widget.category + "'s Product",
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
                        labelText: "Price (RM)",
                        hintText: "1.00",
                        obscureText: false,
                        isEnabled: true,
                      ),

                      const SizedBox(height: 30),

                      //image of category
                      MaterialButton(
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text('Select Product Image')),
                        onPressed: showOptions,
                      ),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: _image == null
                            ? Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/fyp-along-shomemadecookies.appspot.com/o/default_item.png?alt=media&token=a6c87415-83da-4936-81dc-249ac4d89637")
                            : Image.file(_image!),
                      ),
                      //input file sendiri or use default image for now
                      const SizedBox(height: 30),

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
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Text(
                                    "Product name is blank",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              return;
                            } else if (descController.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Text(
                                    "Description is blank",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              return;
                            } else if (priceController.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Text(
                                    "Price is blank",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              return;
                            } else if (_image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Text(
                                    "Picture not selected",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              return;
                            } else {
                              //fix price into 0.00 format
                              String prodPrice =
                                  double.parse(priceController.text)
                                      .toStringAsFixed(2);
                              User? user = AuthService().getCurrentUser();
                              //set file path for current user folder in firebase storage
                              String path =
                                  '${user?.uid}/${widget.category}/${nameController.text}';
                              //cane nak cek product tu dah ade sama nama ke???

                              try {
                                //upload gambar dalam firebase storage
                                FirebaseStorage.instance
                                    .ref()
                                    .child(path)
                                    .putFile(_image!);
                                //update prod dalam collection categories kat FBFS
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user?.uid)
                                    .collection(widget.category)
                                    .add({
                                  "description": descController.text,
                                  "imagePath": path,
                                  "name": upperCase(nameController.text),
                                  "price": prodPrice,
                                });

                                // loading circle-------------------------
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                );
                                Future.delayed(const Duration(seconds: 2));
                                Navigator.pop(
                                    context); //pop loading circle---------

                                //go back to menu page
                                Navigator.pop(context);
                                Navigator.pop(context);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MenuPage(),
                                  ),
                                );
                              } on FirebaseException {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.black,
                                    content: Text(
                                      "Fail uploading",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                            }
                          }),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
