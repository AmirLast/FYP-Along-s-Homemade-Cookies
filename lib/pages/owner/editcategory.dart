import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/components/my_scaffoldmessage.dart';
import 'package:fyp/components/my_textfield.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/pages/owner/functions/updatemenu.dart';
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
  final MyScaffoldmessage scaffoldOBJ = MyScaffoldmessage(); //for scaffold message
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
              if (nameController.text == '') {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                decoration: BoxDecoration(
                                  color: nameController.text == '' ? Colors.grey.shade400 : Colors.black,
                                  borderRadius: BorderRadius.circular(40),
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
                                      late List<String> words;
                                      late String capitalizedSentence;
                                      if (nameController.text != "") {
                                        //uppercase every first letter for each word
                                        words = nameController.text.trim().split(" ");
                                        capitalizedSentence = words.map((word) => upperCase(word)).join(" ");
                                      }

                                      if (UserNow.usernow!.categories.contains(capitalizedSentence)) {
                                        //check categories exist in current data
                                        scaffoldOBJ.scaffoldmessage("Category '" + nameController.text + "' already exist", context);
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
                                                      User? user = AuthService().getCurrentUser();

                                                      try {
                                                        // loading circle-------------------------
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return PopScope(
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
                                                        ); //-------------------------------------

                                                        //get list of products in this category
                                                        await obj.updatemenudata(widget.category).then((temp) async {
                                                          menus = temp;
                                                          int i = 0;
                                                          int j = menus.length;
                                                          for (i; i < j; i++) {
                                                            //tambah prod dalam collection categories baru kat FBFS
                                                            await FirebaseFirestore.instance
                                                                .collection('users')
                                                                .doc(user?.uid)
                                                                .collection(capitalizedSentence)
                                                                .add({
                                                              "imagePath": menus[i]?.imagePath,
                                                              "description": menus[i]?.description,
                                                              "url": menus[i]?.url,
                                                              "name": menus[i]?.name,
                                                              "price": menus[i]?.price.toStringAsFixed(2),
                                                              "quantity": menus[i]?.quantity,
                                                            });
                                                            //delete prod dalam collection categories lama kat FBFS
                                                            await FirebaseFirestore.instance
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
                                                        }).then((onValue) async {
                                                          //update local userclass data (+ new category)
                                                          UserNow.usernow!.categories.add(capitalizedSentence);
                                                          UserNow.usernow!.categories.remove(widget.category);

                                                          //map userclass data pasal categories
                                                          List newArray = UserNow.usernow!.categories;
                                                          //update array categories data kat FBFS
                                                          await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
                                                            "categories": newArray,
                                                          }).then((onValue) {
                                                            scaffoldOBJ.scaffoldmessage("Data Saved", context);
                                                            Navigator.pop(context);
                                                            //pop loading circle---------
                                                            Navigator.pop(context);
                                                            //pop save changes dialogue
                                                            setState(() {
                                                              inithinttext(capitalizedSentence);
                                                              nameController = TextEditingController();
                                                            });
                                                          });
                                                        });
                                                      } catch (e) {
                                                        Navigator.pop(context);
                                                        //pop loading circle when fail---------
                                                        scaffoldOBJ.scaffoldmessage("Fail saving", context);
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
      ),
    );
  }
}
