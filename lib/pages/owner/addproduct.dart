import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/components/my_scaffoldmessage.dart';
import 'package:fyp/components/my_textfield.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/pages/all_user/functions/updateurl.dart';
import 'package:fyp/pages/owner/editproduct.dart';
import 'package:fyp/pages/owner/functions/updatemenu.dart';
import 'package:fyp/services/auth/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final String category;
  const AddProduct({super.key, required this.category});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final MyScaffoldmessage scaffoldOBJ = MyScaffoldmessage(); //for scaffold message
  final DownloadURL obj = DownloadURL(); //for url
  final Logo show = Logo(); //for logo
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
            child: const Text(
              'Photo Gallery',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Camera',
              style: TextStyle(color: Colors.black),
            ),
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
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    descController = TextEditingController();
    nameController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    descController.dispose();
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1a271),
      appBar: AppBar(
        backgroundColor: const Color(0xffB67F5F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      body: Container(
        width: MediaQuery.of(context).size.width, //max width for current phone
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
        decoration: show.showLogo(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      const Text(
                        "Fill in the information",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
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
                        isShowhint: false,
                      ),

                      const SizedBox(height: 30),

                      //description of product
                      MyTextField(
                        controller: descController,
                        caps: TextCapitalization.none,
                        inputType: TextInputType.text,
                        labelText: "Description",
                        hintText: "",
                        obscureText: false,
                        isEnabled: true,
                        isShowhint: false,
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
                        isShowhint: false,
                      ),

                      const SizedBox(height: 30),

                      //quantity of ready stock
                      MyTextField(
                        controller: quantityController,
                        caps: TextCapitalization.none,
                        inputType: TextInputType.number,
                        labelText: "Ready Stock Quantity",
                        hintText: "",
                        obscureText: false,
                        isEnabled: true,
                        isShowhint: false,
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

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                          ),
                          child: _image == null
                              ? Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/fyp-along-shomemadecookies.appspot.com/o/default_item.png?alt=media&token=a6c87415-83da-4936-81dc-249ac4d89637",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      //input file sendiri or use default image for now
                      const SizedBox(height: 30),

                      //confirm button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                //check blank
                                if (nameController.text == '') {
                                  scaffoldOBJ.scaffoldmessage("Product name is blank", context);
                                } else if (descController.text == '') {
                                  scaffoldOBJ.scaffoldmessage("Description is blank", context);
                                } else if (priceController.text == '') {
                                  scaffoldOBJ.scaffoldmessage("Price is blank", context);
                                } else if (_image == null) {
                                  scaffoldOBJ.scaffoldmessage("Picture not selected", context);
                                } else if (quantityController.text == '' || int.parse(quantityController.text.trim()) <= 0) {
                                  scaffoldOBJ.scaffoldmessage("Quantity is wrong", context);
                                } else {
                                  //uppercase every first letter for each word
                                  List<String> words = nameController.text.trim().split(" ");
                                  String capitalizedSentence = words.map((word) => upperCase(word)).join(" ");
                                  //for checking product name
                                  UpdateMenuData objProd = UpdateMenuData();
                                  List<Bakeds?> checkProduct = [];
                                  //fix price into 0.00 format
                                  String prodPrice = double.parse(priceController.text.trim()).toStringAsFixed(2);
                                  User? user = AuthService().getCurrentUser();
                                  //set file path for current user folder in firebase storage
                                  String path = "";
                                  CollectionReference dir =
                                      FirebaseFirestore.instance.collection('users').doc(user!.uid).collection(widget.category);

                                  //cek product dah ade sama nama ke tak
                                  await objProd.updatemenudata("").then((onValue) async {
                                    checkProduct = onValue;
                                    if (checkProduct.where((test) => test!.name == capitalizedSentence).isNotEmpty) {
                                      scaffoldOBJ.scaffoldmessage("Product '" + nameController.text + "' already exist", context);
                                      return; //exit code bracket
                                    } else {
                                      // loading circle-------------------------
                                      showDialog(
                                        barrierDismissible: false, //prevent outside click
                                        context: context,
                                        builder: (context) {
                                          return PopScope(
                                            //prevent back button
                                            canPop: false,
                                            onPopInvokedWithResult: (didPop, result) async {
                                              if (didPop) {
                                                return;
                                              }
                                            },
                                            child: const Center(
                                              child: CircularProgressIndicator(color: Color(0xffB67F5F)),
                                            ),
                                          );
                                        },
                                      ); //----------------------------------------
                                      try {
                                        //prepare prod to be pushed into edit page
                                        Bakeds newProd = Bakeds(
                                          quantity: int.parse(quantityController.text.trim()),
                                          name: capitalizedSentence,
                                          description: descController.text.trim(),
                                          url: "",
                                          imagePath: "",
                                          price: double.parse(priceController.text.trim()),
                                          category: widget.category,
                                        );

                                        //add prod dalam collection categories kat FBFS so can get random id for product
                                        await dir.add({
                                          "quantity": int.parse(quantityController.text.trim()),
                                          "description": descController.text.trim(),
                                          "url": "",
                                          "imagePath": "",
                                          "name": capitalizedSentence,
                                          "price": prodPrice,
                                        }).then((onValue) async {
                                          //get prod id
                                          await dir.where("name", isEqualTo: capitalizedSentence).get().then((onValue) async {
                                            for (var docSnapshot in onValue.docs) {
                                              //use prod id as path for image in storage
                                              path = "${user.uid}/${docSnapshot.id}";
                                              newProd.imagePath = path;
                                              //upload gambar dalam firebase storage
                                              await FirebaseStorage.instance.ref().child(path).putFile(_image!).then((onValue) async {
                                                await obj.downloadUrl(path, context).then((url) async {
                                                  //get url for uploaded image for easy use
                                                  newProd.url = url;
                                                  await dir.doc(docSnapshot.id).update({
                                                    //update remaining data
                                                    "url": url,
                                                    "imagePath": path,
                                                  }).then((onValue) {
                                                    scaffoldOBJ.scaffoldmessage("Product Added", context);
                                                    Navigator.pop(context);
                                                    //pop loading circle
                                                    Navigator.pop(context);
                                                    //pop add product page
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => EditProdPage(prod: newProd, category: widget.category),
                                                      ),
                                                    );
                                                  });
                                                });
                                              });
                                            }
                                          });
                                        });
                                      } on FirebaseException {
                                        Navigator.pop(context);
                                        //pop loading circle if fail---------
                                        scaffoldOBJ.scaffoldmessage("Fail uploading", context);
                                      }
                                    }
                                  });
                                }
                              }),
                        ],
                      ),

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
