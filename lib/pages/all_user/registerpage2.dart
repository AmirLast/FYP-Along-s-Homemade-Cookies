//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:fyp/images/assets.dart';
import 'package:fyp/pages/all_user/loginpage.dart';
import 'package:fyp/pages/all_user/verifyemailpage.dart';
//import 'package:fyp/services/auth/auth_service.dart';
//import 'package:fyp/services/auth/checkpass.dart';
import '../../components/my_textfield.dart';

class Register2Page extends StatefulWidget {
  const Register2Page({super.key});

  @override
  State<Register2Page> createState() => _Register2PageState();
}

class _Register2PageState extends State<Register2Page> {
//text editing controller
  late TextEditingController address1Controller;
  late TextEditingController postcodeController;
  late TextEditingController stateController;

  @override
  void initState() {
    super.initState();
    address1Controller = TextEditingController();
    postcodeController = TextEditingController();
    stateController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    address1Controller.dispose();
    postcodeController.dispose();
    stateController.dispose();
  }

/*
  Future<User?> register({
    //for creting user
    required String email,
    required String password,
  }) async {
    // loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // get auth service
    final _authService = AuthService();
    User? user;
    //create user
    await _authService.signUpWithEmailPassword(
      email,
      password,
      context,
    );
    user = _authService.getCurrentUser();

    Navigator.of(context).pop(); // pop loading circle

    return user;
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Container(
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
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 60), //to replace safearea
                //title of current widget
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 25),

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
                          "Fill in these information",
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),

                        const SizedBox(height: 60),

                        //username
                        //first name
                        MyTextField(
                          controller: address1Controller,
                          caps: TextCapitalization.words,
                          inputType: TextInputType.text,
                          labelText: "Address",
                          hintText: "",
                          obscureText: false,
                          isEnabled: true,
                        ),

                        const SizedBox(height: 30),

                        //last name
                        MyTextField(
                          controller: postcodeController,
                          caps: TextCapitalization.none,
                          inputType: TextInputType.number,
                          labelText: "Post Code",
                          hintText: "",
                          obscureText: false,
                          isEnabled: true,
                        ),

                        const SizedBox(height: 30),

                        //shop name
                        MyTextField(
                          controller: stateController,
                          caps: TextCapitalization.words,
                          inputType: TextInputType.text,
                          labelText: "State",
                          hintText: "",
                          obscureText: false,
                          isEnabled: true,
                        ),

                        const SizedBox(height: 60),

                        //sign up button
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
                                "Sign Up",
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
                            //some value for error checking---------
                            var isBlank = false; //blank means no error
                            String error = ""; //the error description
                            //User? user;

                            //checking if it is blank or wrong length or password weak
                            if (address1Controller.text == '') {
                              error = 'Address is blank';
                              isBlank = true;
                            } else if (postcodeController.text == '') {
                              error = 'Post Code is blank';
                              isBlank = true;
                            } else if (stateController.text == '') {
                              error = 'State is blank';
                              isBlank = true;
                            }

                            //if there is error, show it and don't sign up
                            if (isBlank) {
                              isBlank = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Text(
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    error,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              return;
                            } else {
                              /* belum tau nak buat cane lagi
                              // try { register the user
                              user = await register(
                                  email: emailController.text,
                                  password: passwordController.text);

                              var userSU = FirebaseFirestore.instance.collection(
                                  'users'); //opening user collection in firestore

                              user!.updatePhotoURL(
                                  defProfile); //set default user pfp

                              if (type == 'owner') {
                                //name the userfile as uid
                                userSU.doc(user.uid).set({
                                  "fname": fnameController.text,
                                  "lname": lnameController.text,
                                  "phone": phoneController.text,
                                  "type": type,
                                  "passStrength": true, //checked hence true
                                  //owner need array of categories
                                  "categories": [],
                                  //for category edit assist
                                  "currentdir": "",
                                  "shop": shopController.text,
                                  "address": "", //for delivery
                                });
                              } else {
                                //this will be user
                                //name the userfile as uid
                                userSU.doc(user.uid).set({
                                  "fname": fnameController.text,
                                  "lname": lnameController.text,
                                  "phone": phoneController.text,
                                  "type": type,
                                  "passStrength": true, //checked hence true
                                  //for admin = editing shop of owner @ editing user
                                  //for user = save id of owner for buying
                                  "currentdir": "",
                                  "address": "", //for delivery
                                });
                              }*/

                              await Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const VerifyEmailPage(),
                                ),
                                (r) => false,
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 25),

                        //to login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage())),
                              child: Text(
                                "Click here to Login",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
