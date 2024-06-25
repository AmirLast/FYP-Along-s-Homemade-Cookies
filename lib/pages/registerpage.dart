import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/images/assets.dart';
import 'package:fyp/pages/loginpage.dart';
import 'package:fyp/pages/verifyemailpage.dart';
import 'package:fyp/services/auth/auth_service.dart';
import 'package:fyp/services/auth/checkpass.dart';
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
  late bool passwordVisibility; //for?
  late TextEditingController shopController;
  bool isOwner = false; //default value
  String type = "user"; //default value

  @override
  void initState() {
    super.initState();
    confirmpasswordController = TextEditingController();
    emailController = TextEditingController();
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    shopController = TextEditingController();
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
    shopController.dispose();
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
                          inputType: TextInputType.text,
                          labelText: "Firstname",
                          obscureText: false,
                          isEnabled: true,
                        ),

                        const SizedBox(height: 30),

                        //last name
                        MyTextField(
                          controller: lnameController,
                          caps: TextCapitalization.words,
                          inputType: TextInputType.text,
                          labelText: "Lastname",
                          obscureText: false,
                          isEnabled: true,
                        ),

                        const SizedBox(height: 30),

                        //shop name
                        MyTextField(
                          controller: shopController,
                          caps: TextCapitalization.words,
                          inputType: TextInputType.text,
                          labelText: "Shop Name",
                          obscureText: false,
                          isEnabled: isOwner,
                        ),

                        const SizedBox(height: 30),

                        //phone number
                        MyTextField(
                          controller: phoneController,
                          caps: TextCapitalization.none,
                          inputType: TextInputType.number,
                          labelText: "Phone Number",
                          obscureText: false,
                          isEnabled: true,
                        ),

                        const SizedBox(height: 30),

                        //email
                        MyTextField(
                          controller: emailController,
                          caps: TextCapitalization.none,
                          inputType: TextInputType.emailAddress,
                          labelText: "Email",
                          obscureText: false,
                          isEnabled: true,
                        ),

                        const SizedBox(height: 30),

                        //password
                        MyTextField(
                          controller: passwordController,
                          caps: TextCapitalization.none,
                          inputType: TextInputType.visiblePassword,
                          labelText: "Password",
                          obscureText: true,
                          isEnabled: true,
                        ),

                        const SizedBox(height: 30),

                        //confirm password
                        MyTextField(
                          controller: confirmpasswordController,
                          caps: TextCapitalization.none,
                          inputType: TextInputType.visiblePassword,
                          labelText: "Confirm Password",
                          obscureText: true,
                          isEnabled: true,
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
                                  isOwner = false;
                                  shopController.clear();
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
                                  isOwner = true;
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

                            //some value for error checking---------
                            var isBlank = false; //blank means no error
                            String error = ""; //the error description
                            User? user;

                            //check password strength
                            List passStrength = [
                              false,
                              false,
                              false,
                              false
                            ]; //false for 4 category
                            //check password strength
                            final obj = PasswordStrength();
                            passStrength = obj.checkpass(
                                password: passwordController.text);

                            //checking if it is blank or wrong length or password weak
                            if (fnameController.text == '') {
                              error = 'First name is blank';
                              isBlank = true;
                            } else if (lnameController.text == '') {
                              error = 'Last name is blank';
                              isBlank = true;
                            } else if (shopController.text == '' && isOwner) {
                              error = 'Shop name is blank';
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
                              error =
                                  'Phone number should be more than 10 numbers';
                              isBlank = true;
                            } else if (!passStrength[2]) {
                              error =
                                  'Please add special character in password';
                              isBlank = true;
                            } else if (!passStrength[3]) {
                              error = 'Please add number in password';
                              isBlank = true;
                            } else if (passwordController.text.length < 10) {
                              error =
                                  'Password should be at least 10 in length';
                              isBlank = true;
                            } else if (!(passStrength[0] && passStrength[1])) {
                              error =
                                  'Password should combine lower and upper case';
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
                              }

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
