import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_textfield.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/services/auth/auth_service.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  Widget build(BuildContext context) {
    //text editing controller
    final nameController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Center(
          child: Text(
            textAlign: TextAlign.center,
            "Category",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: const MyDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width, //max width for current phone
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

                    //name of category
                    MyTextField(
                      controller: nameController,
                      caps: TextCapitalization.words,
                      inputType: TextInputType.text,
                      labelText: "Name",
                      obscureText: false,
                      isEnabled: true,
                    ),

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
                                color: Theme.of(context).colorScheme.secondary,
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
                                  "Category name is blank",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            return;
                          } else {
                            User? user = AuthService().getCurrentUser();
                            //cane nak cek collection tu dah ade sama nama ke?
                            //make a collection(category)
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user?.uid)
                                .collection(nameController.text);
                            //testing
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user?.uid)
                                .update({
                              "category": nameController.text,
                            });
                            /*
                            //update new category in owner List categories
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user?.uid)
                                .update({
                              "categories": nameController.text,
                            });
                            */
                            //the doc = product in that category, doc id = name of product,
                            //in doc = all values of product ; cek sample in cookies collection
                            await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MenuPage(), //go back to menu page
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
    );
  }
}
