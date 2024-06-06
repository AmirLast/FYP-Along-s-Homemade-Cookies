import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_textfield.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/forgorpassword.dart';
import 'package:fyp/pages/registerpage.dart';
import 'package:fyp/pages/verifyemailpage.dart';
import 'package:fyp/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // login user
  static Future<User?> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    //authenticating
    final _authService = AuthService();
    User? user;

    // loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    await _authService.signInWithEmailPassword(
      email,
      password,
      context,
    );
    user = _authService.getCurrentUser();

    Navigator.of(context).pop(); // pop loading circle if success

    return user;
  }

  @override
  Widget build(BuildContext context) {
    //text editing controller
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //title of current widget
          Text(
            "Sign In",
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
                    "Insert Email and Password",
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 60),

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

                  const SizedBox(height: 60),

                  MaterialButton(
                    onPressed: () async {
                      User? user = await login(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context);
                      var dir = FirebaseFirestore.instance.collection('users');
                      await dir.doc(user!.uid).get().then((value) {
                        //containing user data into a class so we don't need database delay
                        UserNow.usernow = UserNow(
                          value.data()?['name'],
                          value.data()?['phone'],
                          user,
                          value.data()?['type'],
                        );
                      });
                      //how to make different user go to different page? <- cancelled
                      //make them verify first, verify page will handle diff user routing
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const VerifyEmailPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  InkWell(
                    child: const Text(
                      "Forgot password?",
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgorPassword()));
                    },
                  ),

                  const SizedBox(height: 25),

                  //register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have no account?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterPage())), //goto Register
                        child: Text(
                          "Click here to Register",
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
        ],
      ),
    );
  }
}
