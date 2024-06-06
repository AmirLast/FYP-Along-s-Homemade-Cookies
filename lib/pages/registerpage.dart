import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/images/assets.dart';
import 'package:fyp/pages/loginpage.dart';
import 'package:fyp/pages/verifyemailpage.dart';
import 'package:fyp/services/auth/auth_service.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//text editing controller
  late TextEditingController confirmpasswordController;
  late bool confirmpasswordVisibility;
  late TextEditingController emailController;
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late bool passwordVisibility;
  String type = "user";

  @override
  void initState() {
    super.initState();
    confirmpasswordController = TextEditingController();
    emailController = TextEditingController();
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    confirmpasswordController.dispose();
    emailController.dispose();
    fnameController.dispose();
    lnameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 56), //to replace safearea
            //title of current widget
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 32,
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
                      "Fill in the information",
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 60),

                    //username
                    //first name
                    MyTextField(
                      controller: fnameController,
                      caps: TextCapitalization.words,
                      inputType: TextInputType.name,
                      labelText: "Firstname",
                      obscureText: false,
                    ),

                    const SizedBox(height: 30),

                    //last name
                    MyTextField(
                      controller: lnameController,
                      caps: TextCapitalization.words,
                      inputType: TextInputType.name,
                      labelText: "Lastname",
                      obscureText: false,
                    ),

                    const SizedBox(height: 30),

                    //phone number
                    MyTextField(
                      controller: phoneController,
                      caps: TextCapitalization.none,
                      inputType: TextInputType.number,
                      labelText: "Phone Number",
                      obscureText: false,
                    ),

                    const SizedBox(height: 30),

                    //email
                    MyTextField(
                      controller: emailController,
                      caps: TextCapitalization.none,
                      inputType: TextInputType.emailAddress,
                      labelText: "Email",
                      obscureText: false,
                    ),

                    const SizedBox(height: 30),

                    //password
                    MyTextField(
                      controller: passwordController,
                      caps: TextCapitalization.none,
                      inputType: TextInputType.visiblePassword,
                      labelText: "Password",
                      obscureText: true,
                    ),

                    const SizedBox(height: 30),

                    //confirm password
                    MyTextField(
                      controller: confirmpasswordController,
                      caps: TextCapitalization.none,
                      inputType: TextInputType.visiblePassword,
                      labelText: "Confirm Password",
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    Column(
                      children: [
                        RadioListTile(
                          title: const Text("User"),
                          value: "user",
                          groupValue: type,
                          onChanged: (value) {
                            setState(() {
                              type = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text("Owner"),
                          value: "owner",
                          groupValue: type,
                          onChanged: (value) {
                            setState(() {
                              type = value.toString();
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 60),

                    //sign up button
                    MaterialButton(
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (passwordController.text !=
                            confirmpasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Passwords don\'t match!',
                              ),
                            ),
                          );
                          return;
                        }

                        //creating user firebaseauth and firestore storage---------
                        var isBlank = false;
                        String error = "";
                        User? user;

                        //checking if it is blank or wrong length
                        if (fnameController.text == '') {
                          error = 'First name is blank';
                          isBlank = true;
                        } else if (lnameController.text == '') {
                          error = 'Last name is blank';
                          isBlank = true;
                        } else if (emailController.text == '') {
                          error = 'Email is blank';
                          isBlank = true;
                        } else if (passwordController.text == '') {
                          error = 'Password is blank';
                          isBlank = true;
                        } else if (confirmpasswordController.text == '') {
                          error = 'Re-enter password is blank';
                          isBlank = true;
                        } else if (phoneController.text == '') {
                          error = 'Phone number is blank';
                          isBlank = true;
                        } else if (phoneController.text.length < 10) {
                          error = 'Phone number should be more than 10 numbers';
                          isBlank = true;
                        }

                        //if there is error, show it and don't sign up
                        if (isBlank) {
                          isBlank = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                error,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                          return;
                        } else {
                          // try { register the user
                          user = await register(
                              email: emailController.text,
                              password: passwordController.text);
                          // } on FirebaseAuthException catch (e) {
                          //   setState(() {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text(
                          //           (e.code == "invalid-email")
                          //               ? "Invalid email input"
                          //               : e.message.toString(),
                          //           textAlign: TextAlign.center,
                          //         ),
                          //       ),
                          //     );
                          //   });
                          // }

                          var userSU = FirebaseFirestore.instance.collection(
                              'users'); //opening user collection in firestore

                          //setting new user database
                          String fullName =
                              fnameController.text + ' ' + lnameController.text;

                          user!.updatePhotoURL(
                              defProfile); //set default user pfp
                          userSU.doc(user.uid).set({
                            //name the userfile as uid
                            "name": fullName,
                            "phone": phoneController.text,
                            "type": type, // kene ikut apa user pilih
                          });

                          await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VerifyEmailPage(),
                            ),
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
    );
  }
}
