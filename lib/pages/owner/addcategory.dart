import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_textfield.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/services/auth/auth_service.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
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
        title: const Center(
          child: Text(
            textAlign: TextAlign.center,
            "Category",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
      body: Container(
        width: MediaQuery.of(context).size.width, //max width for current phone
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
          mainAxisAlignment: MainAxisAlignment.center,
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

                    //name of category
                    MyTextField(
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
                    MaterialButton(
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.black,
                              content: Text(
                                "Category name is blank",
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
                          // loading circle-------------------------
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          //uppercase every first letter for each word
                          List<String> words = nameController.text.split(" ");
                          String capitalizedSentence =
                              words.map((word) => upperCase(word)).join(" ");
                          User? user = AuthService().getCurrentUser();
                          //cane nak cek collection tu dah ade sama nama ke???
                          //update local userclass data (+ new category)
                          UserNow.usernow!.categories.add(capitalizedSentence);
                          //map userclass data pasal categories
                          List newArray = UserNow.usernow!.categories;
                          //update array categories (xde prod) data kat FBFS
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user?.uid)
                              .update({
                            "categories": newArray,
                          });
                          //new collection is automatically create when add product :D

                          await Future.delayed(const Duration(seconds: 2), () {
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
