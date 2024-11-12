import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_textfield.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/services/auth/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class EditProdPage extends StatefulWidget {
  final Bakeds? prod;
  final String category;
  final bool isSaved;

  const EditProdPage({
    super.key,
    required this.prod,
    required this.category,
    required this.isSaved,
  });

  @override
  State<EditProdPage> createState() => _EditProdPageState();
}

class _EditProdPageState extends State<EditProdPage> {
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
  late String src;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    descController = TextEditingController();
    nameController = TextEditingController();
    priceController = TextEditingController();
    downloadUrl();
    changedData();
  }

  @override
  void dispose() {
    super.dispose();
    descController.dispose();
    nameController.dispose();
    priceController.dispose();
  }

  //get Url of product image so it can be displayed------------------------------------------
  void downloadUrl() async {
    var path = widget.prod!.imagePath;
    try {
      await FirebaseStorage.instance
          .ref()
          .child(path)
          .getDownloadURL()
          .then((String url) {
        setState(() {
          src = url;
          isLoading = false;
        });
      });
    } on FirebaseException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            "Product image does not exist",
            style: TextStyle(color: Colors.grey.shade400),
            textAlign: TextAlign.center,
          ),
        ),
      );
      setState(() {
        src = "";
        isLoading = false;
      });
    }
  } //Url of product image so it can be displayed------------------------------------------

  //kalau ada changed data-------------------------
  void changedData() {
    !widget.isSaved
        ? null
        : ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black,
              content: Text(
                "Data saved",
                style: TextStyle(color: Colors.grey.shade400),
                textAlign: TextAlign.center,
              ),
            ),
          );
  } //kalau ada changed data------------------------

  //enable save kalau ada changes in textcontroller atau imej je--------------------------------
  bool isSaveEnabled() {
    return (nameController.text == '' &&
        descController.text == '' &&
        priceController.text == '' &&
        _image == null);
  }
  //enable save kalau ada changes in textcontroller atau imej je--------------------------------

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Scaffold(
            backgroundColor: const Color(0xffd1a271),
            appBar: AppBar(
              backgroundColor: const Color(0xffB67F5F),
              title: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Product '" + widget.prod!.name + "'",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
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
                width: MediaQuery.of(context)
                    .size
                    .width, //max width for current phone
                decoration: BoxDecoration(
                  color: const Color(0xffd1a271),
                  image: DecorationImage(
                    image: const AssetImage("lib/images/applogo.png"),
                    colorFilter: ColorFilter.mode(
                      const Color(0xffd1a271).withOpacity(0.2),
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
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),

                            const Text(
                              "Edit product information",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),

                            const SizedBox(height: 60),

                            //name of product
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Product Name",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            MyTextField(
                              controller: nameController,
                              caps: TextCapitalization.words,
                              inputType: TextInputType.text,
                              labelText: widget.prod!.name,
                              hintText: widget.prod!.name,
                              obscureText: false,
                              isEnabled: true,
                              isShowhint: true,
                            ),

                            const SizedBox(height: 30),

                            //description of category
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            MyTextField(
                              controller: descController,
                              caps: TextCapitalization.none,
                              inputType: TextInputType.text,
                              labelText: widget.prod!.description,
                              hintText: widget.prod!.description,
                              obscureText: false,
                              isEnabled: true,
                              isShowhint: true,
                            ),

                            const SizedBox(height: 30),

                            //price of category
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Price (RM)",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            MyTextField(
                              controller: priceController,
                              caps: TextCapitalization.none,
                              inputType: TextInputType.number,
                              labelText: widget.prod!.price.toStringAsFixed(2),
                              hintText: widget.prod!.price.toStringAsFixed(2),
                              obscureText: false,
                              isEnabled: true,
                              isShowhint: true,
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
                                  child: const Text('Change Product Image')),
                              onPressed: showOptions,
                            ),
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
                                    //kalau belum pick show current
                                    ? Image.network(
                                        src,
                                        fit: BoxFit.cover,
                                      )
                                    //kalau dah pick show chosen image
                                    : Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            //input file sendiri or use default image for now
                            const SizedBox(height: 30),

                            //confirm button
                            MaterialButton(
                              child: Container(
                                padding: const EdgeInsets.all(25),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                decoration: BoxDecoration(
                                  color: isSaveEnabled()
                                      ? Colors.grey.shade400
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: isSaveEnabled()
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.4)
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: isSaveEnabled()
                                  ? null
                                  : () async {
                                      //check blank
                                      if (nameController.text == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                                        //uppercase every first letter for each word
                                        List<String> words =
                                            nameController.text.split(" ");
                                        String capitalizedSentence = words
                                            .map((word) => upperCase(word))
                                            .join(" ");
                                        //fix price into 0.00 format
                                        String prodPrice =
                                            double.parse(priceController.text)
                                                .toStringAsFixed(2);
                                        User? user =
                                            AuthService().getCurrentUser();
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
                                            "name": capitalizedSentence,
                                            "price": prodPrice,
                                          });

                                          // loading circle-------------------------
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          );
                                          await Future.delayed(
                                              const Duration(seconds: 2), () {
                                            Navigator.pop(context);
                                            //pop loading circle---------

                                            //go back to menu page
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MenuPage(),
                                              ),
                                            );
                                          });
                                        } on FirebaseException {
                                          Navigator.pop(context);
                                          //pop loading circle when fail---------
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
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
                                    },
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
            ), /*Column(
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
            onPressed: () {
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
              Navigator.pop(context); //pop loading circle---------
            },
          ),
    
          const SizedBox(height: 25),
        ],
      ),*/
          );
  }
}
