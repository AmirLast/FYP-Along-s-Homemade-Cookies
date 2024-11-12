//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/userclass.dart';
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
      backgroundColor: const Color(0xffd1a271),
      body: SingleChildScrollView(
        child: Container(
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
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 60), //to replace safearea
                //title of current widget
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 25),

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
                          "Fill in these information",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
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
                          isShowhint: false,
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
                          isShowhint: false,
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
                          isShowhint: false,
                        ),

                        const SizedBox(height: 60),

                        //sign up button
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
                                "Sign Up",
                                style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade400,
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
                              User user = UserNow.usernow!.user;
                              var userSU = FirebaseFirestore.instance.collection(
                                  'users'); //opening user collection in firestore
                              //name the userfile as uid
                              userSU.doc(user.uid).update({
                                "address": address1Controller.text +
                                    ", " +
                                    postcodeController.text +
                                    ", " +
                                    stateController.text,
                              });

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
                            const Text(
                              "Already have an account?",
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage())),
                              child: const Text(
                                "Click here to Login",
                                style: TextStyle(
                                  color: Colors.black,
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
