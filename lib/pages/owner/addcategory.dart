import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/components/general/my_textfield.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/services/auth/auth_service.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final MyScaffoldmessage scaffoldOBJ = MyScaffoldmessage(); //for scaffold message
  final Logo show = Logo(); //for logo
  final load = Loading();
  //uppercase first letter-----------------------------------------
  String upperCase(String toEdit) {
    return toEdit[0].toUpperCase() + toEdit.substring(1).toLowerCase();
  }

  //uppercase first letter-----------------------------------------
  //text editing controller
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
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
        title: const Center(
          child: Text(
            textAlign: TextAlign.center,
            "Category",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 150),
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

                    //name of category
                    MyTextField(
                      maxLength: 0,
                      controller: nameController,
                      caps: TextCapitalization.words,
                      inputType: TextInputType.text,
                      labelText: "Name",
                      hintText: "",
                      obscureText: false,
                      isEnabled: true,
                      isShowhint: false,
                    ),

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
                            late List<String> words;
                            late String capitalizedSentence;
                            if (nameController.text != "") {
                              //uppercase every first letter for each word
                              words = nameController.text.trim().split(" ");
                              capitalizedSentence = words.map((word) => upperCase(word)).join(" ");
                            }

                            if (nameController.text == '') {
                              //check blank
                              scaffoldOBJ.scaffoldmessage("Category name is blank", context);
                            } else if (UserNow.usernow.categories.contains(capitalizedSentence)) {
                              //check categories exist in current data
                              scaffoldOBJ.scaffoldmessage("Category '" + nameController.text + "' already exist", context);
                            } else {
                              // loading circle-------------------------
                              load.loading(context);
                              //---------------------------------------

                              User? user = AuthService().getCurrentUser();
                              //update local userclass data (+ new category)
                              UserNow.usernow.categories.add(capitalizedSentence);
                              //map userclass data pasal categories
                              List newArray = UserNow.usernow.categories;
                              //update array categories (xde prod) data kat FBFS
                              FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
                                "categories": newArray,
                              });
                              //new collection is automatically create when add product :D

                              await Future.delayed(const Duration(seconds: 2), () {
                                scaffoldOBJ.scaffoldmessage("Category Added", context);
                                Navigator.pop(context);
                                //pop loading circle-----------------
                                //go back to menu page
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MenuPage(),
                                  ),
                                );
                              });
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
          ],
        ),
      ),
    );
  }
}
