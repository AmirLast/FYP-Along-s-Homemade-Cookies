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
import 'package:fyp/pages/owner/functions/updatemenu.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/services/auth/auth_service.dart';
import 'package:image_picker/image_picker.dart';

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
  final MyScaffoldmessage scaffoldOBJ = MyScaffoldmessage(); //for scaffold message
  final Logo show = Logo(); //for logo
  final DownloadURL obj = DownloadURL(); //for url
  final String useruid = AuthService().getCurrentUser()!.uid;
  //text editing controller
  late TextEditingController descController;
  late TextEditingController nameController;
  late TextEditingController priceController;
  late String src;
  late String nameHT;
  late String descHT;
  late String priceHT;

  @override
  void initState() {
    super.initState();
    descController = TextEditingController();
    nameController = TextEditingController();
    priceController = TextEditingController();
    inithinttext(widget.prod!.name, widget.prod!.description, widget.prod!.price.toStringAsFixed(2));
    src = widget.prod!.url;
  }

  @override
  void dispose() {
    super.dispose();
    descController.dispose();
    nameController.dispose();
    priceController.dispose();
  }

  //to initialize hint text--------
  inithinttext(String name, String desc, String price) {
    nameHT = name;
    descHT = desc;
    priceHT = price;
  }
  //to initialize hint text--------

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
  //bahagian upload imej------------------------------------------------------------

  //kalau ada changed data-------------------------
  void changedData() {
    scaffoldOBJ.scaffoldmessage("Data saved", context);
  } //kalau ada changed data------------------------

  //enable save kalau ada changes in textcontroller atau imej je--------------------------------
  bool isSaveEnabled() {
    return (nameController.text == '' && descController.text == '' && priceController.text == '' && _image == null);
  }
  //--------------------------------------------------------------------------------------------

  //confirm pop up kalau ada unsaved data---------------------------------------
  confirmPopUp(context) {
    //confirm pop up
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: const Text(
          "Are you sure you want to exit? There is unsaved changes",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                iconSize: 50,
                color: Colors.green,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_circle),
              ),
              IconButton(
                  iconSize: 50,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel)),
            ],
          )
        ],
      ),
    );
  } //----------------------------------------------------------------------

  late String docID, imagePath;
  //fix any default pic-----------------------------------------------------
  void fixCorner(String useruid, String capitalizedSentence, String prodPrice) async {
    //get to the exact document
    await FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .collection(widget.category)
        .where("name", isEqualTo: widget.prod!.name)
        .get()
        .then((querySnapshot) async {
      for (var docSnapshot in querySnapshot.docs) {
        docID = docSnapshot.id;
        imagePath = "$useruid/$docID";
        //get document id and set imagePath
        await FirebaseFirestore.instance
            .collection('users')
            .doc(useruid)
            .collection(widget.category)
            .doc(docID)
            .update({"imagePath": imagePath});
      }
    }).then((onValue) async {
      await FirebaseStorage.instance.ref().child(imagePath).delete();
      await FirebaseStorage.instance.ref().child(imagePath).putFile(_image!).then((onValue) async {
        //get file url
        await obj.downloadUrl(imagePath, context).then((url) async {
          src = url;
          //update prod dalam collection categories kat FBFS
          await FirebaseFirestore.instance.collection('users').doc(useruid).collection(widget.category).doc(docID).update({
            "description": descController.text == "" ? widget.prod!.description : descController.text,
            "url": src,
            "name": capitalizedSentence,
            "price": prodPrice,
          });
        }).then((onValue) {
          Navigator.pop(context);
          //pop loading circle---------
          Navigator.pop(context);
          //pop save changes dialogue
          changedData();
          setState(() {
            inithinttext(capitalizedSentence, descController.text == "" ? widget.prod!.description : descController.text, prodPrice);
            _image = null;
            descController = TextEditingController();
            nameController = TextEditingController();
            priceController = TextEditingController();
          });
        });
      });
    });
  }
  //------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        if (isSaveEnabled()) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MenuPage()));
        } else {
          confirmPopUp(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffd1a271),
        appBar: AppBar(
          backgroundColor: const Color(0xffB67F5F),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              if (isSaveEnabled()) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MenuPage()));
              } else {
                confirmPopUp(context);
              }
            },
          ),
          title: Center(
            child: Text(
              textAlign: TextAlign.center,
              "Product '" + widget.prod!.name + "'",
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
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        MyTextField(
                          controller: nameController,
                          caps: TextCapitalization.words,
                          inputType: TextInputType.text,
                          labelText: nameHT,
                          hintText: nameHT,
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
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        MyTextField(
                          controller: descController,
                          caps: TextCapitalization.none,
                          inputType: TextInputType.text,
                          labelText: descHT,
                          hintText: descHT,
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
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        MyTextField(
                          controller: priceController,
                          caps: TextCapitalization.none,
                          inputType: TextInputType.number,
                          labelText: priceHT,
                          hintText: priceHT,
                          obscureText: false,
                          isEnabled: true,
                          isShowhint: true,
                        ),

                        const SizedBox(height: 30),

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

                        const SizedBox(height: 20),

                        //image of category
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

                        const SizedBox(height: 20),

                        //button to remove picture chosen
                        MaterialButton(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _image == null ? Colors.grey.shade400 : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Remove Picture',
                              style: TextStyle(
                                color: _image == null ? Colors.black.withOpacity(0.4) : null,
                              ),
                            ),
                          ),
                          onPressed: _image == null
                              ? null
                              : () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                        ),

                        const SizedBox(height: 30),

                        //save button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                decoration: BoxDecoration(
                                  color: isSaveEnabled() ? Colors.grey.shade400 : Colors.black,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: isSaveEnabled() ? Colors.black.withOpacity(0.4) : Colors.grey.shade400,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: isSaveEnabled()
                                  ? null
                                  : () async {
                                      String capitalizedSentence;
                                      List<String> words;
                                      //set name
                                      nameController.text == ""
                                          ? capitalizedSentence = widget.prod!.name
                                          : {
                                              words = nameController.text.split(" "),
                                              capitalizedSentence = words.map((word) => upperCase(word)).join(" ")
                                            };
                                      UpdateMenuData objProd = UpdateMenuData();
                                      List<Bakeds?> checkProduct = [];
                                      await objProd.updatemenudata("").then(
                                        (onValue) async {
                                          checkProduct = onValue;
                                          //only check other product name if name input exist
                                          if (checkProduct.where((test) => test!.name == capitalizedSentence).isNotEmpty &&
                                              nameController.text != "") {
                                            scaffoldOBJ.scaffoldmessage("Product '" + nameController.text + "' already exist", context);
                                          } else {
                                            //showdialog confirm save
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                backgroundColor: Colors.white,
                                                content: const Text(
                                                  "Save changes?",
                                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                ),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      IconButton(
                                                        iconSize: 50,
                                                        color: Colors.green,
                                                        onPressed: () async {
                                                          //code here
                                                          String prodPrice;

                                                          //fix price into 0.00 format
                                                          priceController.text == ""
                                                              ? prodPrice = widget.prod!.price.toStringAsFixed(2)
                                                              : prodPrice = double.parse(priceController.text).toStringAsFixed(2);

                                                          User? user = AuthService().getCurrentUser();

                                                          try {
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
                                                            ); //--------------------------------------
                                                            //upload gambar dalam firebase storage
                                                            if (_image != null) {
                                                              if (src ==
                                                                  "https://firebasestorage.googleapis.com/v0/b/fyp-along-shomemadecookies.appspot.com/o/default_item.png?alt=media&token=a6c87415-83da-4936-81dc-249ac4d89637") {
                                                                fixCorner(useruid, capitalizedSentence, prodPrice);
                                                              } else {
                                                                await FirebaseStorage.instance.ref().child(widget.prod!.imagePath).delete();
                                                                await FirebaseStorage.instance
                                                                    .ref()
                                                                    .child(widget.prod!.imagePath)
                                                                    .putFile(_image!)
                                                                    .then((onValue) async {
                                                                  //get file url
                                                                  await obj.downloadUrl(widget.prod!.imagePath, context).then((url) {
                                                                    src = url;
                                                                    //update prod dalam collection categories kat FBFS
                                                                    FirebaseFirestore.instance
                                                                        .collection('users')
                                                                        .doc(user?.uid)
                                                                        .collection(widget.category)
                                                                        .where('name', isEqualTo: widget.prod!.name)
                                                                        .get()
                                                                        .then((querySnapshot) {
                                                                      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
                                                                        documentSnapshot.reference.update({
                                                                          "description": descController.text == ""
                                                                              ? widget.prod!.description
                                                                              : descController.text,
                                                                          "url": src,
                                                                          "name": capitalizedSentence,
                                                                          "price": prodPrice,
                                                                        });
                                                                      }
                                                                    });
                                                                  }).then((onValue) {
                                                                    Navigator.pop(context);
                                                                    //pop loading circle---------
                                                                    Navigator.pop(context);
                                                                    //pop save changes dialogue
                                                                    changedData();
                                                                    setState(() {
                                                                      inithinttext(
                                                                          capitalizedSentence,
                                                                          descController.text == ""
                                                                              ? widget.prod!.description
                                                                              : descController.text,
                                                                          prodPrice);
                                                                      _image = null;
                                                                      descController = TextEditingController();
                                                                      nameController = TextEditingController();
                                                                      priceController = TextEditingController();
                                                                    });
                                                                  });
                                                                });
                                                              }
                                                            } else {
                                                              //update prod dalam collection categories kat FBFS
                                                              await FirebaseFirestore.instance
                                                                  .collection('users')
                                                                  .doc(user?.uid)
                                                                  .collection(widget.category)
                                                                  .where('name', isEqualTo: widget.prod!.name)
                                                                  .get()
                                                                  .then((querySnapshot) {
                                                                for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
                                                                  documentSnapshot.reference.update({
                                                                    "description": descController.text == ""
                                                                        ? widget.prod!.description
                                                                        : descController.text,
                                                                    "url": src,
                                                                    "name": capitalizedSentence,
                                                                    "price": prodPrice,
                                                                  });
                                                                }
                                                              }).then((onValue) {
                                                                Navigator.pop(context);
                                                                //pop loading circle---------
                                                                Navigator.pop(context);
                                                                //pop save changes dialogue
                                                                changedData();
                                                                setState(() {
                                                                  inithinttext(
                                                                      capitalizedSentence,
                                                                      descController.text == ""
                                                                          ? widget.prod!.description
                                                                          : descController.text,
                                                                      prodPrice);
                                                                  _image = null;
                                                                  descController = TextEditingController();
                                                                  nameController = TextEditingController();
                                                                  priceController = TextEditingController();
                                                                });
                                                              });
                                                            }
                                                          } catch (e) {
                                                            Navigator.pop(context);
                                                            //pop loading circle when fail---------
                                                            scaffoldOBJ.scaffoldmessage("Fail uploading", context);
                                                          }
                                                        },
                                                        icon: const Icon(Icons.check_circle),
                                                      ),
                                                      IconButton(
                                                          iconSize: 50,
                                                          color: Colors.red,
                                                          onPressed: () => Navigator.pop(context),
                                                          icon: const Icon(Icons.cancel)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                            ),
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
        /* ini untuk display product
              Column(
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
                      child: CircularProgressIndicator(color: Color(0xffB67F5F)),
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
      ),
    );
  }
}
