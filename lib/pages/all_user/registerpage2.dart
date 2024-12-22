import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/images/assets.dart';
import 'package:fyp/pages/all_user/loginpage.dart';
import 'package:fyp/pages/all_user/verifyemailpage.dart';
import 'package:fyp/services/auth/auth_service.dart';
import '../../components/general/my_textfield.dart';

class Register2Page extends StatefulWidget {
  final String email;
  final String password;
  final String fname;
  final String lname;
  final String type;
  final String shop;
  final String phone;
  final bool passStrength;

  const Register2Page({
    super.key,
    required this.email,
    required this.password,
    required this.fname,
    required this.lname,
    required this.type,
    required this.shop,
    required this.phone,
    required this.passStrength,
  });

  @override
  State<Register2Page> createState() => _Register2PageState();
}

class _Register2PageState extends State<Register2Page> {
  final MyScaffoldmessage scaffoldOBJ = MyScaffoldmessage(); //for scaffold message
  final Logo show = Logo(); //for logo
  final load = Loading();
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

  Future<User?> register({
    //for creting user
    required String email,
    required String password,
  }) async {
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
    return user;
  }

  //uppercase first letter-----------------------------------------
  String upperCase(String toEdit) {
    return toEdit[0].toUpperCase() + toEdit.substring(1).toLowerCase();
  }
  //uppercase first letter-----------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1a271),
      body: SingleChildScrollView(
        child: Container(
          decoration: show.showLogo(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80), //to replace safearea
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

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          "Fill in these information",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //go back button
                          MaterialButton(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Text(
                                  "Go back",
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),

                          //sign up button
                          MaterialButton(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(40),
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

                              //checking if it is blank
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
                                scaffoldOBJ.scaffoldmessage(error, context);
                                return;
                              } else {
                                // loading circle-----
                                load.loading(context);
                                //--------------------
                                try {
                                  User? user = await register(email: widget.email, password: widget.password);

                                  var userFF = FirebaseFirestore.instance.collection('users'); //opening user collection in firestore

                                  user?.updatePhotoURL(defProfile); //set default user pfp
                                  //name the userfile as uid
                                  userFF.doc(user?.uid).set({
                                    //set all data that user and owner have in common
                                    "fname": widget.fname.trim(),
                                    "lname": widget.lname.trim(),
                                    "phone": widget.phone.trim(),
                                    "type": widget.type,
                                    "passStrength": true, //checked hence true
                                    //for category edit assist
                                    "currentdir": "",
                                    "address": address1Controller.text.trim() +
                                        ", " +
                                        postcodeController.text.trim() +
                                        ", " +
                                        stateController.text.trim(), //for delivery
                                  }).then((onValue) {
                                    if (widget.type == 'owner') {
                                      userFF.doc(user?.uid).set(
                                          //add other data that only owner have
                                          {
                                            'shop': upperCase(widget.shop.trim()),
                                            //owner need array of categories
                                            "categories": [],
                                          },
                                          SetOptions(merge: true));
                                    }
                                  }).then((onValue) {
                                    Navigator.of(context).pop();
                                    // pop loading circle if success register
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => const VerifyEmailPage(),
                                        settings: const RouteSettings(name: "/"),
                                      ),
                                      (r) => false,
                                    );
                                  });
                                } catch (e) {
                                  Future.delayed(const Duration(seconds: 2), () {
                                    Navigator.pop(context);
                                    //pop loading circle if fail
                                    scaffoldOBJ.scaffoldmessage("Fail to register", context);
                                    setState(() {});
                                  });
                                }
                              }
                            },
                          ),
                        ],
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
                            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())),
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
    );
  }
}
