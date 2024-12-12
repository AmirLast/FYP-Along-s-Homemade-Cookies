import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/components/my_textfield.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/pages/owner/updatemenu.dart';
import 'package:fyp/services/auth/auth_service.dart';

class EditCategoryPage extends StatefulWidget {
  final String category;

  const EditCategoryPage({
    super.key,
    required this.category,
  });

  @override
  State<EditCategoryPage> createState() => _EditProdPageState();
}

class _EditProdPageState extends State<EditCategoryPage> {
  final Logo show = Logo(); //for logo
  //text editing controller
  late TextEditingController nameController;
  late String nameHT;
  List<Bakeds?> menus = [];
  final obj = UpdateMenuData();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    inithinttext(widget.category);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  //to initialize hint text--------
  inithinttext(String name) {
    nameHT = name;
  }
  //to initialize hint text--------

  //uppercase first letter-----------------------------------------
  String upperCase(String toEdit) {
    return toEdit[0].toUpperCase() + toEdit.substring(1).toLowerCase();
  }

  //uppercase first letter-----------------------------------------

  //kalau ada changed data-------------------------
  void changedData(isSaved) {
    !isSaved
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        if (nameController.text == '') {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(builder: (BuildContext context) => const MenuPage()),
            ModalRoute.withName('/MenuPage'),
          );
        } else {
          confirmPopUp(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffd1a271),
        appBar: AppBar(
          backgroundColor: const Color(0xffB67F5F),
          title: Center(
            child: Text(
              textAlign: TextAlign.center,
              "Category '" + widget.category + "'",
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
            width: MediaQuery.of(context).size.width, //max width for current phone
            decoration: show.showLogo(),
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
                          "Edit category name",
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
                            "Category Name",
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

                        //save button
                        MaterialButton(
                            child: Container(
                              padding: const EdgeInsets.all(25),
                              margin: const EdgeInsets.symmetric(horizontal: 25),
                              decoration: BoxDecoration(
                                color: nameController.text == '' ? Colors.grey.shade400 : Colors.black,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: nameController.text == '' ? Colors.black.withOpacity(0.4) : Colors.grey.shade400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: nameController.text == ''
                                ? null
                                : () async {
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
                                                        String capitalizedSentence;
                                                        List<String> words;
                                                        //set name
                                                        words = nameController.text.split(" ");
                                                        capitalizedSentence = words.map((word) => upperCase(word)).join(" ");

                                                        User? user = AuthService().getCurrentUser();

                                                        //cane nak cek category tu dah ade sama nama ke???

                                                        try {
                                                          // loading circle-------------------------
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return const Center(
                                                                child: CircularProgressIndicator(color: Color(0xffB67F5F)),
                                                              );
                                                            },
                                                          );

                                                          //get list of products in this category
                                                          await obj.updatemenudata(widget.category).then((temp) {
                                                            menus = temp;
                                                            int i = 0;
                                                            int j = menus.length;
                                                            for (i; i < j; i++) {
                                                              //tambah prod dalam collection categories baru kat FBFS
                                                              FirebaseFirestore.instance
                                                                  .collection('users')
                                                                  .doc(user?.uid)
                                                                  .collection(capitalizedSentence)
                                                                  .add({
                                                                "description": menus[i]?.description,
                                                                "url": menus[i]?.url,
                                                                "name": menus[i]?.name,
                                                                "price": menus[i]?.price.toStringAsFixed(2),
                                                              });
                                                              //delete prod dalam collection categories lama kat FBFS
                                                              FirebaseFirestore.instance
                                                                  .collection('users')
                                                                  .doc(user?.uid)
                                                                  .collection(widget.category)
                                                                  .where("name", isEqualTo: menus[i]?.name)
                                                                  .get()
                                                                  .then(
                                                                (querySnapshot) {
                                                                  for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
                                                                    documentSnapshot.reference.delete();
                                                                  }
                                                                },
                                                              );
                                                            }
                                                          });

                                                          //update local userclass data (+ new category)
                                                          UserNow.usernow!.categories.add(capitalizedSentence);
                                                          UserNow.usernow!.categories.remove(widget.category);
                                                          //map userclass data pasal categories
                                                          List newArray = UserNow.usernow!.categories;
                                                          //update array categories (xde prod) data kat FBFS
                                                          FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
                                                            "categories": newArray,
                                                          });

                                                          await Future.delayed(const Duration(seconds: 2), () {
                                                            Navigator.pop(context);
                                                            //pop loading circle---------
                                                            Navigator.pop(context);
                                                            //pop save changes dialogue
                                                            changedData(true);
                                                            setState(() {
                                                              inithinttext(capitalizedSentence);
                                                              nameController = TextEditingController();
                                                            });
                                                          });
                                                        } catch (e) {
                                                          Navigator.pop(context);
                                                          //pop loading circle when fail---------
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              backgroundColor: Colors.black,
                                                              content: Text(
                                                                "Fail saving",
                                                                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          );
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
                                            ));
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
      ),
    );
  }
}
